
# Create  API Gateway for Single Point of Access to Services
## Summary
[//]:# (This should be descriptive enough to frame the Story, at a high level, as well as include any additional resources needed to complete the Story.)

**AS a** non- Developer
**I WANT** an AWS API Gateway construct in CDK that acts as a proxy to multiple microservices, starting with '
**SO** that I am able to call various  services from a single point of entry

## Additional Context
[//]:# (This should be descriptive enough to frame the story as well as include any additional resources needed to accomplish the Story.)

The API Gateway should utilize 'CloudAuth' as the authorization mechanism, and the Definition for the API should be written in OpenAPI JSON format.

The API Gateway should have cross account permissions to call an ECS cluster that is in the  account, but the AWS API Gateway itself should live in the ' Account.

This gateway should be deployed as part of the ' pipeline ~~and should live in the Shared VPC~~ created by the ' Package. When completed, existing services should be able to call the API Gateway from within the corporate network, so they can access the services that are positioned behind the API Gateway through a single interface. The API Gateway should also be callable by Lambdas and ECS Clusters with the correct IAM permissions, even if they are not in the same account.

## Implementation Details

* The API Gateway should be configured to use 'CloudAuth' as the authorization mechanism
    * Achieved by adding an authorizer to the API Gateway.
* Cross-account permissions can be granted by creating a role in the  account that allows the AWS API Gateway to assume it.
* The API Gateway should be deployed as part of the ' pipeline
    * Achieved by adding the API Gateway construct to the ' Package.
* The API Definition should be written in OpenAPI JSON format and can be defined using the AWS CDK 'aws-apigatewayv2' module.
* The API Gateway should be callable by existing services from within the corporate network
    * Achieved by configuring the VPC Endpoint (Allegiance) for the API Gateway.
* The API Gateway should be callable by Lambdas and ECS Clusters with the correct IAM permissions,
    * Achieved by creating an IAM role for the Lambdas and ECS Clusters that allows them to call the API Gateway.


Here is some external Documentation:
https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-private-integration.html
https://blog.developer.adobe.com/deploy-microservices-using-aws-ecs-fargate-and-api-gateway-1b5e71129338
https://aws.plainenglish.io/connecting-api-gateway-to-ecs-fargate-using-the-aws-cdk-61519e781852
https://medium.com/analytics-vidhya/building-serverless-services-with-aws-cdk-478315b45fb8

This is an OpenAPI Example:
https://code.amazon.com/packages/

Here are some existing examples from our codebase:
https://code.amazon.com/packages/
https://code.amazon.com/packages/
https://code.amazon.com/packages/

CloudAuth:
https://code.amazon.com/packages/

Authorization:
https://code.amazon.com/packages/

Something like...

```
    import * as cdk from 'aws-cdk-lib';
    import * as apigateway from 'aws-cdk-lib/aws-apigateway';
    import * as iam from 'aws-cdk-lib/aws-iam';

    interface APIGatewayProps { clusterArns: string[]; }

    export class APIGateway extends cdk.Construct {
        constructor(scope:cdk.Construct, id: string, props: APIGatewayProps) {

     super(scope, id);

     const apiDefinition = {
       openapi: '3.0.1',
       info: {
         title: 'API Gateway',
         version: '1.0'
       },
       paths: {
         '/{proxy+}': {
           'x-amazon-apigateway-any-method': {
             'x-amazon-apigateway-integration': {
               uri: `arn:aws:apigateway:$\{cdk.Stack.of(this).region}:ecs:path/$\{props.clusterArns}/v1/{proxy}`,
               passthroughBehavior: 'when_no_match',
               httpMethod: 'POST',
               type: 'aws_proxy'
             }
           }
         }
       }
     };

     const api = new apigateway.RestApi(this, 'APIGateway', {
       restApiName: 'API Gateway',
       deployOptions: {
         stageName: 'prod'
       }
     });

     const integrationRole = new iam.Role(this,
     'APIGatewayIntegrationRole', {
       assumedBy: new iam.ServicePrincipal('apigateway.amazonaws.com')
     });

     integrationRole.addToPolicy(new iam.PolicyStatement({
       actions: ['ecs:RunTask'],
       resources: [...props.clusterArns]
     }));

     const apiResource = api.root.addResource('{proxy+}');
     const apiIntegration = new apigateway.AwsIntegration({
       service: 'ecs',
       integrationHttpMethod: 'POST',
       path: `/$\{cdk.Stack.of(this).stackName}/prod/{proxy}`,
       options: {
         credentialsRole: integrationRole,
         integrationResponses: [
           {
             statusCode: '200',
             responseTemplates: {
               'application/json': '.json('$')'
             }
           }
         ]
       }
     });

     apiResource.addMethod('ANY', apiIntegration, {
       authorizationType: apigateway.AuthorizationType.IAM,
       authorizer: null
     });

    }
}

```

## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the story. Each line starts with 'should have'.)
[//]:# (Refer to https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats for more information on Acceptance Criteria formats)

* Should have created an API Gateway using AWS CDK.
* Should have configured API Gateway to use 'CloudAuth' as the authorization mechanism.
* Should have deployed the API Gateway in the ' account and should have cross-account permissions to call an ECS cluster situated in the  account.
* Should have deployed the API Gateway as part of the ' pipeline
* Should have put the API Gateway in the Shared VPC created by the ' Package.
* Should have written the API Definition in OpenAPI JSON format.
* Should have called the API Gateway from an existing service within the corporate network.
* Should have called the API Gateway from Lambdas with the correct IAM permissions, in the same account.
* Should have called the API Gateway from ECS Clusters with the correct IAM permissions, in the same account.
* Should have called the API Gateway from Lambdas with the correct IAM permissions, not in the same account.
* Should have called the API Gateway from ECS Clusters with the correct IAM permissions, not in the same account.


