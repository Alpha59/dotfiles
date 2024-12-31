## Summary
**As a** DevOps engineer or software developer, **I want** to **create Dead-Letter Queues (DLQs) to capture failed messages caused by system bugs**, **so that** these messages can be processed asynchronously later, ensuring that errors do not block the normal flow of operations.

Dead-Letter Queues (DLQs) are used to store messages that cannot be processed successfully by a primary queue due to system bugs, data issues, or other errors. By implementing DLQs, failed messages can be isolated and retried or analyzed without impacting the primary system. This approach allows for non-blocking operations, where failed messages are captured for later processing rather than causing the entire process to fail.

### Vision
By using DLQs to handle failed messages, the team will improve system resilience and error handling, ensuring that transient issues or bugs do not halt the processing pipeline. This will help maintain smooth operations while still allowing for problem resolution and data reprocessing when needed.

### Background
In distributed systems, message processing failures can occur due to various reasons, such as data validation errors, service outages, or temporary bugs. Without proper error handling, these failures could cause processing pipelines to stall. Using DLQs allows for failed messages to be captured separately, enabling the main system to continue processing other messages. DLQs can be used with message brokers like **AWS SQS**, **Apache Kafka**, or **RabbitMQ**.

### Purpose
The purpose of this story is to implement DLQs for capturing and handling failed messages due to system bugs, allowing them to be processed asynchronously later without blocking the main processing flow.

## Details

### 1. **Create Dead-Letter Queues (DLQs)**
   - Set up DLQs for the primary message queues used in the system. Each DLQ will store messages that have failed processing.
   - Use a message broker that supports DLQs, such as **AWS SQS**, **Apache Kafka**, or **RabbitMQ**.
   - Configure each DLQ to receive messages that have failed processing after a specified number of retries.

   **Example AWS SQS DLQ Setup**:
   - **Create an SQS DLQ**: `MyService-DLQ`.
   - **Configure the main SQS queue** (`MyServiceQueue`) to route messages to `MyService-DLQ` after `maxReceiveCount` retries (e.g., 3 attempts).

   **AWS CLI Command to Create a DLQ**:
   ```bash
   aws sqs create-queue --queue-name MyService-DLQ
   ```

### 2. **Configure the Main Queue to Use the DLQ**
   - Set up the main processing queue to send messages to the DLQ if they fail after a defined number of processing attempts.
   - For **AWS SQS**, use the `RedrivePolicy` attribute to define the relationship between the main queue and the DLQ.

   **Example AWS SQS Configuration**:
   ```bash
   aws sqs set-queue-attributes --queue-url <MainQueueURL> --attributes \
       '{"RedrivePolicy":"{\"maxReceiveCount\":\"3\", \"deadLetterTargetArn\":\"<DLQArn>\"}"}'
   ```
   - **maxReceiveCount**: The number of times a message can be received before it is moved to the DLQ.
   - **deadLetterTargetArn**: The Amazon Resource Name (ARN) of the DLQ.

### 3. **Implement Non-Blocking Operations**
   - Ensure that the message processing logic is designed to handle failures without blocking subsequent operations:
     - **Try-Catch Handling**: Use proper exception handling to catch processing errors and allow other messages to continue processing.
     - **Asynchronous Message Processing**: Implement asynchronous or parallel processing to prevent a single failed message from affecting other messages.
   - Use **Promise-based error handling** (for languages like JavaScript/TypeScript) or **async/await** to manage asynchronous operations.

   **Example TypeScript Code for Non-Blocking Processing**:
   ```typescript
   async function processMessage(message: SQSMessage) {
       try {
           // Main processing logic
           await processData(message);
       } catch (error) {
           console.error('Processing failed for message:', message.messageId, error);
           // Handle the error without blocking further processing
       }
   }
   ```

