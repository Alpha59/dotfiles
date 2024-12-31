## Synchronizing Maximum Concurrency of SQS Event Trigger with Lambda Reserved Concurrency

### Purpose
The purpose of this document is to establish best practices for synchronizing the maximum concurrency of SQS event triggers with the reserved concurrency of Lambda functions. This approach ensures that SQS buffers incoming messages during high traffic scenarios, preventing Lambda throttling while maintaining high availability and reliable message processing.

---

### Key Concepts

1. **SQS Maximum Concurrency**:
   - The **maximum concurrency** for an SQS queue refers to the maximum number of messages that can be processed simultaneously by Lambda functions triggered by the SQS queue.
   - By setting a reasonable limit for concurrent message processing, the system can handle high traffic while avoiding overloading Lambda.

2. **Lambda Reserved Concurrency**:
   - **Reserved Concurrency** specifies the number of Lambda instances that can run concurrently. By setting a reserved concurrency for the Lambda function, you can ensure that it has dedicated resources and does not exceed the limit, preventing it from being throttled during high traffic periods.
   - This ensures that the Lambda function is scaled appropriately to handle incoming requests and prevents overloading.

3. **Message Buffering in SQS**:
   - When Lambda reaches its concurrency limit, any additional messages sent to the SQS queue will be held in the queue until Lambda is able to process them. This prevents message loss but introduces a delay.
   - **Maximum message retention period in SQS**: By default, SQS retains messages for up to **14 days** before they are automatically deleted.

---

### Synchronization Strategy

#### 1. **Set Lambda Reserved Concurrency**
To prevent Lambda from being throttled during high traffic, it is important to set **reserved concurrency** for Lambda functions triggered by the SQS queue. The reserved concurrency ensures that Lambda has a fixed number of concurrent executions available for processing SQS messages.

- **Reserved Concurrency Calculation**:
  - **Estimate traffic**: Based on traffic patterns, calculate the maximum number of messages per second that need to be processed.
  - **Concurrency allocation**: Set Lambda’s reserved concurrency slightly higher than the estimated maximum concurrency needed to prevent throttling but within reasonable limits based on Lambda’s performance.

#### 2. **Adjust Maximum Concurrency of SQS Event Trigger**
- **Queue Message Buffering**: Set the **maximum concurrency** on the SQS event trigger so that if Lambda reaches its reserved concurrency limit, additional messages are buffered in the queue without overwhelming the system.
  - By default, Lambda will process messages from the SQS queue as long as it has concurrency available. If concurrency is exhausted, SQS will buffer incoming messages until Lambda can process them.

- **SQS to Lambda Trigger Scaling**: Ensure that the Lambda trigger configuration is set to scale based on the maximum concurrency defined for the Lambda function, so that the SQS queue is not overwhelmed.

#### 3. **Monitor Lambda and SQS Metrics**
- **CloudWatch Monitoring**:
  - **Lambda Concurrency**: Set up CloudWatch alarms to monitor Lambda’s concurrency usage. If the concurrency exceeds the threshold, it should trigger an alert or invoke auto-scaling actions.
  - **SQS Metrics**: Monitor the message age in the SQS queue to ensure that messages are not stuck in the queue for too long. Set up an alarm for **`ApproximateAgeOfOldestMessage`** to notify the team if messages are waiting in the queue for longer than expected.

#### 4. **Set Appropriate Backoff and Retry Policies**
  - **Exponential Backoff**: For SQS event-driven Lambda invocations, configure retries with **exponential backoff** to avoid hammering downstream services.
  - **Dead Letter Queue (DLQ)**: Set up a **DLQ** to capture any messages that could not be processed after multiple retries. This ensures that no messages are lost during processing failures.

---

### Configuration Example

#### 1. **Set Lambda Reserved Concurrency**
```json
{
  "FunctionName": "ProcessSQSMessages",
  "Concurrency": 100
}
```
- This sets the reserved concurrency of the `ProcessSQSMessages` Lambda function to **100 concurrent executions**. The number can be adjusted based on estimated load.

#### 2. **Configure SQS to Lambda Trigger**
- **SQS Event Source Mapping** (using AWS CLI or console):
  - Ensure that the **batch size** and **maximum concurrency** are aligned with the Lambda reserved concurrency:
  ```bash
  aws lambda create-event-source-mapping \
    --function-name ProcessSQSMessages \
    --batch-size 10 \
    --event-source-arn arn:aws:sqs:us-east-1:123456789012:MyQueue \
    --maximum-concurrency 100
  ```

#### 3. **CloudWatch Monitoring and Alarming**
- **Lambda Concurrency Alarm**:
  - Monitor Lambda concurrency using CloudWatch and set up an alarm:
  ```bash
  aws cloudwatch put-metric-alarm \
    --alarm-name LambdaHighConcurrency \
    --metric-name ConcurrentExecutions \
    --namespace AWS/Lambda \
    --statistic Maximum \
    --period 300 \
    --threshold 90 \
    --comparison-operator GreaterThanThreshold \
    --evaluation-periods 1 \
    --alarm-actions arn:aws:sns:us-east-1:123456789012:NotifyMe
  ```

- **SQS Queue Monitoring**:
  - Set an alarm for **SQS message age** to monitor how long messages are waiting in the queue:
  ```bash
  aws cloudwatch put-metric-alarm \
    --alarm-name SQSMessageAgeAlarm \
    --metric-name ApproximateAgeOfOldestMessage \
    --namespace AWS/SQS \
    --statistic Maximum \
    --period 300 \
    --threshold 3600 \
    --comparison-operator GreaterThanThreshold \
    --evaluation-periods 1 \
    --alarm-actions arn:aws:sns:us-east-1:123456789012:NotifyMe
  ```

---

### Benefits of Synchronizing Lambda and SQS Concurrency

1. **Prevents Lambda Throttling**: By aligning the maximum concurrency of SQS with Lambda’s reserved concurrency, the system ensures that Lambda will always have enough capacity to handle incoming messages without throttling.
2. **Avoids Queue Backlogs**: Messages will be buffered in the SQS queue without causing message loss if the Lambda function reaches its concurrency limit, reducing the risk of message backlog.
3. **Improved Reliability**: By ensuring the appropriate scaling of both SQS and Lambda functions, the system can better handle high traffic loads and prevent service interruptions.
4. **Cost Optimization**: With controlled concurrency and message processing, the system ensures that Lambda and SQS resources are used efficiently without over-provisioning.

---

### Acceptance Criteria
- Lambda function’s **reserved concurrency** is aligned with the **SQS maximum concurrency** to ensure no throttling.
- SQS queues are configured to buffer messages when Lambda reaches its concurrency limit.
- CloudWatch alarms are configured to monitor Lambda and SQS performance, ensuring timely alerts on concurrency or message backlog issues.
- Retry and backoff strategies are implemented to handle transient errors efficiently.

---

### Gherkin

**Feature**: Synchronize Lambda Concurrency with SQS Trigger
**Scenario**: Ensure Lambda concurrency aligns with SQS maximum concurrency
- **Given** an SQS queue is configured to trigger Lambda,
- **When** the queue receives messages during high traffic,
- **Then** the maximum concurrency of SQS should be synchronized with Lambda’s reserved concurrency, ensuring no message loss and preventing Lambda throttling.

By implementing this synchronization, the team ensures that Lambda functions can handle high traffic loads reliably, while messages are safely buffered in SQS if Lambda concurrency is exhausted.
