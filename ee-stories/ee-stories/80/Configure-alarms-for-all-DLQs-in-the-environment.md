## Summary
**As a** DevOps engineer or cloud architect, **I want** to configure **alarms for all Dead Letter Queues (DLQs)** in the environment, **so that** any failed messages that cannot be processed in the primary queue are identified and addressed in a timely manner, minimizing the risk of data loss or system failure.

Dead Letter Queues (DLQs) are critical for ensuring that messages that fail processing are not lost but can be analyzed and retried. By configuring alarms on DLQs, the team will be notified immediately if messages accumulate in a DLQ, allowing them to investigate the root cause and take corrective actions before the issue affects the system or customers.

### Vision
By setting up alarms for DLQs, the team will be able to monitor and manage message failures across the system, ensuring that issues are caught early, investigated, and resolved before they impact service availability or user experience. This will improve the reliability of asynchronous workflows and event-driven services.

### Background
In distributed systems, DLQs store messages that could not be processed by the primary queue, often due to validation errors, processing failures, or system timeouts. Without proper monitoring, these failed messages could accumulate unnoticed, leading to data loss or delayed processing. Configuring alarms ensures that when messages are routed to DLQs, the team is promptly alerted and can take appropriate action.

### Purpose
The purpose of this story is to configure alarms on all DLQs in the environment, enabling proactive monitoring of failed messages and ensuring that the team is notified of any issues that require immediate attention.

## Details

### 1. **Identify All DLQs in the Environment**
   - Identify all DLQs that are being used across services in the environment. This includes:
     - **Amazon SQS DLQs**: Dead Letter Queues used by Amazon Simple Queue Service (SQS) to capture failed messages.
     - **Lambda DLQs**: Dead Letter Queues configured for AWS Lambda functions.
     - **SNS DLQs**: Dead Letter Queues used by Amazon Simple Notification Service (SNS) to store failed notifications.

   **Example DLQs**:
   - SQS DLQ for failed order processing events.
   - Lambda DLQ for asynchronous image processing failures.
   - SNS DLQ for notification delivery failures.

### 2. **Define Thresholds for Alarms**
   - Determine the appropriate thresholds for triggering an alarm based on the number of messages in the DLQ or the age of the oldest message. Key metrics include:
     - **ApproximateNumberOfMessagesVisible**: The number of messages in the DLQ.
     - **ApproximateAgeOfOldestMessage**: The time since the oldest message was added to the queue.

   **Example Thresholds**:
   - Trigger an alarm if more than 10 messages are in the DLQ.
   - Trigger an alarm if a message has been in the DLQ for more than 5 minutes.

### 3. **Create CloudWatch Alarms for DLQs**
   - Use Amazon CloudWatch to create alarms for each DLQ in the environment. The alarms will monitor message accumulation and message age, notifying the team if the DLQs exceed the defined thresholds.

   **Example for SQS DLQ Monitoring**:
   - Create a CloudWatch alarm to monitor the **ApproximateNumberOfMessagesVisible** metric for each SQS DLQ.

   **AWS CLI Example**:
   ```bash
   aws cloudwatch put-metric-alarm \
     --alarm-name "DLQ-OrderProcessing-Messages-Alarm" \
     --metric-name "ApproximateNumberOfMessagesVisible" \
     --namespace "AWS/SQS" \
     --dimensions Name=QueueName,Value=OrderProcessing-DLQ \
     --statistic "Average" \
     --period 300 \
     --threshold 10 \
     --comparison-operator "GreaterThanThreshold" \
     --evaluation-periods 1 \
     --alarm-actions arn:aws:sns:region:account-id:DLQ-Alerts
   ```

   **AWS CloudWatch Console Example**:
   - Navigate to the **CloudWatch** dashboard.
   - Go to **Alarms** and click **Create Alarm**.
   - Select **SQS** as the service and choose the DLQ to monitor.
   - Choose the **ApproximateNumberOfMessagesVisible** metric and set the threshold (e.g., >10 messages).
   - Set up notifications via SNS for when the alarm is triggered.

