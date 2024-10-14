
# Create a standard construct for team NanoService using API gateway/SNS/SQS and Lambda
### Summary
**As a** DevOps Engineer, **I want** to create a standard construct for a team NanoService using API Gateway, SNS (Simple Notification Service), SQS (Simple Queue Service), and Lambda, **So That** the team can easily deploy services with consistent architecture that follows best practices for event-driven, serverless microservices.

This story focuses on creating a reusable, modular architecture that integrates AWS services like API Gateway, SNS, SQS, and Lambda. The construct will provide a standardized way to build microservices (NanoService) with consistent configuration, security, and scalability.

### Vision
By creating a standardized construct, we provide the team with a consistent and efficient way to deploy new NanoServices. The architecture ensures that every service follows best practices, such as event-driven design, fault tolerance with SQS, and serverless scalability with Lambda.

### Background
In a serverless architecture, integrating components like API Gateway, SNS, SQS, and Lambda is a common pattern for event-driven microservices. However, without a standard construct, each team may build services differently, leading to inconsistencies and maintenance challenges. This construct will standardize how the team builds and deploys serverless services using these AWS components.

### Purpose
The purpose of this story is to create a reusable, standardized construct that integrates API Gateway, SNS, SQS, and Lambda to form a fully functional NanoService. This will help the team create new services more quickly while ensuring that they follow best practices for serverless and event-driven architectures.

## Details
### 1. Define the Standard Architecture
The architecture of the NanoService will include the following components:
  - **API Gateway**: Serves as the entry point for HTTP requests to the NanoService.
  - **SNS**: Acts as a notification hub that handles messages coming from the API Gateway and allows for pub/sub communication between services.
  - **SQS**: Provides a queue to store messages reliably and allows for decoupling between services.
  - **Lambda**: Processes messages from the SQS queue and handles the business logic.

### Architecture Flow:
1. **API Gateway** receives HTTP requests from external clients.
2. API Gateway triggers an **SNS Topic** that notifies subscribers of the request.
3. The SNS Topic sends the message to an **SQS Queue**.
4. **Lambda** functions are triggered by SQS to process the messages and complete the required business logic.

### 2. Implement the Construct Using AWS CDK
AWS Cloud Development Kit (CDK) can be used to implement the standard construct. The CDK allows us to define our infrastructure as code, ensuring consistency across deployments.

#### Example CDK Code to Define the NanoService Construct (TypeScript):
```typescript
import * as cdk from 'aws-cdk-lib';
import * as apigateway from 'aws-cdk-lib/aws-apigateway';
import * as sns from 'aws-cdk-lib/aws-sns';
import * as sqs from 'aws-cdk-lib/aws-sqs';
import * as lambda from 'aws-cdk-lib/aws-lambda';
import * as snsSubscriptions from 'aws-cdk-lib/aws-sns-subscriptions';
import * as sqsTargets from 'aws-cdk-lib/aws-lambda-event-sources';

export class NanoServiceConstruct extends cdk.Construct {
  constructor(scope: cdk.Construct, id: string) {
    super(scope, id);

    // Step 1: Create an SQS Queue
    const queue = new sqs.Queue(this, 'NanoServiceQueue', {
      visibilityTimeout: cdk.Duration.seconds(300), // Message visibility timeout
      retentionPeriod: cdk.Duration.days(4), // How long messages are kept
    });

    // Step 2: Create an SNS Topic
    const topic = new sns.Topic(this, 'NanoServiceTopic');

    // Subscribe the SQS Queue to the SNS Topic
    topic.addSubscription(new snsSubscriptions.SqsSubscription(queue));

    // Step 3: Create the Lambda Function
    const nanoServiceLambda = new lambda.Function(this, 'NanoServiceLambda', {
      runtime: lambda.Runtime.NODEJS_14_X,
      handler: 'index.handler',
      code: lambda.Code.fromAsset('lambda'), // Path to your Lambda function code
      environment: {
        QUEUE_URL: queue.queueUrl,
      },
    });

    // Grant the Lambda permissions to read messages from the SQS Queue
    queue.grantConsumeMessages(nanoServiceLambda);

    // Step 4: Add the SQS Queue as an Event Source to the Lambda
    nanoServiceLambda.addEventSource(new sqsTargets.SqsEventSource(queue));

    // Step 5: Create an API Gateway
    const api = new apigateway.RestApi(this, 'NanoServiceApi', {
      restApiName: 'NanoService',
      description: 'NanoService API Gateway to send requests.',
    });

    // Create a POST method on API Gateway that triggers the SNS Topic
    const resource = api.root.addResource('process');
    resource.addMethod('POST', new apigateway.AwsIntegration({
      service: 'sns',
      path: `/$\{cdk.Stack.of(this).account}/$\{topic.topicArn}`,
      integrationHttpMethod: 'POST',
      options: {
        requestParameters: {
          'integration.request.header.Content-Type': `'application/json'`,
        },
        integrationResponses: [
          {
            statusCode: '200',
          },
        ],
      },
    }));

    // Step 6: Output the API Gateway URL
    new cdk.CfnOutput(this, 'ApiUrl', {
      value: api.url,
      description: 'The URL for the NanoService API',
    });
  }
}
```

