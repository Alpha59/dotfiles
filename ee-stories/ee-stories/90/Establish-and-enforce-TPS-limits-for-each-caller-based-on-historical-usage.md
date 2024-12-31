## Summary
**As a** DevOps engineer or cloud architect, **I want** to **establish and enforce Transactions Per Second (TPS) limits for each caller based on historical usage**, **so that** system resources are protected from overuse and service reliability is maintained during traffic spikes or unexpected surges.

Setting TPS limits helps control the rate at which individual clients or services can send requests, preventing any single caller from overwhelming the system. By basing these limits on historical usage data, the system can enforce realistic thresholds that accommodate normal traffic patterns while protecting against potential overloads.

### Vision
By establishing and enforcing TPS limits for each caller, the team will implement safeguards that ensure fair usage, protect service availability, and improve overall system stability. This will prevent any caller from consuming an excessive share of system resources, leading to better service quality for all users.

### Background
TPS limits control the maximum number of requests a client can send to a service per second. Without rate limiting, a caller experiencing a traffic surge or an unintentional flood of requests could overwhelm the service, leading to degraded performance or outages. Rate limiting is often implemented at the API gateway or service level, where individual limits can be set based on the caller’s typical usage patterns.

### Purpose
The purpose of this story is to establish TPS limits for each caller based on historical usage, enforce these limits through automated mechanisms, and implement monitoring to ensure adherence.

## Details

### 1. **Analyze Historical Usage to Determine Appropriate TPS Limits**
   - Collect historical usage data for each caller over a representative period (e.g., the last 3-6 months) to identify typical request rates and peak traffic patterns.
   - Use this data to calculate **baseline TPS values** for each caller, considering:
     - **Average TPS**: The average number of requests per second over time.
     - **Peak TPS**: The highest recorded TPS during bursts of activity.
     - **Seasonal or Event-Based Spikes**: Adjust for known periods of higher traffic (e.g., sales events).
   - Determine an appropriate buffer above the baseline TPS to accommodate normal traffic variability without setting limits too high.

   **Example Calculations**:
   - **Average TPS**: 100 requests/second.
   - **Peak TPS (90th percentile)**: 200 requests/second.
   - **Buffer (20%)**: 240 requests/second limit for safety margin.

### 2. **Set Up Rate Limiting at the API Gateway or Service Level**
   - Implement TPS limits using a rate-limiting solution such as:
     - **AWS API Gateway**: Supports throttling and rate-limiting configurations.
     - **Nginx or Kong Gateway**: Can be used with custom rate-limiting plugins.
     - **AWS Lambda Authorizer**: Use Lambda functions to dynamically enforce rate limits based on caller identity.
   - Configure limits per caller (e.g., per API key or IP address), and specify **burst limits** (maximum allowed requests in a short window) and **rate limits** (sustained rate over time).

   **Example AWS API Gateway Configuration**:
   - **Burst Limit**: 500 requests (allows short bursts of traffic).
   - **Rate Limit**: 240 requests/second (sustained rate based on historical data).

   **AWS CLI Example for Setting Rate Limits**:
   ```bash
   aws apigateway update-stage --rest-api-id <API_ID> \
       --stage-name <STAGE_NAME> \
       --patch-operations op=replace,path=/throttling/rateLimit,value=240
   ```

### 3. **Dynamically Adjust Limits Based on Real-Time Monitoring**
   - Implement logic to temporarily adjust TPS limits based on real-time metrics, such as:
     - **Current Load**: Increase limits if the system is underutilized.
     - **Error Rates or Latency**: Lower limits if errors or high latency are detected.
   - Use services like **AWS CloudWatch**, **Datadog**, or **Prometheus** to monitor these metrics and trigger limit adjustments as needed.

### 4. **Set Up Alerting for TPS Limit Breaches**
   - Configure alerts to notify the team when callers approach or exceed their TPS limits.
   - Use monitoring tools to detect anomalies, such as:
     - **Frequent Breaches**: Indicates that the current limit might be set too low.
     - **Sudden Traffic Spikes**: Might signal a potential misuse or a denial-of-service attack.
   - Alert thresholds could be set at **80% of the limit** to give advance warning.

   **Example AWS CloudWatch Alarm Setup**:
   ```bash
   aws cloudwatch put-metric-alarm --alarm-name "TPSLimitApproaching" \
       --metric-name "Count" --namespace "AWS/ApiGateway" \
       --statistic "Sum" --period 60 --threshold 192 \
       --comparison-operator "GreaterThanThreshold" --dimensions Name=ApiName,Value=MyAPI \
       --evaluation-periods 1 --alarm-actions <SNS-topic-arn>
   ```

### 5. **Implement Error Handling for Rate-Limited Requests**
   - Configure the system to return a **HTTP 429 (Too Many Requests)** status code when a caller exceeds their TPS limit.
   - Include a **retry-after** header in the response to inform the caller when to retry.
   - Implement exponential backoff and retry logic on the client side to handle rate-limited responses gracefully.

   **Example Error Response Handling**:
   ```json
   {
       "statusCode": 429,
       "message": "Rate limit exceeded. Please retry after 10 seconds.",
       "retryAfter": 10
   }
   ```

### 6. **Document the Rate Limiting Strategy in the Runbook**
   - Update the team’s runbook to include the rate limiting policy, detailing:
     - **How limits are calculated** based on historical data.
     - **Configuration steps for API Gateway or other rate-limiting tools**.
     - **Alert setup instructions** for monitoring TPS breaches.
     - **Guidelines for adjusting limits** and troubleshooting rate-limited requests.
   - Provide best practices for clients interacting with the API to avoid hitting rate limits.

### Testing
- **Simulate Different Traffic Levels**: Verify that TPS limits are enforced correctly under normal, burst, and excessive traffic conditions.
- **Test Alert Triggers**: Ensure alerts activate when thresholds are approached or exceeded.
- **Client-Side Error Handling**: Test that clients receive proper error messages when rate limits are exceeded and can retry appropriately.

### Acceptance Criteria
- Should analyze historical usage to determine appropriate TPS limits for each caller.
- Should implement rate limiting at the API gateway or service level, with configuration for burst and sustained limits.
- Should dynamically adjust TPS limits based on real-time metrics when necessary.
- Should configure alerts for when usage approaches or exceeds TPS limits.
- Should implement proper error handling for rate-limited requests.
- Should document the rate limiting strategy and configurations in the team’s runbook.

### External Links
- [AWS API Gateway Throttling and Rate Limits](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-request-throttling.html)
- [Nginx Rate Limiting Guide](https://docs.nginx.com/nginx/admin-guide/security-controls/controlling-access-proxied-http/)
- [Rate Limiting Best Practices](https://cloud.google.com/architecture/rate-limiting-strategies-and-techniques)
