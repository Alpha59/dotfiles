
# Create a pipeline to deploy standard operational and oncall tools as lambdas into existing AWS account
### Summary
**As a** DevOps Engineer, **I want** to create a pipeline to deploy standard operational and on-call tools as AWS Lambda functions into an existing AWS account, **So That** we can automate the deployment of operational and on-call monitoring, alerting, and troubleshooting tools, ensuring consistency and ease of maintenance.

This story focuses on setting up a CI/CD pipeline to deploy operational tools (e.g., log processors, alerting handlers) and on-call tools (e.g., automated response scripts, health checkers) as Lambda functions into an existing AWS environment. The pipeline will automate the deployment process, making it easier to maintain and update these functions across different environments.

### Vision
By creating a pipeline for deploying operational and on-call tools as Lambda functions, we can standardize and automate the deployment of critical tools. This reduces manual effort, ensures consistency across environments, and improves the responsiveness and reliability of operational tools.

### Background
Currently, operational and on-call tools may be deployed manually or inconsistently across environments. By using a CI/CD pipeline, we can ensure that these tools are deployed in a repeatable, reliable way. Lambda functions are well-suited for operational tasks because they can be triggered based on events, require no infrastructure management, and can scale automatically.

### Purpose
The purpose of this story is to create a CI/CD pipeline that automates the deployment of operational and on-call tools as Lambda functions. This pipeline will ensure that these tools are deployed efficiently, can be updated easily, and are consistent across different AWS accounts and environments.

## Details
### 1. Identify Operational and On-Call Tools for Deployment
- Identify the set of operational and on-call tools that need to be deployed as Lambda functions. These tools may include:
  - **Log Processors**: Lambda functions that process logs from CloudWatch or S3 and generate alerts or insights.
  - **Alerting Handlers**: Lambda functions that trigger notifications (e.g., via SNS, PagerDuty) based on CloudWatch alarms or other events.
  - **Health Checkers**: Lambda functions that periodically check the health of services or endpoints and alert the on-call team if issues are detected.
  - **Auto-Healing Tools**: Lambda functions that automatically remediate common issues (e.g., restarting failed EC2 instances, clearing cache) to reduce the on-call burden.

### 2. Set Up the Lambda Deployment Pipeline
- Use a CI/CD tool like **AWS CodePipeline**, **Jenkins**, **GitHub Actions**, or **GitLab CI** to automate the deployment of Lambda functions.
- The pipeline will include the following stages:
  1. **Source Stage**: Pull the Lambda function code from a version control system (e.g., GitHub, GitLab).
  2. **Build Stage**: Package the Lambda function code, including any dependencies (e.g., using AWS SAM or the AWS CDK).
  3. **Test Stage**: Run unit tests or integration tests on the Lambda function code to ensure correctness.
  4. **Deploy Stage**: Deploy the Lambda functions into the specified AWS account and environment using tools like AWS CloudFormation or AWS CDK.

#### Example Pipeline Using AWS CodePipeline and AWS CodeBuild:
```yaml
name: Deploy Operational Tools to AWS Lambda

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v2

      - name: Install AWS CLI
        run: |
          sudo apt-get update
          sudo apt-get install awscli

      - name: Install Dependencies
        run: |
          pip install aws-sam-cli
          pip install -r requirements.txt

      - name: Run Unit Tests
        run: pytest

      - name: Build and Package Lambda Function
        run: sam build && sam package --output-template-file packaged.yaml --s3-bucket <s3-bucket-for-lambda>

      - name: Deploy Lambda Function
        run: |
          aws cloudformation deploy             --template-file packaged.yaml             --stack-name operational-tools-lambda             --capabilities CAPABILITY_IAM             --region <aws-region>
```

### 3. Define Lambda Functions in Infrastructure as Code (IaC)
- Use AWS **Serverless Application Model (SAM)** or **AWS Cloud Development Kit (CDK)** to define the Lambda functions as code. This allows for consistent, repeatable deployments.

#### Example AWS SAM Template for Deploying a Lambda Function:
```yaml
Resources:
  LogProcessorLambda:
    Type: AWS::Serverless::Function
    Properties:
      Handler: log_processor.handler
      Runtime: python3.8
      CodeUri: ./src/log_processor/
      MemorySize: 128
      Timeout: 60
      Environment:
        Variables:
          LOG_LEVEL: INFO
      Events:
        LogTrigger:
          Type: CloudWatchLogs
          Properties:
            LogGroupName: /aws/lambda/logs
```

#### Example AWS CDK Code for Lambda Deployment:
```typescript
import * as cdk from 'aws-cdk-lib';
import * as lambda from 'aws-cdk-lib/aws-lambda';
import * as cloudwatch from 'aws-cdk-lib/aws-cloudwatch';
import { Construct } from 'constructs';

export class OnCallToolsStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const logProcessorLambda = new lambda.Function(this, 'LogProcessorLambda', {
      runtime: lambda.Runtime.PYTHON_3_8,
      handler: 'log_processor.handler',
      code: lambda.Code.fromAsset('src/log_processor'),
      environment: {
        LOG_LEVEL: 'INFO'
      }
    });

    const logGroup = new cloudwatch.LogGroup(this, 'LogGroup', {
      logGroupName: '/aws/lambda/logs',
    });

    logProcessorLambda.addEventSource(new lambda_event_sources.CloudWatchLogsEventSource(logGroup));
  }
}
```