### 4. **Configure Alarms for DLQ Message Age**
   - Create alarms to monitor the **ApproximateAgeOfOldestMessage** metric to ensure that messages are not sitting in the DLQ for an extended period without being addressed.

   **Example for Lambda DLQ Monitoring**:
   - Monitor the age of the oldest message in the Lambda DLQ to ensure messages are processed in a timely manner.

   **AWS CLI Example**:
   ```bash
   aws cloudwatch put-metric-alarm \
     --alarm-name "DLQ-LambdaProcessing-OldestMessage-Alarm" \
     --metric-name "ApproximateAgeOfOldestMessage" \
     --namespace "AWS/SQS" \
     --dimensions Name=QueueName,Value=LambdaProcessing-DLQ \
     --statistic "Maximum" \
     --period 300 \
     --threshold 300 \
     --comparison-operator "GreaterThanThreshold" \
     --evaluation-periods 1 \
     --alarm-actions arn:aws:sns:region:account-id:DLQ-Alerts
   ```

   **AWS CloudWatch Console Example**:
   - Create an alarm on **ApproximateAgeOfOldestMessage** for each DLQ.
   - Set a threshold (e.g., age greater than 5 minutes) to trigger an alert if messages are not being processed promptly.

### 5. **Set Up Notifications for DLQ Alarms**
   - Use **Amazon SNS (Simple Notification Service)** to set up notifications for DLQ alarms. These notifications can be sent via email, SMS, or Slack when the alarm is triggered.

   **Example SNS Setup for Email Notification**:
   - Create an SNS topic for DLQ alerts and subscribe the team’s email addresses to the topic.

   **AWS CLI Example**:
   ```bash
   aws sns create-topic --name DLQ-Alerts
   aws sns subscribe --topic-arn arn:aws:sns:region:account-id:DLQ-Alerts --protocol email --notification-endpoint team@example.com
   ```

   - Link the CloudWatch alarm actions to this SNS topic so that alerts are sent when messages accumulate in the DLQ or when messages age out.

### 6. **Monitor and Test DLQ Alarms**
   - Test the DLQ alarms by intentionally sending messages to a DLQ and verifying that the alarm is triggered.
   - Ensure that the notifications are received by the appropriate team members and that the alerts provide enough information to investigate the issue.

   **Testing Example**:
   - Send test messages to an SQS DLQ to ensure that the **ApproximateNumberOfMessagesVisible** alarm is triggered when the message count exceeds the threshold.
   - Verify that the SNS notifications are received.

### 7. **Configure Alarms for Other DLQs (Lambda, SNS, etc.)**
   - For AWS Lambda, configure DLQ alarms to track messages that are not processed due to function failures.
   - For AWS SNS, set up alarms for notifications that fail to deliver and are sent to the DLQ.

   **Example Lambda DLQ Configuration**:
   ```bash
   aws lambda update-function-configuration \
     --function-name MyFunction \
     --dead-letter-config TargetArn=arn:aws:sqs:region:account-id:MyLambdaDLQ
   ```

   - Create CloudWatch alarms for **ApproximateNumberOfMessagesVisible** and **ApproximateAgeOfOldestMessage** for Lambda and SNS DLQs.

### Testing
- Test each alarm by sending messages to the DLQs and verifying that the alarms are triggered when the thresholds are exceeded.
- Confirm that the team receives the appropriate notifications via SNS and that the alerts contain detailed information for troubleshooting.

### Acceptance Criteria
- Should identify all DLQs in the environment, including SQS, Lambda, and SNS DLQs.
- Should configure CloudWatch alarms for all DLQs, monitoring both message accumulation and message age.
- Should set up SNS notifications to alert the team when alarms are triggered.
- Should test the alarms to ensure they are functioning as expected and that notifications are received by the team.
- Should ensure alarms provide sufficient detail to allow the team to take corrective action.

### External Links
- [AWS SQS Dead Letter Queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-dead-letter-queues.html)
- [AWS Lambda Dead Letter Queues](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html#dlq)
- [AWS CloudWatch Alarms](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html)
