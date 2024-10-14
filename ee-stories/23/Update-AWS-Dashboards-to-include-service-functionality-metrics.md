
# Update AWS Dashboards to include service functionality metrics
### Summary
**As a** DevOps Engineer, **I want** to update AWS dashboards to include service functionality metrics, **So That** I can monitor key performance indicators (KPIs) and metrics related to service health and functionality in real-time, ensuring that all critical aspects of the system are visible and actionable for the team.

This story focuses on enhancing existing AWS CloudWatch dashboards by adding service-specific functionality metrics, such as API latency, error rates, throughput, and custom application metrics. These updates will provide better visibility into the operational status of services and allow teams to quickly identify and respond to any performance or functionality issues.

### Vision
By updating the AWS dashboards with key service functionality metrics, we ensure that the team has real-time insights into the health and performance of services. This will improve incident response, reduce downtime, and provide actionable data to optimize service performance and customer experience.

### Background
Dashboards in AWS CloudWatch provide real-time monitoring of application performance and resource usage. Adding service-specific metrics, such as API request latency, error rates, and service throughput, will help the team gain better insights into how the services are functioning, detect potential issues early, and ensure the system meets performance targets.

### Purpose
The purpose of this story is to enhance the visibility and monitoring capabilities of the AWS dashboards by incorporating important service functionality metrics, ensuring that the team can proactively monitor service performance and health.

## Details
### 1. Identify Key Service Functionality Metrics
Identify the key metrics that should be added to the dashboards. These may include:
  - **Latency**: Measure the time it takes for services to respond to requests.
  - **Error Rates**: Monitor the number of errors returned by services, including 4xx and 5xx status codes.
  - **Throughput**: Track the number of successful API requests processed by the service.
  - **Service Uptime**: Measure the availability of services.
  - **Custom Application Metrics**: Any business-specific metrics related to service functionality (e.g., number of successful transactions, queue depth).

#### Example Metrics for a REST API:
- **API Gateway Latency**: `AWS/ApiGateway` metric for `Latency`.
- **Lambda Duration**: `AWS/Lambda` metric for `Duration` (if the service uses AWS Lambda).
- **DynamoDB Throttled Requests**: `AWS/DynamoDB` metric for `ThrottledRequests`.
- **Error Rates**: `5xxError` and `4xxError` metrics for both API Gateway and Lambda.

### 2. Enable Custom Metrics (if required)
For certain functionality metrics that are specific to the application (e.g., business-specific KPIs like user signups or transactions), create custom CloudWatch metrics using the AWS SDK or instrumentation libraries.

#### Example of Publishing a Custom Metric in AWS Lambda (Python):
```python
import boto3
import time

cloudwatch = boto3.client('cloudwatch')

def lambda_handler(event, context):
    # Business logic (e.g., processing an order)

    # Publish a custom metric for successful transactions
    cloudwatch.put_metric_data(
        Namespace='MyApp/Metrics',
        MetricData=[
            {
                'MetricName': 'SuccessfulTransactions',
                'Timestamp': time.time(),
                'Value': 1,
                'Unit': 'Count'
            },
        ]
    )

    return {
        'statusCode': 200,
        'body': 'Success'
    }
```

### 3. Add Metrics to CloudWatch Dashboards
Once the relevant metrics have been identified, update the AWS CloudWatch dashboard to include them. This involves adding new widgets that display the relevant metrics using charts, numbers, or alarms.

#### Example of Adding Metrics via AWS Console:
1. Navigate to the **CloudWatch Console**.
2. Select **Dashboards** from the navigation pane and choose the dashboard to update.
3. Click **Add widget** and choose the appropriate widget type (e.g., Line, Number, Gauge).
4. Select the metric namespace (e.g., `AWS/ApiGateway`, `AWS/Lambda`, or custom namespace like `MyApp/Metrics`).
5. Configure the metric (e.g., `Latency`, `Errors`, `Duration`) and set the appropriate time range.
6. Add any necessary alarms or thresholds for critical metrics (e.g., alert
