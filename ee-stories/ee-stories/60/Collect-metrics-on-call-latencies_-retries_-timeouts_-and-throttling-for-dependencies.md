## Summary
**As a** DevOps engineer or SRE, **I want** to collect metrics on call latencies, retries, timeouts, and throttling for dependencies, **so that** I can monitor the performance and reliability of external services and system dependencies, ensuring that the application can handle degraded performance, failures, or bottlenecks in a graceful and efficient manner.

These metrics provide insight into how dependencies behave under different load conditions and can help identify issues such as slow response times, frequent retries, or throttling from external services. This data allows for proactive improvements to system performance, fault tolerance, and resource management.

### Vision
By collecting detailed metrics on latencies, retries, timeouts, and throttling for dependencies, the system can be continuously monitored for potential bottlenecks or failures in external services. This ensures that the application remains resilient and that any issues with dependencies are caught and addressed before they impact overall system performance or user experience.

### Background
Applications often rely on external services (APIs, databases, third-party systems) that can experience latency, throttling, or failures. Monitoring metrics such as call latencies, retries, and timeouts for these dependencies is crucial for understanding how the system interacts with them and ensuring that any performance issues are detected early. Throttling and retry metrics also provide insight into whether the system is hitting rate limits or if external services are underperforming.

### Purpose
The purpose of this story is to implement mechanisms to collect and monitor key metrics related to external service dependencies, such as latencies, retries, timeouts, and throttling. These metrics will be displayed on an operational dashboard, with alerting set up for anomalies, allowing the team to respond quickly to issues and optimize system performance.

## Details

### 1. **Identify Key Metrics to Collect**
   - **Call Latencies**:
     - Measure the response time for calls to external dependencies (e.g., API calls, database queries). Latency metrics provide insight into the performance of external services and allow the system to identify if dependencies are slowing down under load.
     - Key metrics to track:
       - **Request latency**: Time taken for a request to complete (e.g., average, 90th percentile, 99th percentile latencies).
       - **Peak latency**: Latency during periods of high traffic.

   - **Retries**:
     - Measure the number of times a call to a dependency needs to be retried due to failures, timeouts, or throttling. Retry metrics can indicate network instability or service unreliability.
     - Key metrics to track:
       - **Retry count**: Number of retries made before a request succeeds.
       - **Retry rate**: Percentage of calls that required retries.

   - **Timeouts**:
     - Measure the number of calls to external dependencies that time out due to delays or unresponsive services. High timeout rates can indicate issues with external services or network problems.
     - Key metrics to track:
       - **Timeout count**: Number of requests that timed out.
       - **Timeout rate**: Percentage of requests that timed out compared to the total number of requests.

   - **Throttling**:
     - Measure the number of requests that are throttled due to exceeding rate limits imposed by external services. Throttling metrics provide insight into whether the system is making too many requests to a dependency and hitting service limits.
     - Key metrics to track:
       - **Throttled requests count**: Number of requests throttled by an external service.
       - **Throttling rate**: Percentage of throttled requests relative to total requests.
       - **Service quota utilization**: How close the system is to reaching service quotas or rate limits.

### 2. **Collecting Metrics**
   - **AWS SDK Instrumentation**:
     - For services using AWS SDKs (e.g., DynamoDB, S3, Lambda), enable **AWS SDK Metrics** to collect latency, retry, and throttling data automatically. These metrics can be published to **CloudWatch** and monitored via dashboards.
     - Example of enabling metrics in an AWS SDK call:
       ```javascript
       const AWS = require('aws-sdk');
       AWS.config.logger = console;
       const dynamoDB = new AWS.DynamoDB.DocumentClient();
       ```

   - **Custom Middleware for API Requests**:
     - Implement middleware or interceptors for API calls to external services (e.g., REST or GraphQL APIs) to capture metrics for latency, retries, and timeouts. Use libraries such as **Axios**, **Fetch API**, or **Node.js request-promise** for capturing and logging the required metrics.
       - Example with Axios:
         ```javascript
         const axios = require('axios');

         axios.interceptors.request.use((config) => {
           config.metadata = { startTime: new Date() };
           return config;
         });

         axios.interceptors.response.use((response) => {
           const duration = new Date() - response.config.metadata.startTime;
           console.log(`Request to ${response.config.url} took ${duration} ms`);
           return response;
         }, (error) => {
           const duration = new Date() - error.config.metadata.startTime;
           console.log(`Request to ${error.config.url} failed after ${duration} ms`);
           return Promise.reject(error);
         });
         ```

   - **Database Queries**:
     - For database-related dependencies (e.g., RDS, MongoDB), capture query execution times and retry rates. Most database drivers provide logging or hooks to capture metrics for query latencies and failures.
     - Example using **pg** for PostgreSQL:
       ```javascript
       const { Client } = require('pg');
       const client = new Client();
       client.on('query', (query) => {
         const start = Date.now();
         query.on('end', () => {
           console.log(`Query took ${Date.now() - start} ms`);
         });
       });
       ```

   - **HTTP Call Instrumentation with Prometheus**:
     - Use **Prometheus** to collect metrics from your services, including HTTP request latencies, retries, timeouts, and throttling. Set up Prometheus exporters to track these metrics and display them on a dashboard.
       - Example PromQL query for latency tracking:
         ```promql
         histogram_quantile(0.99, sum(rate(http_request_duration_seconds_bucket{job="api-service"}[5m])) by (le))
         ```

   - **AWS CloudWatch Metrics**:
     - For AWS services, collect throttling, retries, and latency metrics directly from **CloudWatch**. Services like **DynamoDB**, **API Gateway**, **S3**, and **Lambda** provide built-in metrics such as **ThrottledRequests**, **Latency**, and **ProvisionedThroughputExceededExceptions**.
     - Example of DynamoDB throttling metric in CloudWatch:
       - Metric: `ThrottledRequests`
       - Namespace: `AWS/DynamoDB`

   - **Retries and Timeouts with Circuit Breakers**:
     - Implement a **circuit breaker pattern** (e.g., using **Hystrix**, **Resilience4j**, or **Istio**) to capture retries and timeouts and provide more fine-grained control over how the system handles dependency failures.
       - Example: Use **Resilience4j** to set thresholds for retry attempts and track when timeouts or retries occur.

