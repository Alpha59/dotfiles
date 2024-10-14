
# Implement auto rollback alarms for gamma, blue/green deployments and prod stage deployments
### Summary
**As a** DevOps Engineer, **I want** to implement auto-rollback alarms for **gamma**, **blue/green deployments**, and **prod stage deployments**, **So That** if issues arise during the deployment process, the system can automatically revert to the previous stable version, ensuring minimal downtime and reducing the risk of errors in production.

This story focuses on setting up automated rollback mechanisms using AWS deployment tools (like CodeDeploy, Lambda, or ECS) and CloudWatch alarms to monitor deployment health. By implementing alarms and rollback strategies, we ensure safer deployments and quicker recovery from failed deployments.

### Vision
By implementing auto-rollback alarms, we can automatically detect failures during deployments and trigger a rollback without manual intervention. This improves the reliability and stability of the deployment process, especially in critical environments like production.

### Background
Automated rollback mechanisms help maintain high availability and minimize the impact of failed deployments. When deploying new versions in a gamma, blue/green, or production stage, failures can occur due to misconfigurations, performance issues, or unanticipated code bugs. By configuring CloudWatch alarms and using deployment tools that support auto-rollback, such as AWS CodeDeploy or Lambda's traffic shifting capabilities, we can mitigate these risks.

---

### Steps for Implementing Auto-Rollback Alarms

#### 1. **Prerequisites**

- **AWS CloudWatch Alarms**: Ensure that CloudWatch alarms are configured to monitor the health of the deployed applications (e.g., error rates, latency, request failures).
- **Deployment Tooling**: Use AWS CodeDeploy for EC2 or ECS-based deployments, or AWS Lambda's alias traffic shifting for blue/green deployments.
- **IAM Permissions**: Ensure the correct IAM roles and permissions are in place to trigger rollbacks and update deployment statuses.

---

### 2. **Set Up CloudWatch Alarms for Health Metrics**

For any deployment stage (gamma, blue/green, or production), configure CloudWatch alarms to monitor critical metrics that indicate deployment failure.

#### 2.1 **Define Key Metrics for Monitoring**
- **HTTP 5xx Error Rates**: Monitor the percentage of 5xx errors (e.g., `5xxErrorRate`) for HTTP-based services.
- **Latency and Response Time**: Monitor average response time for APIs or services (`Latency`, `ResponseTime`).
- **Request Failures**: Monitor the number of failed requests (`RequestFailureCount`).
- **CPU/Memory Utilization**: Monitor CPU and memory usage (`CPUUtilization`, `MemoryUtilization`) to detect resource constraints.
- **Custom Application Metrics**: Use custom metrics for application-specific errors (e.g., `AppErrorCount`).

Example of creating a CloudWatch alarm for a high 5xx error rate:
```bash
aws cloudwatch put-metric-alarm --alarm-name 'High5xxErrorRate'   --metric-name 5xxErrorRate --namespace AWS/ApplicationELB   --statistic Average --period 60 --threshold 5   --comparison-operator GreaterThanThreshold   --evaluation-periods 2 --alarm-actions <SNS-or-Lambda-function-ARN>
```

---

### 3. **Configure Auto-Rollback for CodeDeploy (Blue/Green)**

For services deployed using **AWS CodeDeploy** in a blue/green deployment pattern, you can enable automatic rollback if deployment health checks fail.

#### 3.1 **Enable Rollback on Alarm**

In the CodeDeploy deployment configuration, specify that rollbacks should be triggered when a CloudWatch alarm is breached during deployment.

Example CodeDeploy configuration:
```yaml
{
  'applicationName': 'MyApp',
  'deploymentGroupName': 'MyApp-DeploymentGroup',
  'deploymentConfigName': 'CodeDeployDefault.OneAtATime',
  'autoRollbackConfiguration': {
    'enabled': true,
    'events': [
      'DEPLOYMENT_FAILURE',
      'DEPLOYMENT_STOP_ON_ALARM'
    ],
    'alarms': [
      {
        'name': 'High5xxErrorRate'
      }
    ]
  }
}
```

#### 3.2 **Set Up Health Checks for Blue/Green Deployments**

During blue/green deployments, CodeDeploy can shift traffic to the new version and monitor the health of the deployment using the specified health checks (e.g., latency, error rates). If any CloudWatch alarms trigger, the traffic is automatically shifted back to the previous version.

- **Blue/Green Traffic Shifting**: Automatically revert to the previous version if health checks fail.
- **Pre and Post-Deployment Hooks**: Add pre-deployment and post-deployment hooks to validate the environment before and after the deployment.

```bash
aws deploy create-deployment-group     --application-name MyApp     --deployment-group-name MyApp-DeploymentGroup     --blue-green-deployment-configuration file://blue-green-config.json
```

---

