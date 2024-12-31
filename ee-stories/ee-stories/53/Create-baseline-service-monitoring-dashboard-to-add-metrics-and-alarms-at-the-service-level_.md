## Summary
**As a** cloud infrastructure engineer, **I want** to create a baseline service monitoring dashboard that displays key metrics and includes alarms at the service level, **so that** I can monitor the health and performance of services in real-time and detect issues early to ensure consistent system reliability and availability.

A baseline monitoring dashboard will consolidate the most critical service metrics, providing clear visibility into the performance and health of services. This dashboard will include metrics for resource utilization, request handling, error rates, and latency, along with alarms that notify the team when thresholds are exceeded, helping ensure a proactive response to potential issues.

### Vision
By establishing a baseline monitoring dashboard, the team will have immediate visibility into key service-level metrics, such as CPU and memory usage, request latency, error rates, and throughput. This will improve our ability to maintain operational excellence, detect anomalies early, and minimize the risk of downtime. Alarms will ensure that any deviations from normal behavior are caught and addressed quickly.

### Background
Currently, there may not be a centralized dashboard for service-level monitoring, making it difficult to track critical metrics in real-time and detect early signs of system degradation. Setting up a baseline service monitoring dashboard will streamline observability and help maintain a high level of service availability. Adding alarms will further enhance our ability to respond quickly to potential issues.

### Purpose
The purpose of this story is to create a baseline monitoring dashboard that includes essential service metrics and alarms, helping the team monitor and maintain system health, detect issues in real-time, and minimize the impact of service disruptions.

## Details

### 1. **Define Key Service Metrics**
   - **CPU Usage**:
     - Monitor CPU utilization for each service to ensure that resource usage remains within expected limits. High CPU usage could indicate resource constraints or inefficient processing.

   - **Memory Usage**:
     - Track memory utilization for services (e.g., via CloudWatch Agent for EC2 instances or ECS Container Insights for containerized services). High memory usage can lead to performance degradation or crashes.

   - **Request Latency**:
     - Measure the time it takes for requests to be processed by each service. Higher-than-expected latency may indicate bottlenecks or performance issues.

   - **Request Rate/Throughput**:
     - Monitor the number of requests each service is handling to ensure it is operating within expected traffic levels. Sudden spikes or drops may require investigation.

   - **Error Rates**:
     - Track the rate of 4xx and 5xx errors for each service to ensure customers are not experiencing issues. A high error rate could indicate problems with service availability or functionality.

   - **Disk I/O**:
     - For services that rely heavily on disk usage (e.g., databases or file storage), track disk I/O performance to detect bottlenecks or resource saturation.

### 2. **Create CloudWatch Dashboards for Service Metrics**
   - **Setup Dashboards**:
     - Create AWS CloudWatch dashboards that display key service-level metrics in real-time. Each dashboard should have widgets displaying CPU usage, memory usage, request latency, error rates, and request rate.
     - Use a consistent layout to ensure that all services have similar monitoring views for easier comparison and analysis.

   - **Add Service Grouping**:
     - Group services together on the dashboard if they are related or dependent on each other (e.g., front-end services, back-end services, databases). This helps in understanding the overall service flow and how each component affects others.

   - **Metric Visualization**:
     - Use appropriate visualization types for each metric:
       - **Line charts** for CPU and memory utilization over time.
       - **Bar charts** for request rates or error counts.
       - **Gauge widgets** for real-time views of current resource usage against thresholds.

### 3. **Set Up CloudWatch Alarms for Key Metrics**
   - **Define Alarm Thresholds**:
     - Set alarm thresholds for each critical service metric to detect when a service is behaving abnormally:
       - **CPU Usage Alarm**: Trigger an alarm if CPU usage exceeds 80% for more than 5 minutes.
       - **Memory Usage Alarm**: Trigger an alarm if memory usage exceeds 85%.
       - **Latency Alarm**: Trigger an alarm if request latency exceeds a set threshold (e.g., 500ms) for more than 3 minutes.
       - **Error Rate Alarm**: Trigger an alarm if the rate of 4xx or 5xx errors exceeds 5% of total requests for 5 minutes.

   - **Notification Setup**:
     - Configure notifications via Amazon SNS to alert the team when any of the alarms are triggered. Alerts should be sent to relevant communication channels, such as Slack, email, or SMS, depending on the severity.
     - Separate alerts by priority, where critical alarms (e.g., service unavailability) trigger urgent notifications, while lower-priority issues (e.g., performance degradation) trigger warnings.

### 4. **Customize for Specific Service Types**
   - **API Gateway Services**:
     - Monitor metrics such as `5XXError`, `Latency`, and `Count` for API Gateway endpoints. Create alarms for spikes in 5xx errors and increased latency.

   - **ECS/EKS Containers**:
     - For containerized services, use Container Insights to track memory and CPU utilization for individual containers. Ensure that alarms are set for each container running in ECS or EKS clusters.

   - **Database Services**:
     - For RDS or other database services, monitor disk I/O, CPU, and memory usage. Set alarms for slow query response times, high read/write latency, and resource exhaustion.

### 5. **Dashboards for Historical Analysis**
   - Enable historical data analysis by storing metrics in CloudWatch for a set retention period. This allows the team to analyze trends and performance over time.
   - Use the dashboard to compare performance between peak and off-peak hours, helping to forecast and plan for resource scaling.

### 6. **Continuous Improvement**
   - Periodically review and adjust the dashboard and alarms based on changes in service architecture or traffic patterns.
   - Add additional metrics or alarms as needed to accommodate new features, services, or performance goals.
   - Use feedback from team members to enhance the dashboard's usability and effectiveness.

### Testing
- **Test Metric Collection**:
   - Ensure that metrics are being collected accurately by simulating high load or resource usage on services and verifying that the dashboard updates in real-time.

- **Test Alarms**:
   - Simulate conditions that exceed the defined thresholds for CPU, memory, error rates, and latency to ensure that alarms are triggered and notifications are sent.

- **Test Dashboard Layout**:
   - Verify that the CloudWatch dashboard is user-friendly, easy to read, and provides a clear view of all key service metrics.

### External Dependencies
- CloudWatch metrics should be enabled and available for all services (EC2, ECS, EKS, API Gateway, RDS, etc.).
- SNS topics or other notification channels should be configured for sending alerts to the team.

## Acceptance Criteria
- Should have a CloudWatch dashboard displaying key service-level metrics, including CPU usage, memory usage, request latency, request rate, and error rates.
- Should have CloudWatch alarms configured for each key metric with appropriate thresholds and notifications.
- Should have alarms tested and verified to trigger correctly when service thresholds are exceeded.
- Should have historical data available for analysis on the dashboard for performance trends and service optimization.

### Gherkin
```gherkin
Given a service is deployed and running
When memory usage exceeds 85% for more than 5 minutes
Then an alarm should trigger and notify the team.
```
```gherkin
Given a request is processed by the API
When the latency exceeds 500ms for 3 minutes
Then the CloudWatch dashboard should display the latency and an alarm should trigger.
```

## API
N/A

## External Links
- [AWS CloudWatch Dashboards Documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Dashboards.html)
- [AWS CloudWatch Alarms Documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html)
- [AWS Container Insights for ECS and EKS](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ContainerInsights.html)
