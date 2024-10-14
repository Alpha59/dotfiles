
# Add all existing services to an AWS CloudWatch dashboard with key metrics to monitor services
### Summary
**As a** Site Reliability Engineer, **I want** to add all existing services to an AWS CloudWatch dashboard with key metrics to monitor services, **So That** we can have real-time visibility into the health and performance of all services and quickly identify and respond to potential issues.

This story focuses on creating a centralized AWS CloudWatch dashboard that displays key metrics for all services currently running in the AWS environment. By monitoring these metrics, the team can track the health, performance, and availability of critical services and respond quickly to any issues or anomalies.

### Vision
Adding all services to an AWS CloudWatch dashboard with key metrics ensures that the team has a single view of the system's overall health. This real-time visibility enables the team to quickly detect performance bottlenecks, identify service outages, and monitor other critical metrics that impact system reliability and customer experience.

### Background
Currently, services may be monitored separately, making it difficult to get a complete view of the system's health. Without a centralized dashboard, the team may miss important performance issues or have difficulty correlating metrics across different services. A CloudWatch dashboard provides a single view of all services and the key metrics necessary for monitoring service health.

### Purpose
The purpose of this story is to create an AWS CloudWatch dashboard that includes all existing services, along with key metrics for monitoring the performance and availability of each service. This initiative aims to improve the team's ability to proactively monitor the system and detect issues before they impact customers.

## Details
1. **Identify Existing Services**:
    - Work with the development and operations teams to identify all existing services that need to be monitored on the CloudWatch dashboard. These may include:
      - **EC2 Instances**: Virtual machines running applications or backend services.
      - **Lambda Functions**: Serverless functions handling specific tasks.
      - **ECS (Elastic Container Service) Tasks/Services**: Containerized services deployed on AWS ECS.
      - **API Gateway**: APIs that handle client requests and route them to back-end services.
      - **RDS (Relational Database Service)**: Managed databases hosting application data.
      - **S3**: Storage service used for hosting static files or logs.
      - **Other AWS Services**: Any additional AWS services critical to the system's performance.

2. **Define Key Metrics for Each Service**:
    - For each identified service, define the key metrics to monitor in CloudWatch. These metrics should provide insights into the health, performance, and availability of each service. Examples include:
      - **EC2 Instances**:
        - CPU Utilization
        - Memory Usage (if custom metrics are enabled)
        - Disk I/O
        - Network In/Out
      - **Lambda Functions**:
        - Invocation Count
        - Duration (execution time)
        - Errors and Throttles
      - **ECS Tasks/Services**:
        - CPU and Memory Utilization
        - Task Count
        - Service Health
      - **API Gateway**:
        - Request Count
        - Latency (average response time)
        - 4xx and 5xx Error Rates
      - **RDS Databases**:
        - CPU Utilization
        - Read and Write IOPS
        - Free Storage Space
      - **S3 Buckets**:
        - Number of Get, Put, and Delete requests
        - Latency for request operations
    - Ensure that the metrics selected provide comprehensive coverage of the service’s health and performance.

3. **Create a CloudWatch Dashboard**:
    - Create a new CloudWatch dashboard where all services will be displayed. This can be done via the AWS Management Console or AWS CLI.
    - Name the dashboard appropriately (e.g., `System-Health-Monitor`) so that it’s easy to identify by team members.

4. **Add Service-Specific Widgets to the Dashboard**:
    - For each service, create widgets that display the key metrics defined earlier. Each widget should display a specific metric and include relevant details such as:
      - Time period (e.g., Last 1 hour, Last 24 hours)
      - Aggregation method (e.g., Average, Sum, Maximum)
      - Thresholds or limits that indicate potential issues (e.g., CPU utilization above 80%).
    - Use the following CloudWatch widgets to visualize metrics:
      - **Time Series Widgets**: To show trends for metrics like CPU Utilization, Latency, or Error Rates over time.
      - **Number Widgets**: To display current values for key metrics, such as the number of active ECS tasks or the number of Lambda errors.
      - **Gauge Widgets**: To display metrics like memory utilization or database free storage as a percentage.

