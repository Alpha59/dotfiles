
# Ensure all logs are pushed to CloudWatch, and the teams central Kibana instance for all services
### Summary
**As a** DevOps Engineer, **I want** to ensure that all logs from our services are pushed to  CloudWatch and the central Kibana instance, **So That** we can centralize log collection and analysis, allowing the team to monitor application health, troubleshoot issues, and generate actionable insights from logs in a unified platform.

This story focuses on configuring all services to push logs to both  CloudWatch and the team’s central Kibana instance, ensuring that logs from all services are centralized, searchable, and accessible for real-time monitoring, troubleshooting, and auditing.

### Vision
By pushing all logs to CloudWatch and Kibana, we ensure that logs from different services are centralized, providing the team with a single platform for querying, monitoring, and analyzing logs. This centralization improves observability, reduces the time to troubleshoot issues, and enhances the ability to monitor application performance and security.

### Background
 CloudWatch provides a native solution for aggregating logs from AWS services, while Kibana is often used for centralized log search and visualization across multiple data sources. By ensuring that logs are pushed to both platforms, the team can take advantage of CloudWatch’s integration with AWS services and Kibana’s advanced log search and visualization capabilities.

### Purpose
The purpose of this story is to configure logging for all services so that logs are pushed to both  CloudWatch and the team’s central Kibana instance, ensuring that logs are accessible in both platforms for monitoring, analysis, and troubleshooting.

## Details
### 1. Ensure Logs Are Pushed to CloudWatch
All AWS services (e.g., Lambda, EC2, ECS, EKS) should be configured to push logs to  CloudWatch. This step ensures that logs are automatically captured and stored in CloudWatch Logs.

#### 1.1 Enable CloudWatch Logs for AWS Lambda
AWS Lambda functions automatically generate logs and send them to CloudWatch. However, you need to ensure that:
- **CloudWatch Logs permissions** are properly set for the Lambda execution role.

#### Steps for Configuring CloudWatch Logs for Lambda:
1. Go to the **IAM Console** and check the Lambda function’s execution role.
2. Ensure the following permissions are attached to the role:
   ```json
   {
     'Effect': 'Allow',
     'Action': [
       'logs:CreateLogGroup',
       'logs:CreateLogStream',
       'logs:PutLogEvents'
     ],
     'Resource': '*'
   }
   ```

#### 1.2 Enable CloudWatch Logs for EC2
For EC2 instances, the **CloudWatch Logs Agent** or the **CloudWatch Unified Agent** can be installed to push logs to CloudWatch.

#### Steps to Install the CloudWatch Logs Agent on EC2:
1. Install the CloudWatch Logs Agent on the EC2 instance:
   ```bash
   sudo yum install -y awslogs
   ```

2. Configure the `/etc/awslogs/awslogs.conf` file to specify which logs to push:
   ```ini
   [general]
   state_file = /var/awslogs/state/agent-state

   [/var/log/messages]
   log_group_name = /var/log/messages
   log_stream_name = {instance_id}
   file = /var/log/messages
   ```

3. Start and enable the CloudWatch Logs agent:
   ```bash
   sudo systemctl start awslogsd
   sudo systemctl enable awslogsd
   ```

#### 1.3 Enable CloudWatch Logs for ECS
For ECS (Elastic Container Service), ensure that each task definition is configured to push logs to CloudWatch.

#### Steps to Enable CloudWatch Logs in ECS Task Definition:
1. Go to the **ECS Console**.
2. Edit your task definition and ensure the `logConfiguration` for each container includes CloudWatch:
   ```json
   'logConfiguration': {
     'logDriver': 'awslogs',
     'options': {
       'awslogs-group': '/ecs/my-service',
       'awslogs-region': 'us-east-1',
       'awslogs-stream-prefix': 'ecs'
     }
   }
   ```

3. Update the task definition and redeploy your ECS service to apply the new logging configuration.

### 2. Forward CloudWatch Logs to Kibana
To ensure that logs are also available in the team’s central Kibana instance, configure a log forwarding mechanism from CloudWatch Logs to an ** Elasticsearch Service** (now called ** OpenSearch Service**) cluster, which integrates with Kibana for visualization and search.

#### 2.1 Create or Verify the OpenSearch (Elasticsearch) Cluster
Ensure that you have an OpenSearch (formerly Elasticsearch) cluster set up with Kibana, which will serve as the destination for log forwarding.

#### 2.2 Set Up CloudWatch Logs Subscription Filter
To forward logs from CloudWatch to the OpenSearch cluster (and Kibana), use a **CloudWatch Logs Subscription Filter** with **Lambda** or **Kinesis Firehose** to process and forward logs.

#### Option 1: Use a Lambda Function to Forward Logs to OpenSearch
1. Create an AWS Lambda function to process logs and forward them to the OpenSearch service.

