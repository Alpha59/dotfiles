
# Move remaining alarms to CDK from any previous system that was being used
### Summary
**As a** DevOps Engineer, **I want** to move the remaining alarms to AWS Cloud Development Kit (CDK) from any previous system that was being used, **So That** the infrastructure-as-code (IaC) approach is fully implemented, making alarm management more maintainable, version-controlled, and easily scalable.

This story focuses on migrating existing alarms from legacy systems or manual configurations to CDK. CDK provides a programmatic, declarative way to define, deploy, and manage infrastructure, including CloudWatch alarms. By moving the remaining alarms to CDK, we ensure better management and consistency across environments.

### Vision
By moving the remaining alarms to CDK, we streamline alarm management, making it easier to modify, deploy, and track changes through code. This enables rapid updates, improves the ability to scale, and provides visibility through version control, all while maintaining alignment with other infrastructure managed through CDK.

### Background
Alarms are often initially set up manually or using different systems like CloudFormation, Terraform, or even manual configurations via the AWS Console. Migrating these to CDK ensures that all infrastructure is defined as code, reducing manual work, improving consistency across environments, and providing better control over monitoring configurations.

## Details

1. **Identify Existing Alarms in Legacy Systems**
   - Inventory all existing alarms that are still configured using previous systems or manually in the AWS Console. This includes alarms configured in:
     - AWS Console directly.
     - CloudFormation templates.
     - Terraform scripts or other infrastructure management tools.
   - List the key attributes of each alarm:
     - Metric being monitored (e.g., CPUUtilization, MemoryUsage, etc.).
     - Alarm thresholds and conditions.
     - Notification actions (e.g., SNS topics, Lambda functions, email alerts).
     - Environment (e.g., development, staging, production).

2. **Translate Alarms to CDK Constructs**
   - For each identified alarm, translate its configuration into the corresponding CDK construct. AWS CDK provides CloudWatch alarm constructs that allow you to define alarms in a declarative manner.
   - Example CDK code for creating an alarm:
     ```typescript
     import * as cdk from '@aws-cdk/core';
     import * as cloudwatch from '@aws-cdk/aws-cloudwatch';
     import * as sns from '@aws-cdk/aws-sns';
     import * as snsSubscriptions from '@aws-cdk/aws-sns-subscriptions';

     // Example SNS topic for notification
     const alarmTopic = new sns.Topic(this, 'AlarmTopic');

     // Example CloudWatch alarm for CPU Utilization
     const cpuAlarm = new cloudwatch.Alarm(this, 'CpuAlarm', {
       metric: new cloudwatch.Metric({
         namespace: 'AWS/EC2',
         metricName: 'CPUUtilization',
         dimensionsMap: {
           InstanceId: 'i-1234567890abcdef0', // Instance ID
         },
       }),
       threshold: 80, // CPU utilization threshold
       evaluationPeriods: 2,
       comparisonOperator: cloudwatch.ComparisonOperator.GREATER_THAN_OR_EQUAL_TO_THRESHOLD,
     });

     // Add SNS notification to the alarm
     cpuAlarm.addAlarmAction(new cloudwatch.actions.SnsAction(alarmTopic));
     ```

3. **Recreate Alarm Configurations in CDK**
   - Recreate each existing alarm with the following details:
     - **Metric**: Define the metric (CPU, memory, disk space, etc.) using CDK’s CloudWatch metric constructs.
     - **Threshold**: Set the appropriate threshold for triggering the alarm (e.g., 80% CPU utilization).
     - **Evaluation Periods**: Configure the number of evaluation periods required for the alarm to trigger.
     - **Comparison Operator**: Define the operator for comparison (e.g., greater than, less than).
     - **Actions**: Set up actions for the alarm (e.g., notifying an SNS topic or invoking a Lambda function).

4. **Migrate Notifications to CDK**
   - If notifications (e.g., SNS topics) were manually configured outside CDK, ensure they are also migrated to CDK constructs.
   - For SNS topic configuration, include subscribers (e.g., email, SMS) directly in the CDK configuration.
   - Example CDK code for SNS topic subscription:
     ```typescript
     const snsTopic = new sns.Topic(this, 'SnsTopic');
     snsTopic.addSubscription(new snsSubscriptions.EmailSubscription('youremail@example.com'));
     ```

5. **Test New Alarms in CDK**
   - Deploy the CDK stack to a test environment and verify that all alarms are functioning as expected:
     - Check that each alarm triggers correctly when its conditions are met.
     - Ensure that notifications (e.g., emails or SNS messages) are sent correctly when alarms fire.
   - Test alarm recovery by ensuring that once the monitored metric returns to normal, the alarm resets.

6. **Remove Legacy Alarms**
   - Once the CDK alarms are successfully deployed and verified, remove the old alarms from the legacy systems:
     - Manually delete alarms from the AWS Console.
     - Remove configurations from any CloudFormation or Terraform scripts, if applicable.
   - Ensure that no duplicate alarms remain to avoid unnecessary alerts or conflicts.

7. **Implement Version Control and CI/CD Pipeline**
   - Ensure that the new CDK-based alarms are managed under version control (e.g., Git).
   - Integrate CDK alarm deployment into the existing CI/CD pipeline so that future changes to alarm configurations are automated and tracked.
   - Set up automated deployment of CDK changes via tools like AWS CodePipeline, Jenkins, or GitLab CI/CD.

8. **Monitor and Refine Alarms**
   - Monitor the performance and behavior of the new alarms in production to ensure they meet operational requirements.
   - Refine threshold values, evaluation periods, or notification configurations based on real-world usage and feedback.

### Testing
- Deploy the new CDK-based alarms in a test environment and simulate conditions to trigger the alarms.
- Validate that:
  - Alarms trigger and reset correctly.
  - Notifications are sent to the correct endpoints.
  - Alarms behave consistently with the original configurations.
- Perform load testing to ensure the performance and scalability of the alarms in high-traffic environments.

### Acceptance Criteria
- Should have identified all existing alarms in the previous system.
- Should have successfully recreated all remaining alarms in CDK.
- Should have deployed the CDK alarms to a test environment and validated their functionality.
- Should have removed old alarms from the legacy systems to avoid duplication.
- Should have integrated CDK-based alarms into the version control and CI/CD pipeline.
- Should have tested and monitored alarms for performance and correctness in a production-like environment.
