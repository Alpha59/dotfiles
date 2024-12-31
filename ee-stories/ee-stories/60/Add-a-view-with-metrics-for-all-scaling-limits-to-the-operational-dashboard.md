## Summary
**As a** DevOps engineer or infrastructure manager, **I want** to add a view with metrics for all scaling limits to the operational dashboard, **so that** I can monitor and track scaling limits across services and resources, ensuring the system can scale efficiently and avoid hitting resource limits that could impact performance.

This view will allow for real-time visibility into the current usage against scaling limits for resources like EC2 instances, containers, databases, and autoscaling groups. Monitoring these limits helps to proactively manage resource constraints and optimize scaling behavior.

### Vision
By adding a view with scaling metrics to the operational dashboard, teams can continuously monitor how close the system is to hitting scaling limits for various services. This ensures that any potential issues related to capacity limits (e.g., instance or task count, database connection limits) are caught early, and actions can be taken to prevent performance degradation or outages.

### Background
Cloud infrastructure often relies on autoscaling mechanisms to handle dynamic workloads. However, services such as EC2, ECS, and databases have predefined scaling limits that must be managed carefully. If scaling limits are reached (e.g., maximum instance count or database connections), it can lead to resource exhaustion and system failure. Tracking these limits on the operational dashboard allows for better capacity planning and optimization.

### Purpose
The purpose of this story is to create a view on the operational dashboard that displays scaling-related metrics for various cloud services and resources. This view will provide insights into current resource usage, scaling trends, and how close services are to their defined limits.

## Details

### 1. **Identify Scaling Metrics to Track**
   - **EC2 Autoscaling Groups**:
     - Track the current number of EC2 instances against the maximum limit set in the autoscaling group.
     - Metrics to include:
       - **Desired Capacity**: Number of instances the autoscaling group attempts to maintain.
       - **Current Capacity**: Number of instances currently running.
       - **Maximum Capacity**: Maximum number of instances allowed in the autoscaling group.

   - **ECS/EKS Cluster Scaling**:
     - Track the number of running tasks or pods against the scaling limits for container services.
     - Metrics to include:
       - **Running Tasks/Pods**: Number of tasks or pods currently running.
       - **Maximum Tasks/Pods**: Maximum number of tasks or pods the cluster is allowed to run.

   - **Lambda Concurrency Limits**:
     - Track AWS Lambda concurrency limits and usage.
     - Metrics to include:
       - **Concurrent Executions**: Number of concurrent Lambda function executions.
       - **Maximum Concurrency**: Maximum allowed concurrent executions for the Lambda functions.

   - **Database Scaling Limits**:
     - Track database scaling metrics such as connection limits, read/write capacity units (for DynamoDB), or instance sizes (for RDS).
     - Metrics to include:
       - **Database Connections**: Current number of active connections.
       - **Maximum Connections**: Maximum number of allowed connections.
       - **Provisioned Capacity**: Read/write capacity units for DynamoDB.

   - **API Gateway Rate Limits**:
     - Track API Gateway request limits and throttling.
     - Metrics to include:
       - **Request Count**: Number of requests being processed.
       - **Request Rate Limit**: Maximum requests allowed per second (RPS).
       - **Throttle Count**: Number of requests that have been throttled.

   - **S3 Request Limits**:
     - Track S3 request rate limits for large-scale operations.
     - Metrics to include:
       - **Request Rate**: Number of requests per second.
       - **Request Limit**: Maximum allowed request rate.

### 2. **Create Metric Queries for Scaling Limits**
   - **CloudWatch Metrics**:
     - Use AWS CloudWatch or an equivalent monitoring tool to collect the scaling-related metrics for each resource. Create metric queries that fetch the current usage, limit, and usage percentage relative to the limit.
     - Example CloudWatch metric queries:
       - **EC2 Autoscaling Group**:
         - `GroupInServiceInstances`: The number of running instances in the autoscaling group.
         - `GroupMaxSize`: The maximum size of the autoscaling group.
       - **Lambda**:
         - `ConcurrentExecutions`: The number of concurrent executions for a Lambda function.
         - `UnreservedConcurrentExecutions`: The maximum concurrency available for Lambda across all functions.

   - **Prometheus Metrics**:
     - If using **Prometheus**, create custom metrics or use exporters to gather scaling-related data for the services.
     - Example PromQL queries:
       - `sum(rate(container_cpu_usage_seconds_total[5m])) by (instance)` for tracking container CPU usage and scaling needs.

   - **Datadog or New Relic**:
     - Use Datadog, New Relic, or similar monitoring platforms to collect scaling metrics and set up custom dashboards. These platforms may already have predefined integrations for AWS, GCP, or Azure services to pull scaling data.

