
# Configure Identity Provider in CDK Amplify Package
*Only completed once, code should be re-usable for each of the 4 Web Applications*

### **Summary:**

**As an** operational user, **I want** to configure the identity provider to **so that** there is secure user authentication and authorization through an external identity provider, enhancing security.

**As a** developer, **I want** to configure the identity provider in the CDK Amplify package **so that** user authentication and authorization can be secured through an external identity provider for the CDK Amplify application.

### **Background:**

The identity provider configuration is essential for securing your CDK Amplify application. Here are the necessary steps and code snippets to set up the identity provider.

### **Steps:**

1. **Identity Provider Configuration:**
2. Modify the User Pool created in CDK in the Static Portal Construct.
3. Configure the Identity Provider under Federation.

    * Set it to OpenID Connect.

1. Fill in each CDK Field accordingly:

    * Provider name: '
    * Client ID: Use a unique string for Federate identification.
    * Client secret: Leave blank for retrieval during Service Profile creation on Federate Enrollment Portal.
    * Attribute request method: GET
    * Authorization scope: openid
    * Issuer:
        * Integ: [https://idp-integ.federate.amazon.com](https://idp-integ.federate.amazon.com/) (for testing)
        * Prod: [https://idp.federate.amazon.com](https://idp.federate.amazon.com/) (for production)

```

    // Parameters
    const userPoolId = new core.CfnParameter(this, 'UserPoolId', {
      type: 'String',
      description: 'Id for the user pool.',
    });

    const userPoolDomain = new core.CfnParameter(this, 'UserPoolDomain', {
      type: 'String',
      description: 'User pool full domain name.',
    });

    // User Pool Client
    const userPoolClientWeb = new cognito.CfnUserPoolClient(this, 'UserPoolClientWeb', {
      clientName: `$\{this.stackName}_ClientWeb`,
      userPoolId: userPoolId.valueAsString,
      allowedOAuthFlows: ['code'],
      allowedOAuthFlowsUserPoolClient: true,
      allowedOAuthScopes: ['phone', 'email', 'openid', 'profile', 'aws.cognito.signin.user.admin'],
      callbackUrLs: [cloudFrontDistrib.distributionDomainName, 'https://localhost:8080'],
      logoutUrLs: [cloudFrontDistrib.distributionDomainName, 'https://localhost:8080'],
      generateSecret: false,
      refreshTokenValidity: 30,
      supportedIdentityProviders: ['COGNITO'],
    });

    // Outputs
    new core.CfnOutput(this, 'WebsiteDomain', {
      value: cloudFrontDistrib.distributionDomainName,
      description: 'Domain where the website is accessible.',
    });

    new core.CfnOutput(this, 'WebsiteS3Bucket', {
      value: websiteS3Bucket.bucketName,
      description: 'Bucket where to upload the website content.',
    });

    new core.CfnOutput(this, 'UserPoolAppClientId', {
      value: userPoolClientWeb.ref,
      description: 'The user pool app client id',
    });
```

1. You will need to find the OpenID endpoints to fill in.
2. **Attribute Mapping:**
3. In the User Pool Construct, add Attribute Mappings.

    * Add OIDC and then add the Provider from above.

1. Add the following mapping, the OIDC attributes:

    * sub → Username
    * GIVEN_NAME → Given Name
    * FAMILY_NAME → Family Name
    * EMAIL → Email

Configure attribute mappings for the identity provider.
Configure the app client for the user pool.

```
userPool.addDomain('UserPoolDomain', {
  cognitoDomain: {
    domainPrefix: 'your-user-pool-domain',
  },
});

const appClient = userPool.addClient('AppClient', {
  client: userPoolClientWeb,
  authFlows: {
    userPassword: true,
  },
});
```

1. **User Pool App Client:**
2. Still in the User Pool Construct, enable Identity Providers by adding the Identity Provider created.

Please note that when using an external Identity Provider, it's possible to skip the Cognito Login UI. You'll need to use the `/authorize` endpoint instead of the `/login` endpoint, and this only works if only one Identity Provider is activated in the UserPool.

Make sure to customize the parameters as needed for your specific use case. This configuration is crucial for securing your CDK Amplify application with an external Identity Provider.

#### Create Bucket Policy and Attach

From the above, we now need to create and attach a bucket policy

```
    // S3 Bucket
    const websiteS3Bucket = new s3.Bucket(this, 'WebsiteS3Bucket');

    // S3 Bucket Policy
    const websiteS3BucketPolicy = new s3.BucketPolicy(this, 'WebsiteS3BucketPolicy', {
      bucket: websiteS3Bucket,
      statements: [
        new iam.PolicyStatement({
          actions: ['s3:GetObject'],
          effect: iam.Effect.ALLOW,
          principals: [new iam.CanonicalUserPrincipal('your-canonical-user-id')],
          resources: [websiteS3Bucket.arnForObjects('/*')],
        }),
      ],
    });

    // CloudFront Origin Access Identity
    const cloudFrontIdentity = new cloudfront.CfnCloudFrontOriginAccessIdentity(
      this,
      'CloudFrontIdentity',
      {
        cloudFrontOriginAccessIdentityConfig: {
          comment: 'Origin Access Identity for the S3 Bucket',
        },
      }
    );

    // CloudFront Distribution
    const cloudFrontDistrib = new cloudfront.CloudFrontWebDistribution(
      this,
      'CloudFrontDistrib',
      {
        originConfigs: [
          {
            s3OriginSource: {
              s3BucketSource: websiteS3Bucket,
              originAccessIdentity: cloudFrontIdentity.cloudFrontOriginAccessIdentityS3CanonicalUserId,
            },
            behaviors: [
              {
                isDefaultBehavior: true,
                lambdaFunctionAssociations: [
                  {
                    eventType: cloudfront.LambdaEdgeEventType.VIEWER_REQUEST,
                    lambdaFunction: new lambda.Function(this, 'EdgeAuthFunction', {
                      runtime: lambda.Runtime.NODEJS_14_X,
                      handler: 'index.handler',
                      code: lambda.Code.fromAsset('./src'),
                      role: new iam.Role(this, 'EdgeAuthFunctionRole', {
                        assumedBy: new iam.CompositePrincipal(
                          new iam.ServicePrincipal('lambda.amazonaws.com'),
                          new iam.ServicePrincipal('edgelambda.amazonaws.com')
                        ),
                        managedPolicies: [
                          iam.ManagedPolicy.fromAwsManagedPolicyName('service-role/AWSLambdaBasicExecutionRole'),
                        ],
                      }),
                      autoPublishAlias: 'LambdaAlias',
                    }),
                  },
                ],
              },
            ],
          },
        ],
        errorConfigurations: [
          {
            errorCode: 404,
            responseCode: 200,
            responsePagePath: '/index.html',
          },
          {
            errorCode: 403,
            responseCode: 200,
            responsePagePath: '/index.html',
          },
        ],
        defaultRootObject: 'index.html',
        viewerProtocolPolicy: cloudfront.ViewerProtocolPolicy.REDIRECT_TO_HTTPS,
      }
    );

    // Lambda Configuration Parameter
    new ssm.StringParameter(this, 'LambdaConfigParameter', {
      parameterName: `/$\{cloudFrontDistrib.distributionId}/$\{cloudFrontDistrib.distributionVersion}/config`,
      stringValue: JSON.stringify({
        region: cdk.Aws.REGION,
        userPoolId: userPoolId.valueAsString,
        userPoolAppId: 'YourUserPoolAppId', // You need to specify the App Id
        userPoolDomain: userPoolDomain.valueAsString,
      }),
    });
  }
```

Please note the following:

1. The canonical user ID in the `BucketPolicy` should be replaced with the actual canonical user ID. You can retrieve it from the CloudFrontIdentity.
2. The `userPoolAppId` in the Lambda Configuration Parameter should be specified with your actual User Pool App Client ID.

This AWS CDK (Cloud Development Kit) code sets up an AWS infrastructure for serving a website with  S3 and  CloudFront, while also configuring some additional elements. Let's break down what's happening:

1. **S3 Bucket (AmplifyW`ebsiteS3Bucket`):**
2. **S3 Bucket Policy (`websiteS3BucketPolicy`):**
    1. A bucket policy is attached to the `websiteS3Bucket` to control access to its objects.
    2. The policy allows the `s3:GetObject` action, meaning anyone can retrieve objects from this bucket.
    3. The `effect` is set to `ALLOW`, permitting the action.
    4. It specifies a `principals` element, restricting access to a specific canonical user. You should replace `'your-canonical-user-id'` with an actual canonical user ID, which is typically used when granting CloudFront access to the S3 bucket.
3. The `resources` element specifies that this policy applies to all objects (`'/*'`) within the bucket.
    1. **CloudFront Origin Access Identity (`cloudFrontIdentity`):**
    2. An Origin Access Identity (OAI) named `CloudFrontIdentity` is created.
    3. The OAI allows CloudFront to access the S3 bucket (`websiteS3Bucket`) by granting the identity permission to read objects.
4. **CloudFront Distribution (`cloudFrontDistrib`):**
    1. An  CloudFront distribution is created to serve your website.
    2. It's configured with an origin pointing to the S3 bucket (`websiteS3Bucket`) and uses the CloudFront Identity (`cloudFrontIdentity`) to access the S3 bucket.
    3. The configuration specifies default behaviors for routing viewer requests, where it associates a Lambda function (`EdgeAuthFunction`) with the `VIEWER_REQUEST` event. This Lambda function likely handles authentication or authorization checks for requests.
    4. It defines error configurations for HTTP error codes 404 and 403, directing users to `/index.html` for a client-side route in your website to handle these errors.
    5. The `defaultRootObject` specifies the default file to return when the root URL is accessed.
    6. The `viewerProtocolPolicy` redirects HTTP requests to HTTPS for added security.
5. **Lambda Configuration Parameter (`LambdaConfigParameter`):**

    * This code creates a Systems Manager (SSM) parameter with the name `LambdaConfigParameter`.
    * The parameter holds a JSON string with various configuration values used by the Lambda function, such as the AWS region, user pool ID, and user pool app ID.
    * The parameter name is constructed dynamically based on the CloudFront distribution's ID and version.

This code is a comprehensive example of using AWS CDK to set up a static website with additional configurations, for Lambda@Edge functions.


### **Acceptance Criteria:**


* **Should have:** Identity Provider set to OpenID Connect.
* **Should have:** CDK fields filled with specified values for the identity provider.
* **Should have:** Attribute mappings correctly configured in the User Pool Construct.
* **Should have:** User Pool Domain associated with Cognito User Pool.
* **Should have:** App Client correctly configured to NOT support userPassword auth flows.
* **Should have:** Identity Provider successfully added to the User Pool App Client.
* **Should have:** External Identity Provider usage enabled.
* **Should have:** S3 Bucket and bucket policy successfully created and attached.
* **Should have:** Canonical user ID correctly updated in the Bucket Policy.
