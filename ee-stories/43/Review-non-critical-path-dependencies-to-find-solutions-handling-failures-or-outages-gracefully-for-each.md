
# Review non-critical path dependencies to find solutions handling failures or outages gracefully for each
### Summary
**As a** DevOps Engineer, **I want** to review non-critical path dependencies and find solutions for handling failures or outages gracefully for each, **So That** we can minimize the impact of dependency failures on the overall system by ensuring that non-critical operations do not cause cascading failures and that messages or requests are retried or processed later using mechanisms like Dead Letter Queues (DLQs).

This story focuses on identifying non-critical path dependencies in the system, such as third-party services, background processes, or batch operations, and designing solutions to handle their failures gracefully. By using strategies like Dead Letter Queues (DLQ), retries, and fallback mechanisms, we can ensure that the system remains operational and can recover from failures without significant user impact.

### Vision
By reviewing and implementing solutions for handling failures in non-critical path dependencies, we improve the resilience and stability of the system. This ensures that failures in these dependencies do not cause system-wide issues and that any failed requests or processes are handled appropriately through retries, logging, or deferred processing.

### Background
Non-critical path dependencies are services or components that are not essential for the immediate operation of the system but still play a role in background tasks, data processing, or asynchronous workflows. When these dependencies fail, they should not affect the primary operations of the system. Instead, failures should be handled using retry strategies, fallback mechanisms, or Dead Letter Queues to ensure that the failed processes can be retried or addressed later.

---

### Steps to Review Non-Critical Path Dependencies and Implement Failure Handling

#### 1. **Identify Non-Critical Path Dependencies**

The first step is to identify the non-critical dependencies in your system. These are services or components that are not essential for real-time operations but are still part of the broader system's functionality. Examples of non-critical dependencies include:

- **Third-party API integrations**: External services that provide optional functionality (e.g., analytics, notifications).
- **Background tasks**: Asynchronous tasks that handle non-urgent processing, such as batch jobs or scheduled tasks.
- **Data processing services**: Services that process logs, metrics, or data that can be delayed without immediate impact.
- **External message queues**: Services that handle messaging or event streaming, such as AWS SQS or Kafka, for non-critical processing.
- **Notification or logging services**: Systems that log or notify without affecting core operations.

---

#### 2. **Implement Dead Letter Queues (DLQs) for Non-Critical Path Dependencies**

Dead Letter Queues (DLQs) are a mechanism for storing failed messages or requests that cannot be processed after multiple attempts. By implementing DLQs, you can ensure that failures in non-critical dependencies are captured and retried later without disrupting the system.

##### Step 1: Create DLQs for Non-Critical AWS SQS Queues

For services using AWS SQS to manage non-critical operations, configure a DLQ to capture messages that fail to be processed after a specified number of retries.

- **Create a DLQ** for an SQS queue:

```bash
aws sqs create-queue --queue-name NonCriticalDLQ
```

- **Configure the DLQ** for an existing SQS queue:

```bash
aws sqs set-queue-attributes --queue-url https://sqs.<region>.amazonaws.com/<account-id>/<queue-name>   --attributes RedrivePolicy='{'deadLetterTargetArn':'arn:aws:sqs:<region>:<account-id>:NonCriticalDLQ', 'maxReceiveCount':'5'}'
```

This setup ensures that any message that fails after 5 attempts is sent to the DLQ for further investigation or manual processing.

##### Step 2: Enable DLQs for Lambda Functions

For **Lambda functions** that handle non-critical tasks, configure a DLQ to capture any event that fails processing after the maximum number of retries.

```bash
aws lambda update-function-configuration --function-name <function-name>   --dead-letter-config TargetArn=arn:aws:sqs:<region>:<account-id>:NonCriticalDLQ
```

This ensures that any failed events are moved to the DLQ for manual intervention or debugging later.

---

#### 3. **Implement Retry Strategies**

For non-critical dependencies, configure retry strategies to allow for automatic retries before sending failed requests to the DLQ. This reduces the number of messages or events sent to the DLQ by allowing the system to recover from temporary issues, such as transient network failures.

##### Step 1: Configure Retry Policies for SQS and Lambda

You can configure retry policies for **SQS** and **Lambda** to handle temporary failures gracefully.

- **SQS Retry Policy**:

For SQS, retries are managed through the visibility timeout and max receive count settings. When a message fails, it becomes visible again after the visibility timeout, allowing it to be retried.