### 4. **Lambda Auto-Rollback Using Alias and Traffic Shifting**

For **AWS Lambda** deployments, use **Lambda aliases** to implement blue/green or canary deployments. AWS Lambda natively supports traffic shifting between Lambda versions, allowing for rollback based on CloudWatch alarms.

#### 4.1 **Configure Lambda Traffic Shifting**

You can create a Lambda alias and configure it to shift traffic between versions based on a pre-defined traffic distribution. AWS automatically monitors the health of the deployment and rolls back in case of alarm triggers.

Example traffic-shifting configuration using AWS SAM for Lambda canary deployment:
```yaml
AutoPublishAlias:
  Type: AWS::Serverless::Function
  Properties:
    FunctionName: MyLambdaFunction
    Handler: index.handler
    Runtime: nodejs14.x
    CodeUri: .
    AutoPublishAlias: live
    DeploymentPreference:
      Type: Canary10Percent5Minutes
      Alarms:
        - !Ref LambdaErrorAlarm
```

#### 4.2 **Set Up CloudWatch Alarms for Lambda**

Set up CloudWatch alarms for monitoring Lambda error rates, duration, and throttling events. These alarms can trigger a rollback if the new version does not meet the expected performance.

```bash
aws cloudwatch put-metric-alarm --alarm-name 'LambdaErrorAlarm'   --metric-name Errors --namespace AWS/Lambda   --statistic Sum --period 60 --threshold 5   --comparison-operator GreaterThanThreshold   --evaluation-periods 1 --alarm-actions <SNS-or-Lambda-function-ARN>
```

When this alarm triggers, the Lambda deployment automatically rolls back, and traffic is routed back to the stable version.

---

### 5. **Configuring Auto-Rollback for ECS Services**

For **AWS ECS** (Elastic Container Service), blue/green deployments can be configured using AWS CodeDeploy or ECS with CloudFormation.

#### 5.1 **Enable Auto-Rollback in ECS Deployment**

Using ECS and CodeDeploy for blue/green deployments, configure the ECS service to automatically rollback if CloudWatch alarms detect any issues.

```yaml
{
  'applicationName': 'MyECSApp',
  'deploymentGroupName': 'ECS-DeploymentGroup',
  'serviceRoleArn': 'arn:aws:iam::123456789012:role/CodeDeployRole',
  'autoRollbackConfiguration': {
    'enabled': true,
    'events': [
      'DEPLOYMENT_STOP_ON_ALARM',
      'DEPLOYMENT_FAILURE'
    ],
    'alarms': [
      {
        'name': 'HighCPUUtilizationAlarm'
      }
    ]
  }
}
```

#### 5.2 **Monitor ECS Services with CloudWatch**

For ECS services, monitor the health of the containerized applications through metrics like CPU/memory utilization, task failures, and request errors. Set up alarms to detect when the new version fails and trigger rollbacks.

```bash
aws cloudwatch put-metric-alarm --alarm-name 'HighCPUUtilizationAlarm'   --metric-name CPUUtilization --namespace AWS/ECS   --statistic Average --period 60 --threshold 80   --comparison-operator GreaterThanThreshold   --evaluation-periods 2 --alarm-actions <SNS-or-Lambda-function-ARN>
```

If the alarm is triggered during deployment, CodeDeploy will automatically rollback the service to the previous stable version.

---

### 6. **Handling Prod Stage Deployments**

For **production stage deployments**, configure the same set of CloudWatch alarms but with stricter thresholds and tighter monitoring, as downtime or performance degradation in production can have critical impacts.

- **Prod-Specific Metrics**: Use prod-specific metrics such as customer-facing error rates, API latency, and transaction failures.
- **Zero-Downtime Rollback**: Ensure that rollbacks in production occur without interrupting user traffic by using blue/green or canary deployments.
- **Post-Deployment Verification**: Use post-deployment hooks to validate service behavior after deployment in production.

---

### 7. **Testing and Validating Rollback Mechanism**

#### 7.1 **Simulate a Failed Deployment**
- Deploy a version with deliberate errors to test the rollback mechanism.
- Trigger the CloudWatch alarms and verify that the rollback occurs automatically.

#### 7.2 **Monitor Logs and Alarms**
- Review CloudWatch logs and CodeDeploy events to ensure that the rollback was executed as expected.

---

### Acceptance Criteria

- Should have CloudWatch alarms set up for monitoring key metrics during gamma, blue/green, and production stage deployments.
- Should configure auto-rollback for CodeDeploy (blue/green), ECS, and Lambda using AWS tools and services.
- Should have traffic-shifting mechanisms in place for Lambda and ECS services.
- Should have thoroughly tested the rollback process in both staging and production environments.
- Should ensure that deployments automatically roll back to the last stable version if predefined alarms are triggered.
