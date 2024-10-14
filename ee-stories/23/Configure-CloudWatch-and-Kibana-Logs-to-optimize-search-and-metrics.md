
# Configure CloudWatch and Kibana Logs to optimize search and metrics
### Summary
**As a** DevOps Engineer, **I want** to configure CloudWatch and Kibana logs to optimize searchability and metrics, **So That** the team can efficiently query logs, extract valuable insights, and monitor key metrics to improve system observability and performance.

This story focuses on optimizing the configuration of  CloudWatch Logs and the Kibana instance (backed by  OpenSearch) to enhance search performance, reduce log retrieval times, and provide meaningful metrics for monitoring application and system health. By configuring proper log indices, retention policies, and dashboards, we can streamline log search and visualization, improving both operational monitoring and debugging processes.

### Vision
By optimizing the searchability and metrics in CloudWatch and Kibana, we ensure that logs are efficiently indexed, accessible for quick queries, and structured in a way that provides actionable metrics. This will reduce troubleshooting time, provide better visibility into system performance, and enable real-time monitoring of key metrics through Kibana dashboards.

### Background
CloudWatch Logs are designed to aggregate logs from AWS services, and Kibana provides advanced search, filtering, and visualization features for log analysis. Without proper configuration, log search can become slow and cumbersome, and important metrics may be difficult to extract. Optimizing the structure of logs, retention policies, and indices will ensure that the team can efficiently search for logs, analyze patterns, and extract key metrics for monitoring.

### Purpose
The purpose of this story is to optimize the configuration of CloudWatch and Kibana logs to enhance search performance, ensure efficient storage, and make key metrics easily accessible. This includes configuring log structures, indices, retention policies, and Kibana dashboards.

## Details
### 1. Optimize CloudWatch Logs
 CloudWatch Logs serves as the primary log aggregation platform for services running on AWS. By optimizing its configuration, we ensure that logs are efficiently stored, searchable, and integrated with other tools such as Kibana.

#### 1.1 Set Up Log Group Structures
Ensure that logs are categorized into appropriate **log groups** and **log streams** based on service, environment, and function. This enables more granular searches and better management of log data.

##### Best Practices for Log Groups:
- **Group by Service/Environment**: Create separate log groups for each service (e.g., `/aws/lambda/my-service`, `/ecs/my-app`, `/rds/instance-logs`) and environment (e.g., `prod`, `dev`, `test`).
- **Stream by Instance/Container**: Within each log group, create log streams that correspond to individual instances, containers, or application processes to provide finer granularity.

Example log group structure:
```
/aws/lambda/my-service-prod
  - LogStream: lambda-function-instance-1
  - LogStream: lambda-function-instance-2

/ecs/my-app-dev
  - LogStream: ecs-task-id-1
  - LogStream: ecs-task-id-2
```

#### 1.2 Define Log Retention Policies
Set appropriate **retention periods** for CloudWatch log groups based on business and compliance requirements. This helps manage storage costs and ensures that logs are retained only as long as needed for analysis and compliance purposes.

##### Example Retention Policies:
- **Application Logs**: Retain for 30-90 days based on the need for debugging and monitoring historical issues.
- **Security Logs**: Retain for 1 year to meet compliance and auditing needs.
- **Diagnostic Logs**: Retain for 7-14 days, as these are typically used for short-term diagnostics.

Configure retention policy for a log group using AWS CLI:
```bash
aws logs put-retention-policy   --log-group-name /aws/lambda/my-service-prod   --retention-in-days 30
```

#### 1.3 Enable Metric Filters in CloudWatch Logs
Use **metric filters** in CloudWatch Logs to extract key metrics directly from log data. This reduces the need to constantly search logs and allows for real-time monitoring of specific patterns or events (e.g., error rates, slow response times).

##### Steps to Create a Metric Filter:
1. Identify patterns in logs (e.g., HTTP 500 errors, request latencies).
2. Create a CloudWatch Logs **Metric Filter** that triggers a CloudWatch metric based on the log pattern.

Example to create a metric filter for HTTP 500 errors:
```bash
aws logs put-metric-filter   --log-group-name '/aws/lambda/my-service-prod'   --filter-name '500ErrorCount'   --filter-pattern '500'   --metric-transformations     metricName='500ErrorCount',metricNamespace='MyAppMetrics',metricValue='1'
```

This metric filter will increment a `500ErrorCount` metric every time an HTTP 500 error is logged.

#### 1.4 Set Alarms Based on Key Metrics
After defining metric filters, create **CloudWatch Alarms** based on key metrics (e.g., error rates, request timeouts) to alert the team when certain thresholds are exceeded.

Example to create an alarm for HTTP 500 errors:
```bash
aws cloudwatch put-metric-alarm   --alarm-name 'High500ErrorRate'   --metric-name '500ErrorCount'   --namespace 'MyAppMetrics'   --statistic 'Sum'   --period 300   --threshold 10   --comparison-operator 'GreaterThanThreshold'   --evaluation-periods 1   --alarm-actions arn:aws:sns:us-east-1:123456789012:MySNSTopic
```

### 2. Optimize Kibana for Log Search and Metrics
Kibana, running on ** OpenSearch (Elasticsearch)**, is used for querying, visualizing, and analyzing log data. By optimizing its indices and dashboard configuration, we can improve search speed, extract key metrics, and enhance data visualization.

#### 2.1 Set Up Indices in OpenSearch (Elasticsearch)
Ensure that logs are indexed efficiently in OpenSearch to optimize search performance. Index logs based on time, service, and environment to make querying easier and faster.