5. **Set Alarms for Critical Metrics**:
    - For each key metric, define thresholds that represent potential issues (e.g., CPU Utilization above 80%, Lambda Errors > 1% of invocations).
    - Configure CloudWatch Alarms for these metrics and associate them with the dashboard. When a metric exceeds its defined threshold, the alarm should trigger notifications to the operations team (e.g., via email, Slack, or PagerDuty).
    - Example alarms:
      - **CPU Utilization Alarm**: Trigger if CPU utilization exceeds 80% for more than 5 minutes.
      - **Lambda Errors Alarm**: Trigger if more than 1% of invocations result in errors over a 15-minute period.
      - **API Gateway Latency Alarm**: Trigger if the average latency exceeds 200ms for more than 10 minutes.

6. **Test the CloudWatch Dashboard and Alarms**:
    - Validate that all services are included on the dashboard and that the key metrics are displayed correctly.
    - Test the alarms by simulating high CPU usage, errors, or increased latency to verify that the alarms are triggered appropriately and notifications are sent to the relevant team members.
    - Ensure that the time ranges and aggregations displayed on the dashboard provide accurate and actionable data.

7. **Customize the Dashboard for Usability**:
    - Organize the widgets logically to make the dashboard easy to read and navigate. For example:
      - Group widgets for similar services (e.g., all EC2 instances in one section, all Lambda functions in another).
      - Arrange high-priority metrics (e.g., error rates, CPU utilization) at the top of the dashboard for easy visibility.
    - Ensure that team members can easily navigate the dashboard and understand how to interpret the metrics.

8. **Provide Documentation and Training**:
    - Document the setup of the CloudWatch dashboard, including which services are monitored, which metrics are tracked, and the meaning of each widget.
    - Provide guidelines on how to use the dashboard, interpret the metrics, and respond to alarms.
    - Conduct a walkthrough or training session to ensure that the operations and development teams are familiar with the dashboard and can use it effectively during incident response.

### Testing
- Test the functionality of the CloudWatch dashboard by simulating various service conditions (e.g., high traffic, service outages) and verifying that the metrics and alarms respond accurately.
- Ensure that alarms are triggered when the defined thresholds are exceeded and that notifications are sent to the correct team members.
- Validate that the dashboard updates in real time and provides an accurate view of service performance and availability.
- Test the usability of the dashboard by gathering feedback from team members to ensure that the layout and organization are intuitive and useful.

### External Dependencies
- Integration with AWS services such as EC2, Lambda, ECS, API Gateway, RDS, and S3 to collect metrics via CloudWatch.
- Collaboration with the development and operations teams to define critical metrics for each service and ensure the dashboard meets operational needs.
- Access to alerting tools (e.g., PagerDuty, Slack) for configuring alarms and notifications.

## Acceptance Criteria
- Should have added all existing services to a centralized AWS CloudWatch dashboard.
- Should have defined and displayed key metrics for each service, providing real-time insights into service health, performance, and availability.
- Should have configured alarms for critical metrics, ensuring that the team is notified when thresholds are exceeded.
- Should have tested the dashboard to ensure that it accurately displays metrics and that alarms trigger appropriately.
- Should have documented the setup and usage of the dashboard and provided training to the team on how to interpret metrics and respond to alarms.

### Gherkin
#### Scenario: Adding Services and Key Metrics to CloudWatch Dashboard
Given an AWS environment with existing services,
When the CloudWatch dashboard is set up,
Then all services should be added, and key metrics should be displayed for each service.

#### Scenario: Setting Up Alarms for Critical Metrics
Given that key metrics are defined for each service,
When a critical metric exceeds its threshold (e.g., CPU utilization above 80%),
Then an alarm should be triggered, and the operations team should be notified.

#### Scenario: Testing and Validating CloudWatch Dashboard
Given the completion of the CloudWatch dashboard setup,
When service conditions are simulated (e.g., high traffic, service failure),
Then the dashboard should display accurate metrics, and alarms should trigger appropriately.

## API
N/A

## External Links
- [AWS CloudWatch Dashboards Documentation](https://docs.aws.amazon.com/
- [CloudWatch Alarms Documentation](https://docs.aws.amazon.com/

