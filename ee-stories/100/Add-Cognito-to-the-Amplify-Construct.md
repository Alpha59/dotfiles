
# Add Cognito to the Amplify Construct
*Only completed once, code should be re-usable for each of the 4 Web Applications*

### **Summary:**

**As an** operational user, **I want** Cognito integration in the CDK Amplify Construct **so that** I have secure user access, simplifying user authentication and identity provider functionality.

**As a** developer, **I want** to add Cognito integration to the CDK Amplify Construct to enable user authentication and OIDC identity provider functionality for the Amplify application, **so that** users can securely access the application.

### Background

Before we begin creating a CDK Amplify package to consume an existing React application, we need to ensure that the following prerequisites are met:


1. An AWS account with the necessary permissions.
2. AWS CDK is installed and properly configured.
3. A registered domain is available for creating a custom domain.

### Prerequisites

Before implementing the CDK code, ensure that the following prerequisites are met:

* You have an AWS account with appropriate permissions.
* AWS CDK is installed and configured.
* You have registered a domain for creating a custom domain.
*  Federate is properly set up.
* Cognito User Pool is configured for user authentication.

### Description

Lambda@Edge, integrated with CloudFront, acts like Authorizer Lambdas in API Gateway. It triggers when a request hits CloudFront, checking for a cookie, and redirecting to Auth0 if the cookie is missing. It also manages the OAuth login callback to retrieve the `id_token`, stored in a cookie.

This is part of the CloudFront CDK module, using an EdgeFunction Lambda. Manual bundling is required as auto-bundling is unsupported.

Key steps:


1. Create the EdgeFunction.
2. Configure CloudFront to use the EdgeFunction.
3. Securely store Auth0 credentials in AWS Secrets Manager.

 Federate serves as an OIDC identity provider, enabling federated access to various services, using  credentials.

**OpenID** supports federated authentication without pre-selecting providers. It offers discovery and optimized user experiences but uses HTTP URIs as identifiers.

**OAuth** eliminates password sharing, provides access tokens, but requires pre-selection of providers and lacks user identity.

Both protocols redirect users and verify assertions, with OpenID emphasizing discovery and OAuth focusing on access tokens.

In a technical context, both use redirection for user authorization but differ in signature calculation and registration requirements.

This process is part of the CloudFront CDK module, and it involves creating an EdgeFunction, configuring CloudFront to use this EdgeFunction, and storing OIDC credentials in AWS Secrets Manager.

### Create the EdgeFunction

We'll create the EdgeFunction, which is a Lambda@Edge function responsible for handling the authentication and redirection.

### Set Up  Federate

We'll use  Federate as an OIDC identity provider to authenticate users.  Federate acts as an authentication broker and leverages trusted authentication providers for industry-standard protocols.

### Configure Cognito User Pool

You'll need to configure a Cognito User Pool for user authentication. This should be configured in the CDK Code, and attached to the Cognito pool:


