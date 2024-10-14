
# Create a CloudWatch dashboard view with dependency failure/success metrics
### Summary
**As a** DevOps Engineer, **I want** to create a CloudWatch dashboard view with dependency failure/success metrics, **So That** we can monitor the health of critical dependencies in real-time, tracking both successful operations and failures to quickly detect and respond to issues.

This story focuses on creating a CloudWatch dashboard that visualizes the success and failure metrics of various dependencies, such as external APIs, internal services, databases, and other third-party integrations. By tracking these metrics, we can ensure visibility into how dependent services are functioning and proactively respond to failures before they escalate into larger incidents.

### Vision
By implementing a CloudWatch dashboard with dependency metrics, we ensure real-time visibility into the operational health of critical dependencies, which allows the team to detect failures quickly, minimize downtime, and improve the reliability of the system.

### Background
Dependencies in a system, such as APIs, databases, and other services, play a crucial role in the functioning of applications. Tracking both successful interactions and failures with these dependencies allows us to ensure that all services are performing as expected. AWS CloudWatch provides metrics tracking and visualization, which can be used to monitor dependency health and alert the team in case of failures.

---

### Steps to Create a CloudWatch Dashboard for Dependency Failure/Success Metrics

#### 1. **Identify Key Dependencies and Metrics**

Before creating the dashboard, you need to identify the critical dependencies whose metrics you want to track. Some common dependencies and their relevant metrics might include:

- **API Gateway**: Success and failure metrics for API calls (`5xxError`, `4xxError`, `IntegrationLatency`, `Count`).
- **Lambda**: Invocation success and failure (`Invocations`, `Errors`, `Throttles`).
- **SQS**: Number of successful and failed message deliveries (`NumberOfMessagesSent`, `NumberOfMessagesReceived`, `NumberOfMessagesDeleted`, `ApproximateNumberOfMessagesVisible`).
- **DynamoDB**: Request success and throttling metrics (`SuccessfulRequestLatency`, `ThrottledRequests`).
- **External API Calls**: If you're using custom metrics for external APIs, you'll want to track request successes and failures.

Each of these metrics provides insight into how dependent services are performing.

---

#### 2. **Create a CloudWatch Dashboard**

You can create a CloudWatch dashboard either via the AWS Management Console or by using the AWS CLI. We’ll use the AWS CLI to create and manage the dashboard.

##### Step 1: Create the Dashboard

First, create the dashboard using the `put-dashboard` command. The dashboard will include widgets that visualize metrics for different dependencies.

```bash
aws cloudwatch put-dashboard   --dashboard-name 'DependencyMetricsDashboard'   --dashboard-body '{
    'widgets': []
  }'
```

This creates an empty dashboard named **DependencyMetricsDashboard**.

---

#### 3. **Add Widgets for Each Dependency**

Each dependency will have specific metrics for tracking failures and successes. You can add individual widgets to the dashboard that show these metrics in real-time.

##### Step 1: Add an API Gateway Success/Failure Widget

Add a widget to track **API Gateway** success and failure rates, including `5xx` and `4xx` errors, along with the total request count (`Count`).

```bash
aws cloudwatch put-dashboard   --dashboard-name 'DependencyMetricsDashboard'   --dashboard-body '{
    'widgets': [
      {
        'type': 'metric',
        'x': 0,
        'y': 0,
        'width': 12,
        'height': 6,
        'properties': {
          'metrics': [
            [ 'AWS/ApiGateway', '5XXError', 'ApiName', '<api-name>', { 'stat': 'Sum' } ],
            [ '.', '4XXError', '.', '.', { 'stat': 'Sum' } ],
            [ '.', 'Count', '.', '.', { 'stat': 'Sum' } ]
          ],
          'period': 300,
          'stat': 'Sum',
          'region': 'us-east-1',
          'title': 'API Gateway Success and Failures',
          'view': 'timeSeries',
          'stacked': false,
          'yAxis': {
            'left': {
              'label': 'Requests'
            }
          }
        }
      }
    ]
  }'
```

This widget tracks the **5XX**, **4XX** error rates, and total request count for the API Gateway in real-time.

##### Step 2: Add a Lambda Success/Failure Widget

Add a widget to track **Lambda** function invocations, errors, and throttles. This will help monitor if Lambda functions are running successfully or encountering issues.

```bash
aws cloudwatch put-dashboard   --dashboard-name 'DependencyMetricsDashboard'   --dashboard-body '{
    'widgets': [
      {
        'type': 'metric',
        'x': 0,
        'y': 6,
        'width': 12,
        'height': 6,
        'properties': {
          'metrics': [
            [ 'AWS/Lambda', 'Invocations', 'FunctionName', '<lambda-function-name>', { 'stat': 'Sum' } ],
            [ '.', 'Errors', '.', '.', { 'stat': 'Sum' } ],
            [ '.', 'Throttles', '.', '.', { 'stat': 'Sum' } ]
          ],
          'period': 300,
          'stat': 'Sum',
          'region': 'us-east-1',
          'title': 'Lambda Invocation Success and Failures',
          'view': 'timeSeries',
          'stacked': false,
          'yAxis': {
            'left': {
              'label': 'Count'
            }
          }
        }
      }
    ]
  }'
```

This widget tracks the total number of Lambda invocations, errors, and throttling events for a specified function.

##### Step 3: Add SQS Message Success/Failure Widget

You can track SQS success and failure by adding widgets that monitor the number of messages sent and received, as well as message visibility and errors.

