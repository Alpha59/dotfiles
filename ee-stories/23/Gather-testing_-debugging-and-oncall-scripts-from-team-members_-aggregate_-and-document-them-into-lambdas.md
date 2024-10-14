
# Gather testing, debugging and oncall scripts from team members, aggregate, and document them into lambdas
### Summary
**As a** DevOps Engineer, **I want** to gather testing, debugging, and on-call scripts from team members, **So That** they can be aggregated and documented as AWS Lambda functions, enabling automation and centralization of important operational tasks.

This story focuses on gathering various scripts from team members that are used for testing, debugging, and on-call support, aggregating these into a standardized format, and deploying them as Lambda functions. This approach will streamline operational processes, allow for easy access to common scripts, and ensure they can be executed in a serverless, scalable environment.

### Vision
By aggregating testing, debugging, and on-call scripts into AWS Lambda functions, we can automate operational tasks, reduce manual effort, and provide team members with a centralized, consistent, and easily accessible toolset. This will increase efficiency, minimize human errors, and improve response times during incidents.

### Background
Many team members use ad-hoc scripts for various operational tasks such as debugging, monitoring, and responding to on-call incidents. These scripts are often maintained individually and can vary in format and style. By aggregating them into standardized Lambda functions, the team can automate these tasks, maintain a single repository, and ensure that scripts are documented and maintained properly.

### Purpose
The purpose of this story is to gather, standardize, and aggregate testing, debugging, and on-call scripts into Lambda functions, ensuring they are centrally documented and accessible for the entire team. This will enable automation of manual tasks, improve operational efficiency, and ensure that on-call teams have reliable tools to handle incidents.

## Details
### 1. Gather Scripts from Team Members
Collect all relevant testing, debugging, and on-call scripts from the team. These scripts may include:
  - **Testing Scripts**: Scripts used for functional testing, unit testing, integration testing, or smoke testing.
  - **Debugging Scripts**: Scripts used to collect logs, analyze errors, or diagnose issues.
  - **On-Call Scripts**: Scripts used to monitor service health, restart services, or trigger automated recovery mechanisms during incidents.

You can collect the scripts by:
  - Sending out a request to team members to share their most commonly used scripts.
  - Reviewing the team’s existing repositories to identify frequently used operational scripts.

### 2. Aggregate and Standardize Scripts
Once all scripts are gathered, aggregate them into a single repository and standardize their format to ensure consistency across all scripts. This includes:
  - **Language Standardization**: Convert scripts to a common language (e.g., Python, Node.js) if necessary, to ensure they can be easily deployed as Lambda functions.
  - **Script Naming Conventions**: Ensure all scripts follow a standardized naming convention that reflects their purpose (e.g., `test-integration`, `debug-logs`, `oncall-restart-service`).
  - **Input/Output Standardization**: Ensure that all scripts accept standardized input parameters (e.g., JSON input) and return output in a consistent format.

#### Example of Standardizing a Python Script:
```python
import json
import boto3

def lambda_handler(event, context):
    # Extract parameters from event
    service_name = event.get('service_name')

    # Example logic: Get logs for a specific service
    logs = get_service_logs(service_name)

    # Return logs in a standardized format
    return {
        'statusCode': 200,
        'body': json.dumps({
            'service_name': service_name,
            'logs': logs
        })
    }

def get_service_logs(service_name):
    # Example logic for fetching logs (can be customized)
    client = boto3.client('logs')
    response = client.describe_log_streams(logGroupName=f'/aws/lambda/{service_name}')
    return response
```

### 3. Document Each Script
Document each script thoroughly, explaining its purpose, input parameters, expected output, and use cases. This documentation should be included in the Lambda function code and external documentation (e.g., in Confluence or a team wiki).

#### Example Documentation Template:
```markdown
## Script Name: `test-integration`

### Purpose:
This script is used to run integration tests for a specific microservice. It fetches the latest test data and executes the tests on the microservice.

### Input Parameters:
- `service_name` (string): The name of the microservice to test.
- `test_suite` (string): The name of the test suite to run.

### Output:
- `statusCode`: 200 if the test is successful, otherwise error codes.
- `body`: JSON containing test results.

### Usage:
Invoke the Lambda function with the required parameters:
```bash
aws lambda invoke --function-name test-integration --payload '{'service_name': 'user-service', 'test_suite': 'regression'}' output.json
```
```

### 4. Convert Scripts to Lambda Functions
For each script, convert the logic into an AWS Lambda function. This process involves:
  - **Writing the Lambda Handler**: Ensure that each script has a `lambda_handler` function to process incoming events and return results.
  - **Integrating with AWS Services**: If the script interacts with AWS services (e.g., S3, CloudWatch, EC2), ensure that appropriate AWS SDKs are used (e.g., `boto3` for Python, `aws-sdk` for Node.js).
  - **Error Handling**: Add robust error handling and logging within each Lambda function to ensure that errors are captured and reported.