```
// CDK code for creating the EdgeFunction
import * as cdk from 'aws-cdk-lib';
import * as cloudfront from 'aws-cdk-lib/aws-cloudfront';
import * as lambda from 'aws-cdk-lib/aws-lambda';
import * as secretsmanager from 'aws-cdk-lib/aws-secretsmanager';
import * as core from 'aws-cdk-lib/core';
import * as cdk from 'aws-cdk-lib';
import * as cognito from 'aws-cdk-lib/aws-cognito';
import * as core from 'aws-cdk-lib/core';

export class CognitoUserPool extends Construct {
  constructor(scope: core.Construct, id: string, props?: core.StackProps) {
    super(scope, id, props);

    // Parameters
    const userPoolDomainName = new core.CfnParameter(this, 'UserPoolDomainName', {
      type: 'String',
      description: 'Domain name used to create the UserPool custom domain.',
    });

    const userPool = new cognito.UserPool(scope, 'UserPool', {
       selfSignUpEnabled: false,
       autoVerify: {
         email: true,
       },
       signInAliases: {
         email: true,
       },
     });

    const identityProvider = userPool.addClient('IdentityProvider', {
         authFlows: {
             userPassword: true,
         },
    }

    // User Pool Domain
    new cognito.UserPoolDomain(this, 'UserPoolDomain', {
      userPool,
      customDomain: {
        domainName: userPoolDomainName.valueAsString,
      },
    });

    // Outputs
    new core.CfnOutput(this, 'UserPoolId', {
      value: userPool.userPoolId,
      description: 'Id for the user pool',
    });

    new core.CfnOutput(this, 'UserPoolDomain', {
      value: core.Fn.sub('$\{UserPoolDomainName}.auth.$\{AWS::Region}.amazoncognito.com', {
        UserPoolDomainName: userPoolDomainName.valueAsString,
      }),
    });

    // Define your EdgeFunction here
    const edgeFunction = new lambda.Function(this, 'EdgeFunction', {
      // Define Lambda properties
    });

    // Your Lambda function logic goes here

    // Create a CloudFront function association
    new cloudfront.FunctionAssociation(this, 'EdgeFunctionAssociation', {
      event: cloudfront.FunctionEvent.VIEWER_REQUEST,
      function: edgeFunction,
    });

    // Store OIDC credentials in AWS Secrets Manager
    const OIDCSecret = new secretsmanager.Secret(this, ' {
      // Define secret properties
    });

    // Store your OIDC credentials in the secret
    // This is done via CLI:
    // aws secretsmanager put-secret-value     // --secret-id      // --secret-string '{\'user\':\'ailor\',\'password\':\'EXAMPLE-PASSWORD\'}'
  }
}
```

In this CDK code:

1. We import the necessary AWS CDK modules for working with Cognito and creating the CloudFormation stack.
2. We define the `CognitoUserPool` class, which extends Construct.
3. We define the `userPoolDomainName` parameter using `core.CfnParameter`. This is equivalent to the `Parameters` section in CloudFormation.
4. We create the User Pool using the `cognito.UserPool` construct and configure it with the desired settings, such as `userPoolName`, `selfSignUpEnabled`, `signInAliases`, `autoVerify`, and `mfaConfiguration`. You can modify these settings as needed.
5. We create the User Pool Domain using the `cognito.UserPoolDomain` construct, associating it with the user pool and specifying the custom domain name.
6. We define the outputs using `core.CfnOutput` to expose the User Pool ID and the User Pool Domain as stack outputs.
7. Finally, we create a new CDK app and instantiate the `CognitoUserPoolStack`, which will generate the CloudFormation stack and its resources.

[Image: image.png]
### **Acceptance Criteria:**

* **Given** the User Pool Domain is created,
    * **when** I associate it with the User Pool,
    * **then** the users in the user pool should be able to access the domain
* **Given** the CloudFront function association is created,
    * **when** I associate the EdgeFunction with CloudFront,
    * **then** user should be prompted to sign in via midway
* **Given** the OIDC credentials are stored in AWS Secrets Manager,
    * **when** I execute the code for retrieving OIDC credentials,
    * **then** the credentials should be securely retrieved in AWS Secrets Manager.
* **Given** that the EdgeFunction is in place,
    * **when** it triggers upon a request, checks for a cookie, and redirects to Auth0 if the cookie is missing,
    * **then** All cookies should be appropriately added to the request
* **Given** that the EdgeFunction manages the OAuth login callback to retrieve the id_token and store it in a cookie,
    * **when** the midway callback occurs,
    * **then** the id_token should be successfully retrieved and stored in a cookie.
* **Given** that  Federate is used as an OIDC identity provider,
    * **when** it is configured to authenticate users,
    * **then** it should act as an authentication broker
* **Should have:**  Federate properly set up.
* **Should have:** Cognito User Pool configured for user authentication
* **Should have:** EdgeFunction and User Pool successfully created.
* **Should have:** User Pool Domain associated with User Pool.
* **Should have:** EdgeFunction successfully associated with CloudFront.
* **Should have:** OIDC credentials securely stored in AWS Secrets Manager.
* **Should have:** EdgeFunction correctly triggering, checking for cookies, and redirecting to Auth0.
* **Should have:** EdgeFunction successfully managing OAuth login callback.
* **Should have:**  Federate configured for OIDC identity provider functionality.
* **Should have:**  Federate eliminating password sharing, providing access tokens, and configuring authentication providers.