```bash
aws sqs set-queue-attributes --queue-url https://sqs.<region>.amazonaws.com/<account-id>/<queue-name>   --attributes VisibilityTimeout=60,MaxReceiveCount=5
```

- **Lambda Retry Policy**:

For Lambda, AWS automatically retries failed invocations twice by default for asynchronous invocations. You can increase this by implementing custom retry logic within the Lambda function or by chaining invocations with a Step Function that handles retries.

##### Step 2: Implement Backoff for API Requests

For non-critical third-party API calls, implement exponential backoff strategies to handle transient failures. This reduces the load on the system and increases the chances of recovery without overwhelming the API.

- **Example in Node.js**:

```javascript
const axios = require('axios');

async function callApiWithRetries(url, retries = 3) {
    for (let i = 0; i < retries; i++) {
        try {
            const response = await axios.get(url);
            return response.data;
        } catch (error) {
            if (i === retries - 1) {
                throw new Error(`Failed after $\{retries} attempts`);
            }
            await new Promise(resolve => setTimeout(resolve, Math.pow(2, i) * 1000)); // Exponential backoff
        }
    }
}
```

This code retries the API call with an exponential backoff before throwing an error if all attempts fail.

---

#### 4. **Graceful Degradation and Fallback Mechanisms**

For non-critical dependencies that may fail or be unavailable, implement graceful degradation and fallback mechanisms to allow the system to continue operating with reduced functionality.

##### Step 1: Implement Fallback Logic

For external APIs or services, implement fallback logic that either uses cached data or default values if the service is unavailable.

- **Example**:

```javascript
async function fetchUserProfile(userId) {
    try {
        const response = await callExternalService(userId);
        return response.data;
    } catch (error) {
        console.log('External service unavailable, using cached data.');
        return getCachedUserProfile(userId); // Fallback to cached data
    }
}
```

This ensures that the system can still return useful data even if the external service is down.

##### Step 2: Implement Circuit Breakers

Use circuit breakers to automatically stop sending requests to a failing dependency. This prevents cascading failures and allows the system to recover once the dependency becomes available again.

- **Example with a Circuit Breaker Library**:

```javascript
const CircuitBreaker = require('opossum');

const options = {
    timeout: 3000, // If request takes longer than 3 seconds, trigger failure
    errorThresholdPercentage: 50, // Fail if 50% of requests fail
    resetTimeout: 30000 // Retry the request after 30 seconds
};

const breaker = new CircuitBreaker(callExternalService, options);

breaker.fallback(() => getCachedUserProfile(userId));

breaker.fire(userId)
    .then(result => console.log(result))
    .catch(error => console.log('Circuit breaker triggered:', error));
```

---

#### 5. **Monitoring and Alerting on DLQs**

Set up monitoring and alerting on Dead Letter Queues to ensure that messages are processed or retried after being sent to the DLQ. This ensures that failures in non-critical dependencies are noticed and addressed promptly.

##### Step 1: Configure CloudWatch Alarms for DLQ Messages

Set up **CloudWatch Alarms** to monitor the number of messages in the DLQ. If the number exceeds a threshold, trigger an alert to the on-call team.

- **CloudWatch Alarm for DLQ**:

```bash
aws cloudwatch put-metric-alarm --alarm-name 'DLQMessageCountAlarm'   --metric-name ApproximateNumberOfMessagesVisible --namespace AWS/SQS   --statistic Sum --period 300 --threshold 10   --comparison-operator GreaterThanThreshold --evaluation-periods 1   --alarm-actions <SNS-Topic-ARN>   --dimensions Name=QueueName,Value=NonCriticalDLQ
```

This triggers an alert when there are more than 10 messages in the DLQ, indicating that failures need to be investigated.

##### Step 2: Set Up Automated Remediation for DLQ Messages

In addition to monitoring, set up automated remediation processes to periodically retry or process messages in the DLQ. For example, create a Lambda function that periodically reads messages from the DLQ and attempts to process them again.

---

### Acceptance Criteria
- Should have reviewed all non-critical path dependencies and identified those that need DLQs, retries, or fallback mechanisms.
- Should have implemented Dead Letter Queues (DLQs) for SQS, Lambda, and other non-critical components where failures may occur.
- Should have implemented retry strategies, including exponential backoff for API calls and configured retries for SQS and Lambda.
- Should have implemented graceful degradation mechanisms to allow the system to continue operating during dependency failures.
- Should have set up monitoring and alerting for Dead Letter Queues to ensure that failures are tracked and addressed.
- Should have documented the handling of failures and the process for reviewing DLQ messages and retrying them