```bash
aws cloudwatch put-dashboard   --dashboard-name 'DependencyMetricsDashboard'   --dashboard-body '{
    'widgets': [
      {
        'type': 'metric',
        'x': 0,
        'y': 12,
        'width': 12,
        'height': 6,
        'properties': {
          'metrics': [
            [ 'AWS/SQS', 'NumberOfMessagesSent', 'QueueName', '<queue-name>', { 'stat': 'Sum' } ],
            [ '.', 'NumberOfMessagesReceived', '.', '.', { 'stat': 'Sum' } ],
            [ '.', 'ApproximateNumberOfMessagesVisible', '.', '.', { 'stat': 'Sum' } ]
          ],
          'period': 300,
          'stat': 'Sum',
          'region': 'us-east-1',
          'title': 'SQS Message Flow',
          'view': 'timeSeries',
          'stacked': false,
          'yAxis': {
            'left': {
              'label': 'Messages'
            }
          }
        }
      }
    ]
  }'
```

This widget tracks the number of messages sent and received by the SQS queue and also monitors visible messages in the queue.

##### Step 4: Add DynamoDB Success/Failure Widget

You can add a widget to monitor **DynamoDB** requests and throttled requests to ensure the database is functioning correctly and isn't being throttled due to excessive requests.

```bash
aws cloudwatch put-dashboard   --dashboard-name 'DependencyMetricsDashboard'   --dashboard-body '{
    'widgets': [
      {
        'type': 'metric',
        'x': 0,
        'y': 18,
        'width': 12,
        'height': 6,
        'properties': {
          'metrics': [
            [ 'AWS/DynamoDB', 'SuccessfulRequestLatency', 'TableName', '<table-name>', { 'stat': 'Average' } ],
            [ '.', 'ThrottledRequests', '.', '.', { 'stat': 'Sum' } ]
          ],
          'period': 300,
          'stat': 'Average',
          'region': 'us-east-1',
          'title': 'DynamoDB Request Success and Throttles',
          'view': 'timeSeries',
          'stacked': false,
          'yAxis': {
            'left': {
              'label': 'Requests'
            }
          }
        }
      }
    ]
  }'
```

This widget tracks the successful request latency and throttled requests for a DynamoDB table.

---

#### 4. **Custom Metrics for External Dependencies**

If you're tracking custom metrics for external dependencies (such as an external API), you need to create custom CloudWatch metrics first.

##### Step 1: Publish Custom Metrics

In your application code (Node.js, Python, Java, etc.), publish custom metrics to CloudWatch that track the success and failure of external API calls.

Example using AWS SDK (Node.js):

```javascript
const AWS = require('aws-sdk');
const cloudwatch = new AWS.CloudWatch();

function publishCustomMetric(success) {
  const params = {
    MetricData: [
      {
        MetricName: success ? 'ExternalApiSuccess' : 'ExternalApiFailure',
        Dimensions: [
          {
            Name: 'ApiName',
            Value: 'ExternalAPI'
          }
        ],
        Unit: 'Count',
        Value: 1
      }
    ],
    Namespace: 'Custom/ExternalAPI'
  };

  cloudwatch.putMetricData(params, function(err, data) {
    if (err) console.log(err, err.stack);
    else console.log(data);
  });
}
```

Once these metrics are published, you can add them to your CloudWatch dashboard.

##### Step 2: Add Custom Metric Widget to Dashboard

```bash
aws cloudwatch put-dashboard   --dashboard-name 'DependencyMetricsDashboard'   --dashboard-body '{
    'widgets': [
      {
        'type': 'metric',
        'x': 0,
        'y': 24,
        'width': 12,
        'height': 6,
        'properties': {
          'metrics': [
            [ 'Custom/ExternalAPI', 'ExternalApiSuccess', 'ApiName', 'ExternalAPI', { 'stat': 'Sum' } ],
            [ '.', 'ExternalApiFailure', '.', '.', { 'stat': 'Sum' } ]
          ],
          'period': 300,
          'stat': 'Sum',
          'region': 'us-east-1',
          'title': 'External API Success and Failures',
          'view': 'timeSeries',
          'stacked': false,
          'yAxis': {
            'left': {
              'label': 'Requests'
            }
          }
        }
      }
    ]
  }'
```

This widget tracks the success and failure of calls made to an external API.

---

### 5. **Viewing the Dashboard**

Once the widgets are added, the **DependencyMetricsDashboard** will be available in the CloudWatch console. You can view the real-time metrics for each dependency and monitor the health of the system in one place.

---

### 6. **Set Up Alarms for Dependency Failures**

To ensure proactive monitoring, configure CloudWatch alarms for critical metrics in the dashboard (e.g., API Gateway 5XX errors, Lambda errors). These alarms will alert the on-call team when thresholds are exceeded.

Example of creating an alarm for Lambda errors:

```bash
aws cloudwatch put-metric-alarm --alarm-name 'LambdaErrorAlarm'   --metric-name Errors --namespace AWS/Lambda   --statistic Sum --period 300 --threshold 1   --comparison-operator GreaterThanThreshold   --evaluation-periods 1 --alarm-actions <SNS-Topic-ARN>
```

---

### Acceptance Criteria
- Should create a CloudWatch dashboard named **DependencyMetricsDashboard**.
- Should track key metrics for dependencies like API Gateway, Lambda, SQS, DynamoDB, and external APIs.
- Should visualize both success and failure metrics for each dependency.
- Should include custom metrics for external dependencies, if applicable.
- Should ensure that the dashboard is accessible and up-to-date, providing real-time insight into the health of all dependencies.
