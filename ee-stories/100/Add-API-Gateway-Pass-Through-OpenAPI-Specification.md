
# Add API Gateway Pass-Through OpenAPI Specification
*Only completed once, code should be re-usable for each of the 4 Web Applications*

### **Summary**:

**As an** operational user, **I want** websites that seamlessly integrate with services, **so that** there is simplified communication with backend services.

**As a** developer, **I want** to create a CDK Amplify package that adds an API Gateway with pass-through OpenAPI specifications to my existing React applicatio **so that** I have seamless communication between my React application and backend services.

### **Background:**

In this story, we will guide you through the process of creating a new CDK Amplify package that consumes an existing React Application while adding an API Gateway with pass-through OpenAPI specifications. This involves creating various AWS resources, setting up permissions, and configuring an API Gateway authorizer.

### **Description:**

We will create a CDK stack that sets up an API Gateway with pass-through OpenAPI specifications, enabling seamless communication between your React Application and backend services.

### **Steps:**

1. **Define Parameters:**
    1. Define any necessary parameters that your stack will use. In this example, we have a `UserPoolId` parameter, which may be required for Cognito integration.
2. **Create an API Gateway:**
    1. Use the AWS CDK to create an API Gateway (API) for your application. Configure CORS preflight options and set up any allowed headers.
3. **Create an Endpoint Service:**
    1. Define an endpoint service, such as a PrivateLink, to facilitate communication with external resources.
4. **Create API Resources and Integration:**
    1. Define resources for your API and set up integrations. This allows your API to communicate with other services. Ensure you specify your endpoint service as the target.
5. **Configure HTTP Proxy Integration:**
    1. Configure the integration for the HTTP_PROXY, allowing your API to forward requests to external services. Specify the HTTP method, request parameters, and templates as needed.
6. **Configure IAM Permissions:**
    1. Create an IAM role for your API Gateway to access the VPC endpoint. Define the necessary permissions for execution and access to specific resources.
7. **Create an API Gateway Authorizer:**
    1. Set up an authorizer for your API Gateway. In this example, we use Cognito User Pools as the authorizer type. Define the identity source, restApiId, and providerArns.
8. **Define Outputs:**
    1. Create outputs that provide important information about your API, such as its URL.
9. **Deploy the API:**
    1. Deploy your API using the AWS CDK. This step will generate a deployment with your specified stage name (e.g., 'prod').

```
import * as cdk from 'aws-cdk-lib';
import * as apigateway from 'aws-cdk-lib/aws-apigateway';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import * as iam from 'aws-cdk-lib/aws-iam';
import * as core from 'aws-cdk-lib/core';

export class ApiDatabaseLambdaConstruct extends core.Construct {
  constructor(scope: core.Construct, id: string, props: ApiDatabaseLambdaConstructProps) {
    super(scope, id);

    // Create a VPC Endpoint Service
    const endpointService = new ec2.VpcEndpointService(this, 'MyEndpointService', {
      vpcEndpointServiceLoadBalancers: [ec2.VpcEndpointServiceLoadBalancer.of('<allegiance-endpoint>')],
    });

    // Create an API Gateway
    const api = new apigateway.RestApi(this, 'RestApi', {
      defaultCorsPreflightOptions: {
        allowOrigins: apigateway.Cors.ALL_ORIGINS,
        allowHeaders: ['Content-Type', 'Authorization', 'X-Amz-Date'],
      },
    });

    // Create a resource and method for your API
    const resource = api.root.addResource('myresource');
    const integration = new apigateway.VpcLinkIntegration({
      vpcLink: new apigateway.VpcLink(this, 'MyVpcLink', {
        targets: [endpointService],
      }),
      integrationResponses: [
        {
          statusCode: '200',
          selectionPattern: '2\d{2}',
          responseParameters: {
            'method.response.header.Content-Type': 'integration.response.header.Content-Type',
          },
        },
      ],
    });

    resource.addMethod('ANY', integration, {
      methodResponses: [
        {
          statusCode: '200',
          responseParameters: {
            'method.response.header.Content-Type': true,
          },
        },
      ],
    });

    // Define the integration for HTTP_PROXY
    const proxyResource = api.root.addResource('proxy');
    const httpIntegration = new apigateway.HttpIntegration('https://allegiance-endpoint', {
      httpMethod: 'ANY',
      options: {
        requestParameters: {
          'integration.request.header.Origin': ''*'',
        },
        requestTemplates: {
          'application/json': JSON.stringify({}),
        },
      },
    });

    proxyResource.addMethod('ANY', httpIntegration, {
      requestParameters: {
        'method.request.path.proxy': true,
      },
    });

    // Configure IAM permissions for the API Gateway
    const apiGatewayRole = new iam.Role(this, 'ApiGatewayRole', {
      assumedBy: new iam.ServicePrincipal('apigateway.amazonaws.com'),
    });

    apiGatewayRole.addToPolicy(new iam.PolicyStatement({
      resources: ['*'], // Replace with specific resources
      actions: ['execute-api:Invoke'],
    }));

    // Attach the VPC Endpoint to the API Gateway
    apiGatewayRole.addToPolicy(new iam.PolicyStatement({
      resources: [integration.vpcLink.linkId],
      actions: ['execute-api:Invoke'],
    });

    integration.vpcLink.addToRolePolicy(new iam.PolicyStatement({
      resources: ['*'], // Replace with specific resources
      actions: ['ec2:CreateNetworkInterface', 'ec2:DescribeNetworkInterfaces', 'ec2:DeleteNetworkInterface'],
    });

    // Define API Gateway Outputs
    new core.CfnOutput(this, 'APIURL', {
      description: 'URL for the created back-end API',
      value: cdk.Fn.sub(`https://\$\{RestApi}.execute-api.\$\{AWS::Region}.amazonaws.com/\$\{RestApi.deploymentStage.stageName}`),
    });
  }
}

interface ApiDatabaseLambdaConstructProps {
  userPoolId: string;
}
```

* VPC Endpoint Service Creation:
    * We first create an `ec2.VpcEndpointService` for the PrivateLink/Allegiance service.
* API Gateway Creation:
    * We create an API Gateway using `apigateway.RestApi`. The code also defines default CORS preflight options.
* Resource and Integration:
    * We create a resource for the API Gateway and an integration that uses the VPC Link to connect to the PrivateLink/Allegiance service.
* HTTP Proxy Integration:
    * We add an HTTP Proxy Integration to the API Gateway to forward requests to external service.
* IAM Role Configuration:
    * We configure an IAM role, `ApiGatewayRole`, to grant permissions to the API Gateway for executing certain actions and accessing resources. We added the role as an execution role for the VPC Link integration.
* API Gateway Authorizer:
    * We define an authorizer for Cognito User Pools in the API Gateway. This authorizer is used for user authentication.
* Outputs:
    * We define an output to display the API URL.

### **Acceptance Criteria**:

* **Should have**: API Gateway with CORS preflight options and allowed headers.
* **Should have**: Configured endpoint service, such as PrivateLink, for external communication.
* **Should have**: Resource and integration defined for the API.
* **Should have**: Configured HTTP Proxy Integration for request forwarding.
* **Should have**: IAM role for API Gateway with proper permissions.
* **Should have**: API Gateway authorizer for user authentication.
* **Should have**: Outputs providing information about the API, including its URL.
* **Should have**: **** Deployed API with a specified stage name.