### 3. Explanation of the CDK Construct
- **SQS Queue**: A queue (`NanoServiceQueue`) is created to store incoming messages that will be processed by the Lambda function. The queue has a retention period (e.g., 4 days) and a visibility timeout (e.g., 300 seconds).
- **SNS Topic**: A topic (`NanoServiceTopic`) is created to decouple the services and allow for pub/sub behavior. Messages sent to the topic are forwarded to the SQS queue using the `SqsSubscription`.
- **Lambda Function**: The `NanoServiceLambda` function is created to process messages from the SQS queue. The Lambda is granted permission to consume messages from the queue. The Lambda code should handle the business logic.
- **API Gateway**: The API Gateway is the entry point for clients. A `POST` method is created on a `/process` resource, which triggers the SNS Topic. This allows external users to send messages via HTTP, which are then processed by the backend system.
- **Outputs**: The API Gateway URL is outputted so it can be accessed for testing and integration.

### 4. Security Considerations
- **IAM Roles**: Ensure that the Lambda function has appropriate permissions to consume messages from the SQS queue and that the SQS queue has permissions to receive messages from the SNS topic.
- **API Gateway Security**: Use appropriate authentication and authorization mechanisms (e.g., API Keys, Cognito, IAM roles, or OAuth) to secure the API Gateway endpoints.
- **Dead-Letter Queue (DLQ)**: Optionally, configure a DLQ for the SQS queue to capture any messages that fail to be processed by the Lambda function.

### 5. Deploy the Construct
The CDK construct can be deployed using the following commands:

#### Install Dependencies and Bootstrap:
```bash
npm install
cdk bootstrap
```

#### Deploy the Construct:
```bash
cdk deploy
```

This will deploy the entire infrastructure, including the API Gateway, SNS topic, SQS queue, and Lambda function.

### 6. Example Lambda Function Code
Place this in a directory (e.g., `lambda/`) to be used by the Lambda function.

#### Example `index.js` for Lambda:
```javascript
const AWS = require('aws-sdk');
const sqs = new AWS.SQS();

exports.handler = async (event) => {
    console.log('Processing message from SQS');

    for (const record of event.Records) {
        const messageBody = record.body;
        console.log(`Received message: $\{messageBody}`);

        // Add business logic here to process the message
    }

    return {
        statusCode: 200,
        body: JSON.stringify({ message: 'Processing complete' }),
    };
};
```

### 7. Test the NanoService
Once deployed, you can test the NanoService by sending HTTP requests to the API Gateway URL:

```bash
curl -X POST https://<api-gateway-url>/process -d '{'message': 'Hello from API Gateway'}'
```

This will send the message to the API Gateway, which triggers the SNS Topic, pushes the message to the SQS Queue, and finally processes it with the Lambda function.

### 8. Extending the Construct
This construct can be easily extended with:
  - **Additional Resources**: Add more Lambda functions or services.
  - **Monitoring and Alarms**: Use ** CloudWatch** to add metrics, logging, and alarms for tracking the service's health and performance.
  - **Error Handling**: Implement retries and error handling in the Lambda function to ensure fault tolerance.

### Testing
- **End-to-End Flow Test**: Ensure that a message can be sent via API Gateway, propagated through SNS, stored in SQS, and processed by Lambda.
- **Error Handling Test**: Simulate failures in Lambda processing and ensure messages are handled correctly (e.g., reprocessed or moved to a DLQ).
- **Security Test**: Test API Gateway authentication and IAM roles for security compliance.

### External Dependencies
- **AWS Account**: Access to AWS services such as API Gateway, SNS, SQS, and Lambda.
- **CDK**: Use AWS CDK for infrastructure as code.
- **IAM Roles**: Proper permissions need to be set up for Lambda, SNS, and SQS interactions.

## Acceptance Criteria
- Should have a standardized construct that integrates API Gateway, SNS, SQS, and Lambda.
- Should be able to deploy new NanoServices using this construct in an automated and consistent manner.
- Should have security controls for API Gateway and Lambda.
- Should have tests validating the full request flow from API Gateway to Lambda.
- Should have documentation explaining how to use and extend the construct.

### Gherkin
#### Scenario: Processing Requests End-to-End
Given the NanoService is deployed,
When an HTTP request is sent to the API Gateway,
Then the message should be passed through SNS, SQS, and processed by the Lambda function.

#### Scenario: Handling Message Failures
Given the Lambda function is processing messages,
When a message fails to be processed,
Then the message should be retried or moved to a dead-letter queue.

## External Links
- [AWS CDK Documentation](https://docs.aws.amazon.com/cdk/latest/guide/home.html)
- [AWS SNS Documentation](https://docs.aws.amazon.com/sns/latest/dg/welcome.html)
- [AWS SQS Documentation](https://docs.aws.amazon.com/sqs/latest/dg/welcome.html)
- [API Gateway Documentation](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)