### 4. **Implement Retrying Logic for Failed Messages**
   - Implement a mechanism to retry processing messages from the DLQ after resolving the underlying issue.
   - Use a **scheduled task** or **lambda function** to periodically poll the DLQ and attempt reprocessing of failed messages.
   - Apply **backoff strategies** (e.g., exponential backoff) to avoid overwhelming the system during retries.

   **Example AWS Lambda DLQ Reprocessing Logic**:
   ```javascript
   const AWS = require('aws-sdk');
   const sqs = new AWS.SQS();

   async function reprocessFailedMessages() {
       const dlqUrl = 'https://sqs.region.amazonaws.com/account-id/MyService-DLQ';
       const params = {
           QueueUrl: dlqUrl,
           MaxNumberOfMessages: 10,
       };
       const data = await sqs.receiveMessage(params).promise();

       if (data.Messages) {
           for (const message of data.Messages) {
               try {
                   await processData(message); // Attempt to reprocess
                   await sqs.deleteMessage({
                       QueueUrl: dlqUrl,
                       ReceiptHandle: message.ReceiptHandle
                   }).promise();
               } catch (error) {
                   console.error('Reprocessing failed for message:', message.MessageId, error);
               }
           }
       }
   }
   ```

### 5. **Monitor DLQ Metrics and Set Up Alerts**
   - Monitor the number of messages in the DLQ and set up alerts if the queue size exceeds a certain threshold, indicating a high number of failures.
   - Use monitoring tools like **CloudWatch**, **Datadog**, or **Prometheus** to track DLQ metrics.

   **Example AWS CloudWatch Alarm for DLQ Monitoring**:
   ```bash
   aws cloudwatch put-metric-alarm --alarm-name "HighDLQMessages" \
       --metric-name "ApproximateNumberOfMessagesVisible" --namespace "AWS/SQS" \
       --statistic "Average" --period 300 --threshold 10 \
       --comparison-operator "GreaterThanThreshold" --dimensions Name=QueueName,Value=MyService-DLQ \
       --evaluation-periods 1 --alarm-actions <SNS-topic-arn>
   ```

### 6. **Update the Runbook for DLQ Management**
   - Document procedures for handling messages in the DLQ, including reprocessing steps and common troubleshooting scenarios.
   - Provide instructions for configuring DLQs and handling non-blocking message processing.
   - Include guidance on monitoring DLQ metrics and responding to alerts.

   **Runbook Sections to Update**:
   - **DLQ Configuration**: Instructions for setting up and configuring DLQs.
   - **Reprocessing Messages**: Step-by-step guide for reprocessing failed messages from the DLQ.
   - **Monitoring and Alerting**: Setting up alerts for DLQ metrics and troubleshooting steps.

### Testing
- Verify that failed messages are moved to the DLQ after the specified number of processing attempts.
- Test the non-blocking behavior by simulating message processing failures and ensuring that other messages continue processing.
- Validate the reprocessing mechanism by reprocessing messages from the DLQ and confirming successful processing.
- Test the DLQ monitoring and alerting configuration by simulating conditions that trigger alarms.

### Acceptance Criteria
- Should create DLQs for primary message queues, capturing failed messages caused by system bugs.
- Should configure the main queue to route messages to the DLQ after a specified number of retries.
- Should implement non-blocking message processing, ensuring that failures do not block subsequent operations.
- Should implement retry logic for processing messages from the DLQ with configurable backoff strategies.
- Should monitor DLQ metrics and set up alerts to detect high failure rates.
- Should update the runbook with instructions for DLQ management, reprocessing, and monitoring.

### External Links
- [AWS SQS Dead-Letter Queues Documentation](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-dead-letter-queues.html)
- [Best Practices for Handling Failed Messages in Distributed Systems](https://aws.amazon.com/blogs/compute/dead-letter-queues-for-lambda-functions/)
- [Asynchronous Processing in Node.js with Promises](https://nodejs.dev/en/learn/understanding-javascript-promises/)
