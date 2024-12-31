## Summary
**As a** DevOps engineer or cloud architect, **I want** to **create a shareable AWS CDK L3 construct that integrates API Gateway, SNS, and SQS as a nano service**, **so that** teams can easily deploy a standardized and reusable pattern for microservices with event-driven architectures.

An L3 construct in the AWS Cloud Development Kit (CDK) provides a high-level abstraction that encapsulates complex configurations into a reusable component. Creating a shareable nano service construct that integrates API Gateway, SNS, and SQS simplifies the deployment of event-driven services by providing preconfigured best practices, enabling developers to focus on application logic rather than infrastructure setup.

### Vision
By developing a shareable CDK L3 construct, the team will have a standardized approach to deploying microservices that leverage API Gateway for HTTP requests, SNS for event notifications, and SQS for asynchronous message processing. This will accelerate development, ensure consistent configurations across services, and promote best practices in event-driven architecture.

### Background
In microservice architectures, it is common to use a combination of API Gateway, SNS, and SQS to handle HTTP requests, event notifications, and message queuing. However, configuring these services individually can be time-consuming and prone to misconfiguration. An L3 construct allows developers to deploy this pattern with minimal effort, ensuring that all components are correctly integrated.

### Purpose
The purpose of this story is to create a reusable L3 CDK construct that combines API Gateway, SNS, and SQS for nano services, providing a standardized and easy-to-use pattern for teams deploying event-driven microservices.

## Details

### 1. **Define the Nano Service Architecture**
   - The L3 construct should encapsulate the following AWS services:
     - **API Gateway**: Handles incoming HTTP requests and triggers the SNS topic.
     - **SNS (Simple Notification Service)**: Publishes messages to one or more SQS queues or subscribers.
     - **SQS (Simple Queue Service)**: Asynchronously processes messages, enabling decoupled communication.
   - The architecture should support the following features:
     - **API Gateway**: Configured with a REST API endpoint and rate limiting.
     - **SNS Topic**: Acts as a mediator for broadcasting messages to SQS or other subscribers.
     - **SQS Queue**: Configured with a DLQ (Dead-Letter Queue) for handling failed messages.
     - **Integration**: The API Gateway triggers SNS, and SNS forwards messages to SQS.

### 2. **Create the L3 CDK Construct**
   - Implement the L3 construct in **TypeScript** (or another supported language) using the AWS CDK.
   - The construct should extend the base CDK constructs for **API Gateway**, **SNS**, and **SQS**, encapsulating their configurations and interactions.
   - Provide default configurations while allowing customization of key parameters (e.g., queue retention, message filtering, rate limits).

   **Example CDK Code for the Construct**:
   ```typescript
   import * as cdk from 'aws-cdk-lib';
   import * as apigateway from 'aws-cdk-lib/aws-apigateway';
   import * as sns from 'aws-cdk-lib/aws-sns';
   import * as sqs from 'aws-cdk-lib/aws-sqs';
   import * as snsSubscriptions from 'aws-cdk-lib/aws-sns-subscriptions';
   import { Construct } from 'constructs';

   export interface NanoServiceProps {
       readonly apiRateLimit?: number;
       readonly queueVisibilityTimeout?: cdk.Duration;
       readonly messageRetentionPeriod?: cdk.Duration;
   }

   export class NanoService extends Construct {
       public readonly apiEndpoint: apigateway.RestApi;
       public readonly snsTopic: sns.Topic;
       public readonly queue: sqs.Queue;

       constructor(scope: Construct, id: string, props: NanoServiceProps = {}) {
           super(scope, id);

           // Create SQS queue with a Dead-Letter Queue
           const dlq = new sqs.Queue(this, 'DLQ', {
               retentionPeriod: props.messageRetentionPeriod || cdk.Duration.days(14),
           });

           this.queue = new sqs.Queue(this, 'Queue', {
               visibilityTimeout: props.queueVisibilityTimeout || cdk.Duration.seconds(30),
               deadLetterQueue: {
                   maxReceiveCount: 5,
                   queue: dlq,
               },
           });

           // Create SNS topic
           this.snsTopic = new sns.Topic(this, 'Topic');

           // Subscribe the SQS queue to the SNS topic
           this.snsTopic.addSubscription(new snsSubscriptions.SqsSubscription(this.queue));

           // Create API Gateway
           this.apiEndpoint = new apigateway.RestApi(this, 'ApiGateway', {
               defaultMethodOptions: {
                   throttlingRateLimit: props.apiRateLimit || 100,
                   throttlingBurstLimit: 200,
               },
           });

           // Integrate API Gateway with SNS
           const snsIntegration = new apigateway.AwsIntegration({
               service: 'sns',
               path: `${this.snsTopic.topicArn.split(':')[4]}/${this.snsTopic.topicName}`,
               integrationHttpMethod: 'POST',
               options: {
                   requestParameters: {
                       'integration.request.header.Content-Type': "'application/x-www-form-urlencoded'",
                   },
                   requestTemplates: {
                       'application/json': 'Action=Publish&TopicArn=$util.urlEncode("' + this.snsTopic.topicArn + '")&Message=$input.body',
                   },
                   integrationResponses: [{
                       statusCode: '200',
                   }],
               },
           });

           this.apiEndpoint.root.addMethod('POST', snsIntegration, {
               methodResponses: [{ statusCode: '200' }],
           });
       }
   }
   ```

