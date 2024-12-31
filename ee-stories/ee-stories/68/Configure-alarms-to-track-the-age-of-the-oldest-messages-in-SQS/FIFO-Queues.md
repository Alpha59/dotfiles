## Summary
**As a** DevOps engineer or system administrator, **I want** to configure **alarms** to track the **age of the oldest messages** in **SQS/FIFO Queues**, **so that** I can detect delayed message processing and ensure that messages are handled promptly, preventing performance bottlenecks or backlogs.

Tracking the age of the oldest message in SQS queues allows for proactive detection of processing issues, ensuring that messages are being handled within acceptable timeframes. This is crucial for maintaining the performance and reliability of systems relying on message queues.

### Vision
By configuring alarms for the age of the oldest messages in SQS/FIFO queues, the system will notify teams when messages are not being processed in a timely manner. This will help in identifying delays early and prevent potential backlogs that could impact service performance.

### Background
SQS queues, including FIFO queues, are used for decoupling systems and ensuring reliable message delivery. However, if messages are not processed promptly, they can pile up, leading to system degradation or even failures. Monitoring the age of the oldest message provides visibility into queue processing efficiency and highlights potential issues with message consumers.

### Purpose
The purpose of this story is to configure CloudWatch alarms to track the age of the oldest messages in SQS/FIFO queues. This will provide an early warning system for delayed message processing, allowing teams to address issues before they impact the overall system.

## Details

### 1. **Identify SQS/FIFO Queues**
   - List the SQS/FIFO queues that need monitoring.
   - Prioritize queues that handle critical or high-volume messages.

### 2. **Configure CloudWatch Metrics for Message Age**
   - Use the **ApproximateAgeOfOldestMessage** metric in CloudWatch to monitor the age of the oldest message in the queue.
   - Set the monitoring interval based on the importance of timely processing (e.g., 1-minute intervals for critical queues).

### 3. **Set Alarm Thresholds**
   - Define appropriate thresholds for message age (e.g., trigger an alarm if the oldest message is older than 5 minutes in high-priority queues).
   - Create CloudWatch alarms that trigger when the age of the oldest message exceeds the threshold.

   **Example CloudWatch Alarm Configuration**:
   ```bash
   aws cloudwatch put-metric-alarm \
     --alarm-name "SQS-FIFO-OldestMessageAge" \
     --metric-name "ApproximateAgeOfOldestMessage" \
     --namespace "AWS/SQS" \
     --dimensions Name=QueueName,Value=my-queue.fifo \
     --threshold 300 \
     --comparison-operator "GreaterThanThreshold" \
     --evaluation-periods 1 \
     --period 60 \
     --statistic "Maximum" \
     --alarm-actions arn:aws:sns:region:account-id:alarm-topic
   ```

### 4. **Set Up Notifications**
   - Configure notifications via **SNS**, **PagerDuty**, or **Slack** to alert the appropriate teams when alarms are triggered.
   - Ensure that escalation procedures are in place for handling prolonged message delays.

### 5. **Document Procedures**
   - Document troubleshooting steps to resolve issues related to delayed message processing in SQS/FIFO queues.

## Testing
- Simulate delayed message processing in the queue and ensure that alarms trigger correctly once the message age exceeds the defined threshold.
- Validate that the appropriate teams receive notifications when alarms are triggered.

## Acceptance Criteria
- Should configure alarms to monitor the age of the oldest messages in SQS/FIFO queues.
- Should set up thresholds and notifications for when message age exceeds predefined limits.
- Should document troubleshooting procedures to address message processing delays.
