
# Configure a dead letter queue for all non-fifo solution queues
### Summary
**As a** DevOps Engineer, **I want** to configure a Dead Letter Queue (DLQ) for all non-FIFO solution queues, **So That** messages that fail to process successfully can be captured and stored for further analysis and troubleshooting, ensuring better error handling and preventing message loss.

This story focuses on setting up a Dead Letter Queue for each non-FIFO queue in the system to capture failed messages. The DLQ will help track and manage messages that exceed the processing limits or encounter issues that prevent them from being successfully handled by the primary queue. This configuration improves the system's robustness by ensuring that problematic messages are not lost but can be reviewed and reprocessed.

### Vision
Adding a Dead Letter Queue to all non-FIFO queues ensures that messages that repeatedly fail to process are not lost. Instead, they are captured in a designated DLQ, where the messages can be inspected, analyzed, and either fixed or reprocessed. This strategy enhances error handling and ensures that any issues with message processing can be addressed without affecting the primary queue’s normal operations.

### Background
Currently, messages that fail to be processed by non-FIFO queues may either be discarded or cause delays in processing other messages. Without a Dead Letter Queue, these messages can be difficult to track and diagnose. Configuring DLQs for non-FIFO queues provides a mechanism to handle failed messages, allowing them to be stored for further investigation and resolution.

### Purpose
The purpose of this story is to configure Dead Letter Queues for all non-FIFO queues to capture and handle messages that fail to process. This ensures better fault tolerance, prevents message loss, and allows the team to troubleshoot and address message processing failures effectively.

## Details
### 1. Identify Non-FIFO Queues
- Work with the development and operations teams to identify all non-FIFO queues in the system that require Dead Letter Queues. Examples may include:
  - **Standard SQS Queues**: Non-FIFO (First-In-First-Out)  SQS queues where message ordering is not guaranteed.
  - **Event Processing Queues**: Queues used for background processing, asynchronous tasks, or event-driven services.

### 2. Create Dead Letter Queues (DLQs)
- For each identified non-FIFO queue, create a corresponding DLQ to store messages that fail to process successfully.
- Each DLQ should be:
  - **Separate from the main queue**: A dedicated SQS queue that will only store failed messages.
  - **Non-FIFO**: DLQs for non-FIFO queues should also be configured as standard (non-FIFO) queues since message ordering is not guaranteed.

You can create the DLQ using AWS Management Console, AWS CLI, or Infrastructure as Code (e.g., Terraform, CloudFormation).

#### AWS CLI Example for Creating a DLQ:
```bash
aws sqs create-queue --queue-name <dead-letter-queue-name>
```

### 3. Configure Redrive Policy on the Main Queue
- Modify the Redrive Policy for each non-FIFO queue to redirect failed messages to the DLQ. The Redrive Policy defines:
  - **Maximum Receives**: The number of times a message can be received and processed before being sent to the DLQ. For example, if a message is unsuccessfully processed after 5 attempts, it will be sent to the DLQ.
  - **DLQ ARN**: The  Resource Name (ARN) of the Dead Letter Queue to which failed messages should be sent.

#### AWS CLI Example to Configure Redrive Policy:
```bash
aws sqs set-queue-attributes     --queue-url <main-queue-url>     --attributes '{'RedrivePolicy': '{\'maxReceiveCount\':\'5\', \'deadLetterTargetArn\':\'arn:aws:sqs:<region>:<account-id>:<dead-letter-queue-name>\'}'}'
```

### 4. Set Maximum Receive Count for Messages
- The Maximum Receive Count determines how many times a message will be tried before being sent to the DLQ. This value should be configured based on the use case:
  - For transient errors (e.g., temporary network failures), a higher value might be appropriate (e.g., 5-10 retries).
  - For more critical errors (e.g., invalid message format), a lower value might be appropriate to prevent unnecessary retries.

