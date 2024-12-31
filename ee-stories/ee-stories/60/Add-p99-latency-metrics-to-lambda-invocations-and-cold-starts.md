## Summary
**As a** DevOps engineer or software engineer, **I want** to add **p99 latency metrics** to AWS Lambda invocations and cold starts, **so that** I can monitor the performance of my Lambda functions and ensure that 99% of requests are meeting acceptable latency thresholds, especially during cold starts.

p99 latency represents the 99th percentile of latency, meaning 99% of the requests should have a latency less than or equal to the recorded p99 value. By tracking this metric, particularly for Lambda invocations and cold starts, we can monitor and improve the performance of Lambda functions and detect performance bottlenecks or cold start issues.

### Vision
By adding p99 latency metrics to Lambda invocations and cold starts, the team will have better visibility into the performance of Lambda functions. This will allow for faster identification of performance issues, especially with cold starts, and ensure that the system meets latency requirements for 99% of requests. Tracking these metrics helps in optimizing Lambda functions and scaling configurations, ensuring smooth operation even under high loads.

### Background
AWS Lambda functions can experience variability in execution time due to cold starts (initial invocation delays when the function is invoked after being idle). Monitoring average latency alone may not provide sufficient insights, as p99 latency helps highlight edge cases where the function is slower than expected. Cold starts can cause performance degradation, and measuring the p99 latency can help detect when and how often these issues occur.

### Purpose
The purpose of this story is to implement p99 latency metrics for Lambda function invocations and cold starts. These metrics will be captured, stored, and visualized on monitoring dashboards, providing insights into the worst-case latencies experienced by users. This allows the team to take corrective actions if latency is higher than acceptable thresholds.

## Details

### 1. **Capture Latency Metrics for Lambda Invocations**
   - **Invocation Latency**:
     - Lambda invocation latency refers to the total time taken to execute the function from the moment it is triggered until the response is returned.
     - AWS CloudWatch already provides basic invocation duration metrics. However, p99 latency requires calculating the 99th percentile for more detailed performance insights.

   - **Cold Start Latency**:
     - A cold start occurs when a Lambda function is invoked for the first time after being idle, causing the environment to be initialized. Cold start latency can significantly impact the performance of Lambda functions.
     - Cold start invocations can be identified by tracking the **Init Duration** metric, which AWS exposes for cold starts.

   - **AWS CloudWatch Metrics for Lambda**:
     - **Duration**: CloudWatch automatically tracks the `Duration` of each Lambda invocation. You can query these metrics to calculate p99 latency.
     - **Init Duration**: AWS provides the **Init Duration** metric specifically for cold starts. This metric can be used to monitor cold start latencies separately.

### 2. **Enable and Collect p99 Latency Metrics**
   - **CloudWatch Custom Metrics**:
     - Use **AWS CloudWatch** to capture and store custom metrics that track the 99th percentile latency for both invocation duration and cold start latency.
     - Lambda invocation metrics (`Duration`) are stored in CloudWatch by default, but to track p99 latency specifically, you’ll need to calculate the 99th percentile using CloudWatch Insights or custom metrics.

   - **Log and Calculate p99 Latency**:
     - Set up a Lambda function to log `Duration` and `Init Duration` metrics for each invocation. Use these metrics to calculate p99 latency.
     - Example CloudWatch Insights query to calculate p99 latency:
       ```sql
       stats p99(Duration) as p99_latency
       by bin(5m)
       ```

   - **Custom Metric for Cold Starts**:
     - Track cold starts using the `Init Duration` metric. Log the initialization time separately and calculate p99 cold start latency.
       ```sql
       stats p99(InitDuration) as p99_cold_start_latency
       by bin(5m)
       ```

   - **Visualization and Monitoring**:
     - Create a CloudWatch dashboard to visualize p99 latency for both invocation and cold start latencies.
     - Add visualizations such as graphs or heatmaps that display p99 latency trends over time, allowing you to monitor performance across different time windows (e.g., 5 minutes, 1 hour).