#### Example Python Lambda Handler:
```python
import json
import boto3

def lambda_handler(event, context):
    try:
        service_name = event['service_name']

        # Perform an operation (e.g., restart a service)
        restart_service(service_name)

        return {
            'statusCode': 200,
            'body': json.dumps(f'Service {service_name} restarted successfully')
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error restarting service: {str(e)}')
        }

def restart_service(service_name):
    # Example logic to restart an AWS ECS service
    ecs_client = boto3.client('ecs')
    response = ecs_client.update_service(
        cluster='my-cluster',
        service=service_name,
        forceNewDeployment=True
    )
    return response
```

### 5. Deploy Lambda Functions
Deploy each script as a Lambda function using AWS CDK or AWS SAM. Ensure that the appropriate execution roles and permissions are set for each Lambda function, allowing them to access required AWS services.

#### Example of Deploying a Lambda Function Using AWS CDK (TypeScript):
```typescript
import * as cdk from 'aws-cdk-lib';
import * as lambda from 'aws-cdk-lib/aws-lambda';
import * as iam from 'aws-cdk-lib/aws-iam';

export class OncallScriptsStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // Define a Lambda function for the on-call restart script
    const restartServiceLambda = new lambda.Function(this, 'RestartServiceLambda', {
      runtime: lambda.Runtime.PYTHON_3_8,
      code: lambda.Code.fromAsset('lambda/restart-service'),
      handler: 'restart_service.lambda_handler',
    });

    // Grant the Lambda function permissions to restart ECS services
    restartServiceLambda.addToRolePolicy(new iam.PolicyStatement({
      actions: ['ecs:UpdateService'],
      resources: ['*'],
    }));
  }
}
```

### 6. Test Each Lambda Function
After deployment, test each Lambda function to ensure that it works as expected. This includes:
  - Testing with valid input parameters.
  - Handling edge cases and invalid input.
  - Verifying that output is returned in the correct format.

#### Example of Invoking a Lambda Function from the AWS CLI:
```bash
aws lambda invoke --function-name test-integration --payload '{'service_name': 'user-service', 'test_suite': 'smoke'}' output.json
```

### 7. Set Up CloudWatch Logs and Alerts
Configure **CloudWatch Logs** to capture the logs from each Lambda function for debugging and monitoring purposes. Additionally, set up **CloudWatch Alarms** to notify the on-call team if any of the functions fail during execution.

#### Example CloudWatch Alarm for Lambda Errors:
1. Navigate to **CloudWatch Console**.
2. Create an alarm based on the **Lambda Errors** metric.
3. Set up a notification to trigger if errors exceed a threshold (e.g., 1 error in 5 minutes).
4. Send notifications to an **SNS topic** for on-call alerts.

### 8. Maintain and Update Scripts
Ensure that the scripts are regularly reviewed and updated as the system evolves. This can be done by:
  - Creating a process for team members to submit new scripts or updates to existing ones.
  - Assigning ownership of each Lambda function to ensure it is maintained over time.
  - Documenting any changes made to the scripts or Lambda functions.

### Testing
- **Lambda Test**: Test each Lambda function to verify that it handles input and output correctly, performs the intended operation, and logs any errors.
- **Integration Test**: Test the integration of Lambda functions with AWS services (e.g., ECS, S3, RDS) to ensure that they can interact with other AWS resources.
- **Monitoring Test**: Verify that CloudWatch Logs and Alarms are working correctly and that alerts are triggered when functions fail.

### External Dependencies
- **AWS CDK or SAM**: Use AWS CDK or SAM to deploy and manage Lambda functions.
- **AWS Services**: Ensure that the Lambda functions have the necessary permissions to interact with services such as ECS, S3, CloudWatch, or RDS.
- **CloudWatch Logs and Alarms**: Configure monitoring and alerting for Lambda functions using CloudWatch.

## Acceptance Criteria
- Should have collected testing, debugging, and on-call scripts from team members.
- Should have standardized and documented the scripts for consistent input/output and error handling.
- Should have converted the scripts into AWS Lambda functions.
- Should have deployed the Lambda functions to AWS with the necessary permissions and roles.
- Should have tested the Lambda functions to ensure they work as expected.
- Should have set up CloudWatch monitoring and alerts for error tracking and on-call notifications.

### Gherkin
#### Scenario: Converting and Deploying On-Call Scripts to Lambda
Given the on-call scripts are collected from the team,
When the scripts are converted to Lambda functions,
Then they should be deployed to AWS with proper documentation and monitoring.

#### Scenario: Testing Lambda Functions for Debugging
Given a debugging script is converted to a Lambda function,
When valid and invalid input is provided,
Then the function should execute correctly and log errors where applicable.

#### Scenario: Monitoring Lambda Functions for Failures
Given the Lambda functions are deployed,
When a function fails,
Then CloudWatch should log the error,
And the on-call team should be notified via SNS.

## External Links
- [AWS Lambda Documentation](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- [AWS CDK Documentation](https://docs.aws.amazon.com/cdk/latest/guide/home.html)
- [AWS CloudWatch Documentation](https://docs.aws.amazon.com/cloudwatch/latest/monitoring/WhatIsCloudWatch.html)