### 5. Monitor and Manage DLQs
- Set up monitoring and alerts for DLQs to track failed messages. Monitoring DLQs will help ensure that the team is aware of any message processing failures.
  - **CloudWatch Metrics**: Monitor metrics such as the number of messages in the DLQ and the rate of failed messages.
  - **CloudWatch Alarms**: Set alarms to notify the team when a threshold is reached (e.g., if the number of messages in the DLQ exceeds a certain value).

#### Example CloudWatch Alarm for DLQ Message Count:
```bash
aws cloudwatch put-metric-alarm     --alarm-name 'DLQMessageCountAlarm'     --metric-name ApproximateNumberOfMessagesVisible     --namespace AWS/SQS     --statistic Average     --period 300     --threshold 100     --comparison-operator GreaterThanThreshold     --dimensions Name=QueueName,Value=<dead-letter-queue-name>     --evaluation-periods 1     --alarm-actions <sns-topic-arn>
```

### 6. Reprocess or Investigate Messages in DLQs
- Set up a process to periodically review and reprocess messages in the DLQ:
  - **Manual Review**: Team members can review the contents of the DLQ to identify patterns in failures and resolve underlying issues.
  - **Automated Reprocessing**: Based on the failure cause, implement an automated process to attempt reprocessing of certain messages in the DLQ, or flag them for manual intervention.
- Set up alerting for spikes in DLQ message counts to quickly identify potential issues in the main queue’s processing logic.

### 7. Documentation and Training
- Document the setup and use of DLQs in the system, including:
  - **How DLQs are configured**.
  - **How to monitor and troubleshoot DLQs**.
  - **How to reprocess messages from the DLQ**.
- Provide training to the development and operations teams on how to handle messages in the DLQ and how to address recurring processing issues.

### 8. Test the DLQ Configuration
- Test the DLQ setup by sending test messages to the main non-FIFO queue and simulating failures to verify that the messages are correctly sent to the DLQ after reaching the maximum receive count.
- Verify that the DLQ is correctly capturing failed messages and that alerts are triggered when messages accumulate in the DLQ.

### Testing
- **Failure Simulation**: Simulate failed message processing by introducing deliberate errors (e.g., sending malformed data) and verify that the messages are sent to the DLQ.
- **Monitoring and Alerts**: Ensure that monitoring for DLQs is active, and alerts are triggered when message counts in the DLQ exceed thresholds.
- **Reprocessing**: Test reprocessing of messages from the DLQ and ensure that reprocessed messages are handled correctly.

### External Dependencies
- Integration with  SQS for configuring queues and Dead Letter Queues.
- Integration with  CloudWatch for monitoring message failures and setting up alerts.
- Collaboration with the development team to review and address issues with failed message processing.

## Acceptance Criteria
- Should have configured Dead Letter Queues for all non-FIFO queues in the system.
- Should have set up a Redrive Policy for each non-FIFO queue, specifying the maximum receive count and the corresponding DLQ ARN.
- Should have tested the DLQ configuration by simulating failed messages and verifying that they are sent to the DLQ.
- Should have implemented monitoring and alerts for DLQ message counts, ensuring that the team is notified when failed messages accumulate in the DLQ.
- Should have documented the DLQ setup and provided training to the team on how to manage DLQs and reprocess failed messages.

### Gherkin
#### Scenario: Configuring Dead Letter Queue for a Non-FIFO Queue
Given a non-FIFO queue,
When a message fails to process after the maximum receive count,
Then the message should be sent to the configured Dead Letter Queue for further investigation.

#### Scenario: Monitoring Dead Letter Queue for Failed Messages
Given a Dead Letter Queue for a non-FIFO queue,
When the number of messages in the DLQ exceeds the predefined threshold,
Then a CloudWatch alarm should trigger, notifying the team of the issue.

#### Scenario: Reprocessing Messages from the Dead Letter Queue
Given a message in the Dead Letter Queue,
When the underlying issue is resolved,
Then the message should be reprocessed or moved to the original queue for further handling.

## External Links
- [ SQS Dead Letter Queues Documentation](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-dead-letter-queues.html)
- [AWS CLI SQS Commands](https://docs.aws.amazon.com/cli/latest/reference/sqs/index.html)