##### Example Index Structure:
- **Index by Date**: Create time-based indices (e.g., daily or weekly indices) to manage log volumes effectively.
  - `logs-myapp-prod-2024.09.19`
  - `logs-myapp-dev-2024.09.19`

##### Use Index Aliases:
Create aliases for common queries, such as aggregating indices for different environments or services.
```bash
PUT /_aliases
{
  'actions': [
    { 'add': { 'index': 'logs-myapp-prod-*', 'alias': 'prod-logs' } },
    { 'add': { 'index': 'logs-myapp-dev-*', 'alias': 'dev-logs' } }
  ]
}
```

#### 2.2 Optimize Mappings in OpenSearch
Set up **field mappings** in OpenSearch to ensure that important log fields (e.g., status codes, timestamps, error messages) are properly indexed for fast querying and aggregation.

##### Example Field Mapping for HTTP Logs:
```json
PUT /logs-myapp-prod-2024.09.19/_mapping
{
  'properties': {
    'status_code': { 'type': 'integer' },
    'timestamp': { 'type': 'date' },
    'response_time': { 'type': 'float' }
  }
}
```

#### 2.3 Configure Log Retention Policies in OpenSearch
Set up **index lifecycle management (ILM)** policies to automatically manage log retention, archiving, and deletion in OpenSearch. This will help manage storage costs and ensure that old logs are purged when no longer needed.

##### Example ILM Policy:
```json
PUT _ilm/policy/logs_policy
{
  'policy': {
    'phases': {
      'hot': {
        'actions': {
          'rollover': {
            'max_size': '50gb',
            'max_age': '7d'
          }
        }
      },
      'delete': {
        'min_age': '30d',
        'actions': {
          'delete': {}
        }
      }
    }
  }
}
```
This policy rolls over logs after 7 days or 50 GB and deletes logs older than 30 days.

#### 2.4 Create Kibana Dashboards for Key Metrics
Set up **Kibana Dashboards** to visualize key metrics extracted from the logs. Dashboards should display real-time metrics and historical trends for monitoring system health, performance, and errors.

##### Example Metrics to Visualize:
- **Error Rates**: HTTP 500 errors, application exceptions, Lambda function failures.
- **Response Times**: Average and 95th percentile response times for key services.
- **Throughput**: Number of requests processed by services over time.
- **Infrastructure Metrics**: CPU, memory, and disk usage.

#### 2.5 Use Saved Searches and Alerts
Leverage **Saved Searches** in Kibana to quickly access frequently used queries (e.g., logs from the past 24 hours, error logs). Use **Kibana Alerts** to notify the team when important conditions are met (e.g., spike in error rates).

##### Example Saved Search for HTTP 500 Errors:
```json
{
  'query': {
    'bool': {
      'must': [
        { 'match': { 'status_code': 500 } },
        { 'range': { '@timestamp': { 'gte': 'now-24h' } } }
      ]
    }
  }
}
```

### 3. Monitor and Tune Log Ingestion
Ensure that both CloudWatch and Kibana are properly handling the log ingestion volume. Monitor the size of logs being ingested and adjust the configuration if necessary to prevent performance bottlenecks.

#### 3.1 Monitor CloudWatch Ingestion Metrics:
Monitor the **IncomingLogEvents** and **BytesUploadedToCloudWatch** metrics in CloudWatch to track the volume of logs being ingested.

#### 3.2 Monitor OpenSearch Ingestion Metrics:
Use **OpenSearch Dashboards** to monitor log ingestion rates and the health of the OpenSearch cluster. Ensure that the cluster can handle the incoming log volume without performance degradation.

### Testing
- **Search Performance Test**: Verify that logs can be queried in CloudWatch and Kibana within acceptable time frames.
- **Retention Test**: Ensure that logs are retained for the correct duration and deleted after their retention period expires.
- **Metric Extraction Test**: Ensure that key metrics (e.g., error rates, response times) are extracted and displayed in Kibana dashboards.
- **Alert Test**: Test that alerts in CloudWatch and Kibana are triggered when key thresholds (e.g., error rates) are breached.

### External Dependencies
- ** CloudWatch**: Used for log aggregation and real-time monitoring.
- ** OpenSearch (Elasticsearch)**: Backend for log search and visualization.
- **Kibana**: Interface for querying and visualizing logs and metrics.

## Acceptance Criteria
- Should have optimized log group and log stream structures in CloudWatch for better searchability.
- Should have set up retention policies for CloudWatch logs.
- Should have created metric filters in CloudWatch Logs for key metrics.
- Should have optimized indices and field mappings in OpenSearch for fast querying.
- Should have created dashboards in Kibana to display key metrics such as error rates, response times, and throughput.
- Should have set up monitoring and alerting for key log patterns and metrics.

### Gherkin
#### Scenario: Optimizing Log Search in CloudWatch and Kibana
Given logs are generated by services,
When I configure log groups and indices,
Then I should be able to search logs in CloudWatch and Kibana efficiently.

#### Scenario: Extracting Metrics from Logs
Given key metrics are identified in the logs,
When I configure metric filters in CloudWatch and dashboards in Kibana,
Then I should be able to monitor metrics like error rates and response times.

#### Scenario: Monitoring Log Retention
Given retention policies are defined,
When logs reach the end of their retention period,
Then they should be automatically deleted or archived.

## External Links
- [CloudWatch Logs Documentation](https://docs.aws.amazon.com/
- [OpenSearch (Elasticsearch) Documentation](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/what-is.html)
- [Kibana Documentation](https://www.elastic.co/guide/en/kibana/current/index.html)
