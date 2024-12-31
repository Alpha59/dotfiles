## Summary
**As a** DevOps engineer, **I want** to implement **success and failure metrics** around all **Lambda invocations**, **so that** I can monitor the reliability and performance of the Lambda functions, and quickly identify and address any failures or performance issues.

Tracking success and failure metrics for Lambda invocations is critical for ensuring that serverless applications run smoothly. These metrics allow teams to gain visibility into Lambda performance, detect failed invocations, and improve the overall reliability of the system.

### Vision
By implementing success and failure metrics for all Lambda invocations, the system will automatically monitor the performance of Lambda functions, providing real-time insights into their success rate and any errors. This will ensure better visibility into function performance, enabling proactive issue resolution and maintaining service reliability.

### Background
AWS Lambda is a key component of serverless architectures, executing code in response to events. However, if Lambda invocations fail or experience errors, it can lead to service disruptions. Implementing success and failure metrics helps monitor the health of Lambda functions and ensures that any issues are quickly detected and addressed.

### Purpose
The purpose of this story is to implement tracking for success and failure metrics around Lambda invocations. This will include monitoring success rates, error rates, and the reasons for any failures, ensuring the system can quickly respond to performance issues.

## Details

### 1. **Enable CloudWatch Metrics for Lambda Functions**
   - Leverage **AWS CloudWatch** to capture key metrics for Lambda invocations:
     - **Invocations**: Total number of Lambda invocations.
     - **Errors**: Number of failed invocations due to execution errors (e.g., timeouts, exceptions).
     - **Throttles**: Number of invocations throttled due to exceeding concurrency limits.
     - **Duration**: Time taken for each invocation.

### 2. **Implement Success and Failure Metrics**
   - **Success Metric**: Track successful Lambda invocations by ensuring that the function executes without throwing an error or exception.
   - **Failure Metric**: Track failed invocations using the **Errors** metric from CloudWatch, which captures any invocation that results in an exception or timeout.

### 3. **Configure CloudWatch Alarms**
   - Set up CloudWatch alarms to notify the team when failure rates exceed a certain threshold (e.g., 5% failure rate over a given time period).
   - Create separate alarms for critical failure types, such as function timeouts or throttling events.

   **Example CloudWatch Alarm for Lambda Errors**:
   ```bash
   aws cloudwatch put-metric-alarm \
     --alarm-name "Lambda-Failure-Alarm" \
     --metric-name "Errors" \
     --namespace "AWS/Lambda" \
     --dimensions Name=FunctionName,Value=myLambdaFunction \
     --threshold 1 \
     --comparison-operator "GreaterThanThreshold" \
     --evaluation-periods 1 \
     --period 60 \
     --statistic "Sum" \
     --alarm-actions arn:aws:sns:region:account-id:alert-topic
   ```

### 4. **Visualize Metrics in Dashboards**
   - Set up CloudWatch dashboards to visualize success and failure rates for all Lambda functions.
   - Add graphs that display the number of invocations, failures, and error reasons (e.g., exceptions, timeouts).

### 5. **Set Up Notifications for Failures**
   - Use **SNS**, **Slack**, or **PagerDuty** to send notifications when failure thresholds are breached, ensuring that the team is alerted immediately when problems arise.

### Testing
- Test success and failure metrics by triggering both successful and failed Lambda invocations.
- Verify that metrics are accurately captured and alarms trigger as expected when failure rates exceed the threshold.

## Acceptance Criteria
- Should implement success and failure metrics for all Lambda invocations.
- Should set up alarms for Lambda failure rates exceeding predefined thresholds.
- Should visualize metrics in CloudWatch dashboards.
- Should configure notifications for failures to ensure prompt issue resolution.