2. In the Lambda function code, process incoming CloudWatch Logs events and forward them to the OpenSearch service:
   ```python
   import json
   import base64
   import gzip
   from elasticsearch import Elasticsearch, RequestsHttpConnection

   es = Elasticsearch(
       hosts=[{'host': 'your-opensearch-domain', 'port': 443}],
       use_ssl=True,
       verify_certs=True,
       connection_class=RequestsHttpConnection
   )

   def lambda_handler(event, context):
       cw_data = base64.b64decode(event['awslogs']['data'])
       cw_data = gzip.decompress(cw_data)
       logs = json.loads(cw_data)
       for log_event in logs['logEvents']:
           es.index(index='logs', doc_type='_doc', body=log_event)
   ```

3. Set up a **CloudWatch Logs Subscription Filter** to send logs to this Lambda function:
   ```bash
   aws logs put-subscription-filter        --log-group-name /aws/lambda/my-lambda-function        --filter-name 'LambdaLogsToElasticsearch'        --filter-pattern ''        --destination-arn arn:aws:lambda:us-east-1:123456789012:function:my-log-forwarder
   ```

#### Option 2: Use Kinesis Firehose to Forward Logs to OpenSearch
Alternatively, you can use **Kinesis Data Firehose** to automatically forward logs from CloudWatch to OpenSearch.

1. Create a **Kinesis Firehose** delivery stream with an ** OpenSearch** destination.
2. Set up a **CloudWatch Logs Subscription Filter** to forward logs to Kinesis Firehose:
   ```bash
   aws logs put-subscription-filter        --log-group-name /aws/lambda/my-lambda-function        --filter-name 'LogsToFirehose'        --filter-pattern ''        --destination-arn arn:aws:firehose:us-east-1:123456789012:deliverystream/my-stream
   ```

### 3. Verify Logs in Kibana
Once the logs are forwarded to the OpenSearch cluster, access the **Kibana Dashboard** to verify that logs are being ingested correctly.

1. Navigate to the Kibana instance associated with the OpenSearch cluster.
2. Use **Discover** to query logs and ensure that logs from CloudWatch are available in the Kibana interface.

### 4. Monitor Log Forwarding
Set up monitoring for the log forwarding process to ensure that logs are consistently pushed to both CloudWatch and Kibana. Use **CloudWatch Alarms** to monitor the health of the log forwarding Lambda function or Kinesis Firehose delivery stream.

#### Example CloudWatch Alarm to Monitor Lambda Failures:
1. Go to the **CloudWatch Console** and create an alarm on the **Errors** metric for the Lambda function forwarding logs.
2. Set up an alarm to notify the team in case the Lambda function fails to process logs:
   ```bash
   aws cloudwatch put-metric-alarm        --alarm-name 'LogForwardingLambdaErrors'        --metric-name Errors        --namespace AWS/Lambda        --statistic Sum        --period 300        --threshold 1        --comparison-operator GreaterThanThreshold        --evaluation-periods 1        --alarm-actions arn:aws:sns:us-east-1:123456789012:MySNSTopic        --dimensions Name=FunctionName,Value=my-log-forwarder
   ```

### Testing
- **CloudWatch Log Verification**: Verify that all services (Lambda, EC2, ECS) are pushing logs to CloudWatch.
- **Kibana Log Verification**: Ensure that logs forwarded to OpenSearch are searchable and viewable in Kibana.
- **Log Consistency Test**: Check that logs in CloudWatch and Kibana are consistent and complete.
- **Log Forwarding Monitoring**: Set up monitoring to ensure that the log forwarding mechanism is reliable and doesn’t drop logs.

### External Dependencies
- ** CloudWatch**: Used for log aggregation and monitoring.
- ** OpenSearch Service (Elasticsearch)**: Serves as the backend for log storage and search, with Kibana for visualization.
- **Lambda/Kinesis Firehose**: For forwarding logs from CloudWatch to OpenSearch.

## Acceptance Criteria
- Should have all service logs pushed to  CloudWatch.
- Should have logs forwarded from CloudWatch to the team’s central Kibana instance.
- Should have verified that logs are available and searchable in Kibana.
- Should have monitoring in place to detect failures in the log forwarding process.
- Should ensure the solution is scalable and handles log volume growth.

### Gherkin
#### Scenario: Pushing Logs to CloudWatch
Given services are running,
When logs are generated,
Then they should be pushed to  CloudWatch.

#### Scenario: Forwarding Logs from CloudWatch to Kibana
Given logs are available in CloudWatch,
When the log forwarding mechanism is configured,
Then logs should be forwarded to the central Kibana instance,
And the logs should be searchable in Kibana.

#### Scenario: Monitoring Log Forwarding
Given the log forwarding mechanism is active,
When an error occurs in the forwarding process,
Then an alert should be sent to notify the team of the failure.

## External Links
- [ CloudWatch Logs Documentation](https://docs.aws.amazon.com/
- [ OpenSearch Service (Elasticsearch) Documentation](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/what-is.html)
- [Kibana Documentation](https://www.elastic.co/guide/en/kibana/current/index.html)