### 3. **Expose Configuration Parameters for Customization**
   - Allow customization of the following settings:
     - **API Gateway Rate Limits**: Configure the rate limit and burst limit.
     - **SQS Queue Settings**: Configure the visibility timeout and message retention.
     - **DLQ Settings**: Customize the dead-letter queue retention period and max receive count.
   - Provide sensible defaults while enabling users to override these configurations as needed.

### 4. **Implement Security Best Practices**
   - **IAM Roles and Policies**: Ensure that the API Gateway, SNS, and SQS have the appropriate IAM permissions to interact securely.
   - **Encryption**: Enable server-side encryption for SQS queues and SNS topics.
   - **Access Control**: Use API Gateway authorizers (e.g., Cognito or Lambda) to secure the API endpoint if needed.

### 5. **Write Unit and Integration Tests for the Construct**
   - Develop tests to validate that the construct correctly sets up the API Gateway, SNS topic, and SQS queue with the appropriate configurations.
   - Test that messages published to the API Gateway are successfully routed through SNS to SQS.
   - Verify that DLQ functionality works as expected for failed messages.

   **Example Testing Scenarios**:
   - **Test 1**: Confirm that the API Gateway triggers SNS and that messages reach the SQS queue.
   - **Test 2**: Validate that DLQ captures messages after the maximum receive count is reached.

### 6. **Document the Construct with Usage Examples**
   - Provide documentation on how to use the construct, including code examples for common scenarios.
   - Explain the architecture, default configurations, and customization options.

   **Example Usage Documentation**:
   ```typescript
   const nanoService = new NanoService(this, 'MyNanoService', {
       apiRateLimit: 50,
       queueVisibilityTimeout: cdk.Duration.seconds(45),
   });

   new cdk.CfnOutput(this, 'API Endpoint', {
       value: nanoService.apiEndpoint.url,
   });
   ```

### 7. **Publish the L3 Construct as a Shareable Module**
   - Package the construct as an NPM module or Python package for easy sharing within the organization.
   - Follow internal guidelines for versioning, licensing, and publishing.

### Testing
- **Deploy the Construct in a Test Environment**: Verify that all resources are created and integrated correctly.
- **Integration Testing**: Send test requests to the API Gateway and confirm that they are processed end-to-end.
- **Security Testing**: Validate IAM policies and encryption settings.

### Acceptance Criteria
- Should implement an L3 construct that integrates API Gateway, SNS, and SQS for a shareable nano service.
- Should provide configuration options for API rate limits, SQS settings, and DLQ configurations.
- Should follow security best practices for IAM roles, encryption, and access control.
- Should include unit and integration tests to validate the setup.
- Should provide usage documentation and examples.
- Should package the construct for easy sharing and reuse.

### External Links
- [AWS CDK API Gateway Documentation](https://docs.aws.amazon.com/cdk/api/latest/docs/aws-apigateway-readme.html)
- [AWS CDK SNS Documentation](https://docs.aws.amazon.com/cdk/api/latest/docs/aws-sns-readme.html)
- [AWS CDK SQS Documentation](https://docs.aws.amazon.com/cdk/api/latest/docs/aws-sqs-readme.html)