### 4. Configure IAM Roles and Permissions for Lambda Functions
- Define the necessary **IAM roles and policies** for each Lambda function to ensure they have appropriate permissions to perform their tasks. For example:
  - **Log Processors**: Require permissions to read CloudWatch Logs and write to S3 or send notifications via SNS.
  - **Health Checkers**: Require permissions to query the status of services (e.g., EC2, ECS) and send alerts via SNS.
  - **Auto-Healing Tools**: Require permissions to modify resources, such as restarting EC2 instances or updating load balancer configurations.

#### Example IAM Role for a Log Processor Lambda Function:
```yaml
Resources:
  LogProcessorRole:
    Type: AWS::IAM::Role
    Properties:
      AssumeRolePolicyDocument:
        Version: '2012-10-17'
        Statement:
          - Effect: Allow
            Principal:
              Service: lambda.amazonaws.com
            Action: sts:AssumeRole
      Policies:
        - PolicyName: LogProcessorPolicy
          PolicyDocument:
            Version: '2012-10-17'
            Statement:
              - Effect: Allow
                Action:
                  - logs:CreateLogGroup
                  - logs:CreateLogStream
                  - logs:PutLogEvents
                  - s3:PutObject
                  - sns:Publish
                Resource: '*'
```

### 5. Implement Testing for Lambda Functions
- Include unit tests and integration tests to ensure the Lambda functions work as expected.
- Use tools like **Pytest** (for Python), **Jest** (for Node.js), or other relevant testing frameworks to write tests for each Lambda function.

#### Example Python Unit Test for Lambda:
```python
import json
from log_processor import handler

def test_log_processor():
    event = {
        'awslogs': {
            'data': '...'
        }
    }
    result = handler(event, None)
    assert result == 'Log processed successfully'
```

### 6. Deploy to Multiple Environments
- Ensure that the pipeline supports deployment to multiple environments (e.g., dev, staging, production). Use environment variables or configuration files to manage environment-specific settings (e.g., memory size, timeout, API endpoints).

#### Example CodePipeline YAML to Deploy to Multiple Environments:
```yaml
environments:
  - name: dev
    s3_bucket: dev-lambda-bucket
    region: us-east-1

  - name: prod
    s3_bucket: prod-lambda-bucket
    region: us-east-1
```

### 7. Monitor Lambda Function Performance
- Set up monitoring for Lambda functions using **AWS CloudWatch** to track metrics such as:
  - **Invocation counts**
  - **Error rates**
  - **Duration (execution time)**
  - **Throttling events**
- Configure **CloudWatch Alarms** to notify the on-call team if any operational or on-call Lambda function fails or exceeds predefined thresholds.

#### Example CloudWatch Alarm for Lambda Errors:
```bash
aws cloudwatch put-metric-alarm     --alarm-name 'LambdaErrorAlarm'     --metric-name Errors     --namespace AWS/Lambda     --statistic Sum     --period 300     --threshold 1     --comparison-operator GreaterThanOrEqualToThreshold     --dimensions Name=FunctionName,Value=<lambda-function-name>     --evaluation-periods 1     --alarm-actions <sns-topic-arn>
```

### 8. Document and Train
- Document the pipeline setup, including how to add new Lambda functions, update existing ones, and manage different environments.
- Provide training to the DevOps and on-call teams on how to monitor, troubleshoot, and deploy operational and on-call tools using the pipeline.

### Testing
- **Pipeline Tests**: Ensure that the CI/CD pipeline runs successfully from code checkout to deployment of Lambda functions.
- **Unit Tests**: Write and run unit tests to validate the correctness of each Lambda function’s logic.
- **Integration Tests**: Test the interaction between Lambda functions and other AWS services (e.g., CloudWatch, SNS) to ensure they are working as expected.

### External Dependencies
- Integration with AWS services like Lambda, CloudWatch, S3, IAM, SNS, and CloudFormation.
- Use of a CI/CD tool such as AWS CodePipeline, Jenkins, GitHub Actions, or GitLab CI to automate the deployment process.

## Acceptance Criteria
- Should have created a pipeline to deploy operational and on-call tools as Lambda functions.
- Should have defined Lambda functions using AWS SAM or CDK for automated deployment.
- Should have set up IAM roles and policies for Lambda functions to grant them the necessary permissions.
- Should have implemented unit and integration tests for each Lambda function to ensure correctness.
- Should have deployed the Lambda functions to multiple environments using the CI/CD pipeline.
- Should have documented the process and provided training to the on-call and DevOps teams.

### Gherkin
#### Scenario: Deploy Operational Tools as Lambda Functions
Given the operational tool Lambda functions,
When the pipeline is triggered,
Then the functions should be automatically deployed to the AWS account with the correct configuration and IAM roles.

#### Scenario: Monitoring Lambda Functions
Given an operational Lambda function,
When it exceeds predefined error thresholds,
Then CloudWatch should trigger an alarm and notify the on-call team via SNS.

## External Links
- [AWS Lambda Deployment via AWS CodePipeline](https://docs.aws.amazon.com/lambda/latest/dg/automating-deployment.html)
- [AWS SAM Documentation](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html)
- [AWS CDK Documentation](https://docs.aws.amazon.com/cdk/latest/guide/home.html)