### 3. **Calculate and Monitor p99 Latency**
   - **Aggregation with CloudWatch Insights**:
     - Use CloudWatch Insights to aggregate Lambda function invocation logs and calculate the p99 latency dynamically.
     - Example query for invocation latency:
       ```sql
       filter @type = "REPORT"
       | stats p99(@duration) as p99_latency
       by bin(1m)
       ```
     - Example query for cold start latency:
       ```sql
       filter @type = "REPORT"
       | filter @initDuration > 0
       | stats p99(@initDuration) as p99_cold_start_latency
       by bin(1m)
       ```

   - **Set Up CloudWatch Alarms**:
     - Create alarms that trigger when p99 latency exceeds a predefined threshold. For example, if the p99 latency for Lambda invocations exceeds 300ms, an alert can be sent to the DevOps team.
     - Example alarm for high p99 latency:
       - Metric: p99 latency (calculated from CloudWatch Insights)
       - Threshold: > 300ms
       - Action: Trigger alert via email, SMS, or integration with PagerDuty/Slack.

### 4. **Optimize Lambda Functions for Latency**
   - **Memory Allocation**:
     - Adjust the memory allocation for your Lambda functions. Lambda automatically allocates CPU power based on the memory allocation, so increasing the memory might reduce latency, including cold start times.

   - **Provisioned Concurrency**:
     - Use **Provisioned Concurrency** for Lambda functions that are sensitive to cold starts. This ensures that pre-warmed instances are always available to serve requests, thus reducing cold start latency.
     - Example of enabling Provisioned Concurrency via AWS CLI:
       ```bash
       aws lambda put-provisioned-concurrency-config \
         --function-name myFunction \
         --provisioned-concurrent-executions 10
       ```

   - **Optimize Lambda Deployment Package**:
     - Ensure the Lambda function package size is small to reduce cold start times. Using smaller deployment packages (fewer dependencies) can lead to faster initialization during cold starts.

   - **Monitoring Cold Start Frequency**:
     - Monitor how often cold starts occur and how they impact the p99 latency. If cold starts are frequent, consider enabling provisioned concurrency or optimizing the function’s initialization process.

### 5. **Visualization and Reporting**
   - **Create Dashboards**:
     - Set up **AWS CloudWatch Dashboards** to display p99 latency for both invocations and cold starts. The dashboard should show latency trends over different time periods and provide visual indicators when latency exceeds acceptable thresholds.
     - Example dashboard:
       - Graph 1: p99 invocation latency (all invocations)
       - Graph 2: p99 cold start latency (cold starts only)

   - **Automated Reports**:
     - Automate the generation of latency reports, including p99 metrics, and send them to relevant stakeholders. Use CloudWatch or a third-party tool (e.g., Datadog) to generate and send regular performance reports.

### Testing
- **Load Testing**:
   - Perform load testing to simulate high traffic and validate that the p99 latency metrics are being captured correctly. Use tools like **Gatling** or **Apache JMeter** to generate concurrent Lambda invocations and observe how p99 latency behaves under load.

- **Cold Start Testing**:
   - Test cold starts by simulating idle periods, triggering cold invocations, and ensuring that cold start latency is logged and captured accurately.

- **Alert Testing**:
   - Test CloudWatch alarms by artificially exceeding the p99 latency threshold (e.g., reduce memory allocation or increase cold start frequency) to ensure that alerts are triggered as expected.

### External Dependencies
- **AWS CloudWatch** for collecting and storing Lambda metrics (e.g., `Duration`, `Init Duration`).
- Monitoring and alerting systems (e.g., **AWS CloudWatch Alarms**, **Datadog**, **PagerDuty**) to track latency and send notifications.
- **Load testing tools** (e.g., **Gatling**, **JMeter**) to simulate traffic and measure Lambda performance.

## Acceptance Criteria
- Should capture p99 latency metrics for both Lambda invocations and cold starts.
- Should display these metrics on CloudWatch dashboards, visualizing trends over time.
- Should set up alarms that trigger when p99 latency exceeds predefined thresholds for invocations or cold starts.
- Should optimize Lambda function performance to reduce p99 latency where possible.

### Gherkin
```gherkin
Given a Lambda function is invoked
When the function completes execution
Then the p99 latency for the invocation should be calculated and logged
And the p99 latency should be displayed on the CloudWatch dashboard.
```
```gherkin
Given a cold start occurs during a Lambda invocation
When the initialization takes longer than usual
Then the p99 cold start latency should be calculated and displayed on the CloudWatch dashboard.
```

## API
N/A

## External Links
- [AWS Lambda Performance Optimization](https://docs.aws.amazon.com/lambda/latest/dg/best-practices.html)
- [AWS CloudWatch Insights Documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html)
- [AWS Lambda Provisioned Concurrency](https://docs.aws.amazon.com/lambda/latest/dg/pro

visioned-concurrency.html)
