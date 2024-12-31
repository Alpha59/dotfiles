## Summary
**As a** DevOps engineer or system administrator, **I want** to configure **alarms** to track the **age of the oldest messages** in **SQS/FIFO Dead-Letter Queues (DLQs)**, **so that** I can detect potential issues in message processing and ensure that messages are handled promptly, preventing delays or message accumulation in DLQs.

Monitoring the age of messages in a Dead-Letter Queue is essential to prevent prolonged message failures that could signal unhandled exceptions or processing failures. By setting up alarms based on the age of the oldest messages, we can proactively address issues before they lead to significant backlog or system failure.

### Vision
By tracking and setting alarms for the age of the oldest messages in SQS/FIFO DLQs, the system will provide real-time alerts when messages are not processed within expected timeframes. This helps ensure timely troubleshooting and resolution, minimizing the risk of service degradation due to delayed or failed message handling.

### Background
SQS DLQs store messages that can't be processed successfully after the maximum number of retries. However, if messages remain in the DLQ for too long without being addressed, it could indicate a persistent issue in the application or message processing system. Monitoring the age of the oldest messages ensures that processing failures are identified quickly and resolved before they affect the broader system.

### Purpose
The purpose of this story is to configure CloudWatch alarms to track the age of the oldest messages in SQS/FIFO DLQs. This will help prevent message processing issues from going unnoticed and allow teams to address root causes quickly.

## Details

### 1. **Identify SQS/FIFO DLQs**
   - List the SQS/FIFO Dead-Letter Queues to be monitored.
   - Ensure that critical queues where unprocessed messages may affect system performance are prioritized.

### 2. **Configure CloudWatch Metrics for Message Age**
   - Use the **ApproximateAgeOfOldestMessage** metric in CloudWatch to track the age of the oldest message in each DLQ.
   - Set the monitoring interval based on the system's message processing requirements (e.g., 1-minute intervals for high-priority systems).

### 3. **Set Alarm Thresholds**
   - Define the maximum acceptable message age for each DLQ (e.g., messages older than 5 minutes trigger an alarm for high-priority queues).
   - Create alarms in **AWS CloudWatch** that trigger when the age of the oldest message exceeds the threshold.

   **Example Alarm Configuration**:
   ```bash
   aws cloudwatch put-metric-alarm \
     --alarm-name "DLQ-OldestMessageAge" \
     --metric-name "ApproximateAgeOfOldestMessage" \
     --namespace "AWS/SQS" \
     --dimensions Name=QueueName,Value=my-dlq.fifo \
     --threshold 300 \
     --comparison-operator "GreaterThanThreshold" \
     --evaluation-periods 1 \
     --period 60 \
     --statistic "Maximum" \
     --alarm-actions arn:aws:sns:region:account-id:alarm-topic
   ```

### 4. **Notification and Response Setup**
   - Set up notifications via **SNS**, **PagerDuty**, or **Slack** when alarms are triggered to notify the appropriate team.
   - Document response procedures for investigating and resolving prolonged message age in DLQs.

## Testing
- Simulate unprocessed messages in the DLQ and verify that alarms are triggered once the message age exceeds the threshold.
- Validate that notifications are sent to the correct recipients.

## Acceptance Criteria
- Should configure alarms to monitor the age of the oldest messages in SQS/FIFO DLQs.
- Should trigger notifications when messages exceed the defined age threshold.
- Should document troubleshooting steps for resolving DLQ issues related to message age.