### 3. **Add Metrics to the Operational Dashboard**
   - **Dashboard Layout**:
     - Create a dedicated section on the operational dashboard that displays scaling metrics for each service (e.g., EC2, ECS, Lambda, etc.). Each service should have its metrics grouped together, with clear visuals for current usage and scaling limits.
     - Example layout:
       - **EC2 Autoscaling Group**: Display a graph of instance count over time and a gauge showing current usage vs. maximum capacity.
       - **Lambda Concurrency**: Show current concurrent executions, the maximum allowed, and any throttling.

   - **Visualization Types**:
     - Use visualizations such as:
       - **Gauges**: To show the current usage percentage relative to the scaling limit.
       - **Line Graphs**: To show historical trends in resource usage over time.
       - **Heatmaps**: To indicate periods of high usage or potential scaling bottlenecks.

   - **Threshold Indicators**:
     - Set visual thresholds (e.g., green, yellow, red) on the dashboard to indicate how close a resource is to reaching its limit. For example:
       - Green: Below 70% usage.
       - Yellow: 70-90% usage.
       - Red: Above 90% usage (critical).

### 4. **Configure Alerts for Approaching Scaling Limits**
   - **CloudWatch Alarms**:
     - Set up CloudWatch Alarms for resources approaching their scaling limits. Configure alarms to trigger when the usage reaches a certain percentage of the maximum capacity (e.g., 80% or higher).
     - Example:
       - Set an alarm for EC2 autoscaling groups when the instance count reaches 80% of the maximum allowed capacity.

   - **Alerts in Monitoring Tools**:
     - Configure alerts in monitoring tools like Datadog, New Relic, or Prometheus to notify teams when scaling limits are close to being hit. Send alerts to Slack, email, or incident management systems like PagerDuty.

   - **Scaling Threshold Notifications**:
     - Set notifications for when scaling limits are exceeded or when autoscaling triggers new resources to be provisioned. This ensures that teams are aware of scaling events in real-time.

### 5. **Test the Dashboard and Alerts**
   - **Simulate High Load**:
     - Simulate a high-load scenario to test the scaling metrics and ensure that the dashboard updates in real-time as resources scale. This also helps verify that alerts are triggered when approaching limits.

   - **Test Alerts and Notifications**:
     - Verify that the alerts are correctly configured and sent to the appropriate channels when scaling thresholds are breached. Ensure that the notification settings and alert escalations are working as expected.

   - **Monitor Long-Term Trends**:
     - Ensure the dashboard provides useful insights over time, showing trends in how services scale and highlighting potential bottlenecks for future optimization.

### 6. **Documentation**
   - **Dashboard Documentation**:
     - Provide documentation on how the scaling metrics are gathered and displayed. Include details on how to interpret the dashboard and respond to alerts.

   - **Scaling Limits and Thresholds**:
     - Document the scaling limits for each service (e.g., EC2 instance max, Lambda concurrency limits, API Gateway rate limits) and explain how the limits are set and monitored.

### Testing
- **Dashboard Validation**:
   - Validate the accuracy of the scaling metrics on the dashboard by comparing real-time data with known service usage.

- **Alert Testing**:
   - Test alerts by artificially triggering scaling events (e.g., increasing load or usage) to ensure that alarms and notifications are working correctly.

- **Load Testing**:
   - Perform load testing to confirm that the system scales correctly and that the dashboard provides accurate feedback on scaling behavior during peak load times.

### External Dependencies
- AWS CloudWatch, Prometheus, Datadog, or New Relic for gathering and displaying scaling metrics.
- Autoscaling services (e.g., AWS EC2 Autoscaling, ECS, Lambda, API Gateway) to collect relevant scaling limits and usage data.

## Acceptance Criteria
- Should display scaling metrics (e.g., current usage vs. limits) for EC2, ECS, Lambda, and other services on the operational dashboard.
- Should provide real-time visibility into scaling limits and usage trends.
- Should configure alerts when usage approaches or exceeds a defined percentage of the scaling limits.
- Should test and verify the dashboard’s accuracy under high load and confirm that alerts are triggered when thresholds are breached.

### Gherkin
```gherkin
Given an operational dashboard with scaling metrics
When the system load increases
Then the dashboard should display real-time scaling metrics
And show the current usage relative to the scaling limits.
```
```gherkin
Given the scaling limits

 are approaching
When the usage exceeds 80% of the maximum capacity
Then an alert should be triggered
And the team should be notified via the configured channels.
```

## API
N/A

## External Links
- [AWS Auto Scaling Documentation](https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html)
- [AWS Lambda Concurrency Limits](https://docs.aws.amazon.com/lambda/latest/dg/invocation-scaling.html)
- [Prometheus Monitoring Guide](https://prometheus.io/docs/introduction/overview/)