### 3. **Storing and Analyzing Metrics**
   - **CloudWatch Dashboards**:
     - Set up **AWS CloudWatch Dashboards** to monitor the key metrics for external dependencies in real-time. Add widgets for latency, retry, timeout, and throttling metrics for each dependency. Create alarms for unusual patterns (e.g., high retry rates, increased latency).

   - **Prometheus and Grafana**:
     - For services using **Prometheus**, set up **Grafana** dashboards to display key metrics such as HTTP request latencies, retries, and timeouts. Configure alerts to detect anomalies and send notifications to the operations team.

   - **Datadog/New Relic Dashboards**:
     - Use monitoring platforms like **Datadog** or **New Relic** to visualize call latencies, retries, timeouts, and throttling metrics. These tools provide built-in integrations with many external services and can be used to track detailed performance metrics.

### 4. **Alerting for Anomalies**
   - **CloudWatch Alarms**:
     - Set up **CloudWatch Alarms** for latency, throttling, and retry metrics. For example, trigger an alarm if the average latency for API requests exceeds a predefined threshold or if the retry rate surpasses 5%.
       - Example: Trigger an alarm if `ThrottledRequests` in DynamoDB exceeds 100 in a 5-minute period.

   - **Prometheus Alerts**:
     - Configure **Prometheus Alertmanager** to send notifications when certain thresholds are breached. For example, create alerts for high timeout rates or when retry attempts increase over a certain threshold.
       - Example Prometheus alert:
         ```yaml
         - alert: HighLatency
           expr: histogram_quantile(0.99, sum(rate(http_request_duration_seconds_bucket[5m])) by (le)) > 0.5
           for: 10m
           labels:
             severity: critical
           annotations:
             summary: "High latency detected for API service"
         ```

   - **Datadog/New Relic Alerts**:
     - Create alerts in **Datadog** or **New Relic** for high latency, retries, or throttling incidents. Configure these alerts to send notifications via Slack, PagerDuty, or email when thresholds are exceeded.

### Testing
- **Simulate High Load**:
   - Simulate high traffic

 loads on the system to test the collection of latency, retry, timeout, and throttling metrics. Use load testing tools like **JMeter** or **Gatling** to generate requests and observe how the system behaves under pressure.

- **Fault Injection**:
   - Use chaos engineering tools (e.g., **Chaos Monkey**) to introduce faults (e.g., network delays, service failures) and observe the impact on latency, retries, and timeouts. Ensure that the metrics capture and reflect these faults accurately.

- **Alert Testing**:
   - Simulate scenarios that would trigger alerts (e.g., increased latency or retry rates) to ensure that the alerting system is functioning as expected.

### External Dependencies
- Monitoring platforms (e.g., AWS CloudWatch, Prometheus, Datadog, New Relic) to collect and visualize dependency metrics.
- External dependencies such as APIs, databases, or third-party services that the application interacts with.
- Load testing tools (e.g., JMeter, Gatling) for simulating traffic and testing latency, retries, and timeouts.

## Acceptance Criteria
- Should collect and display metrics for call latencies, retries, timeouts, and throttling for all dependencies.
- Should provide real-time visibility into dependency performance on an operational dashboard.
- Should configure alerts to notify the team when latency, retry, or throttling rates exceed acceptable thresholds.
- Should test the collection of metrics under real-world and simulated conditions to ensure accurate monitoring.

### Gherkin
```gherkin
Given an external API dependency
When the system makes requests to the API
Then the system should collect metrics for call latencies, retries, timeouts, and throttling
And display these metrics on the operational dashboard.
```
```gherkin
Given a high load scenario on external dependencies
When the system experiences increased latencies or retries
Then the monitoring tools should capture the metrics accurately
And the alerting system should trigger notifications for abnormal thresholds.
```

## API
N/A

## External Links
- [AWS CloudWatch Metrics](https://docs.aws.amazon.com/cloudwatch/index.html)
- [Prometheus Monitoring Documentation](https://prometheus.io/docs/introduction/overview/)
- [Hystrix Circuit Breaker Documentation](https://github.com/Netflix/Hystrix)
