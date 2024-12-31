## Summary
**As a** DevOps engineer or cloud architect, **I want** to **set appropriate service limits for AWS system accounts and CLI access**, **so that** accidental actions do not overload systems or exceed resource thresholds, protecting the infrastructure from unintended disruptions.

Service limits and account restrictions help prevent excessive resource consumption, costly mistakes, and potential service outages caused by unintentional configuration changes or user actions. By setting appropriate service limits, the team can control the maximum allowed usage for various services and reduce the risk of accidental overloads or runaway processes.

### Vision
By configuring service limits and access controls, the team will implement safeguards that prevent excessive resource usage, limit potential impacts of human errors, and protect against unintended service disruptions. This will improve system reliability and cost management across AWS accounts.

### Background
AWS provides various service limits (also known as quotas) to control the maximum usage of resources, such as EC2 instances, Lambda executions, or S3 bucket requests. Additionally, permissions and policies for CLI access can be configured to limit users' ability to perform actions that could inadvertently cause issues. Setting service limits and access controls helps ensure that resources are used within safe and acceptable boundaries.

### Purpose
The purpose of this story is to set appropriate service limits for AWS system accounts and CLI access, preventing accidental actions from overloading systems and ensuring the infrastructure remains stable.

## Details

### 1. **Identify Critical AWS Services and Appropriate Limits**
   - Review the usage patterns and resource requirements for critical AWS services in the system, such as:
     - **EC2 Instances**: Limits on the number of instances or instance types.
     - **Lambda Functions**: Limits on concurrent executions and memory allocation.
     - **S3 Buckets**: Limits on the number of requests per second.
     - **DynamoDB**: Limits on read/write capacity units.
   - Determine suitable limits based on historical usage data, current resource requirements, and anticipated growth.

   **Example Limits to Configure**:
   - **EC2 Instances**: Limit to 50 instances of a specific type per region.
   - **Lambda Concurrent Executions**: Set to a maximum of 1,000 to avoid excessive scaling.
   - **S3 PUT Requests per Second**: Limit to 2,000 requests to prevent overloading.
   - **DynamoDB Read/Write Capacity**: Limit to 10,000 read units and 5,000 write units.

### 2. **Configure Service Quotas Using AWS Service Quotas Console**
   - Use the **AWS Service Quotas** console to set and manage limits for various services.
   - Review default quotas for each service and increase or decrease limits based on the team's needs.
   - Submit requests for limit increases where necessary, while keeping non-essential limits low to avoid accidental over-provisioning.

   **Example AWS CLI Command to List Service Quotas**:
   ```bash
   aws service-quotas list-service-quotas --service-code ec2
   ```

### 3. **Set IAM Policies to Restrict CLI Access and Permissions**
   - Create **IAM policies** that restrict actions and resource usage based on user roles, ensuring that only authorized personnel can perform high-impact actions.
   - Apply **least privilege principles** to grant users only the permissions they need to perform their jobs.
   - Implement **resource-based policies** to limit actions on specific resources (e.g., specific S3 buckets or EC2 instances).

   **Example IAM Policy to Limit EC2 Instance Launching**:
   ```json
   {
       "Version": "2012-10-17",
       "Statement": [
           {
               "Effect": "Allow",
               "Action": "ec2:RunInstances",
               "Resource": "*",
               "Condition": {
                   "NumericLessThanEquals": {
                       "ec2:InstanceCount": "10"
                   }
               }
           }
       ]
   }
   ```

### 4. **Configure Alerts for Approaching Service Limits**
   - Set up monitoring and alerts for when resource usage approaches set limits. Use tools like **CloudWatch**, **Datadog**, or **Prometheus**.
   - Configure **CloudWatch Alarms** to notify the team when usage reaches a predefined threshold (e.g., 80% of the service limit).
   - Use **SNS (Simple Notification Service)** to send alerts to designated channels (e.g., Slack, email).

   **Example CloudWatch Alarm Setup for EC2 Limit**:
   ```bash
   aws cloudwatch put-metric-alarm --alarm-name "EC2InstanceLimitWarning" \
       --metric-name "RunningInstances" --namespace "AWS/EC2" \
       --statistic "Sum" --period 300 --threshold 40 \
       --comparison-operator "GreaterThanThreshold" --dimensions Name=InstanceType,Value=t2.micro \
       --evaluation-periods 1 --alarm-actions <SNS-topic-arn>
   ```

### 5. **Implement Throttling and Rate Limiting**
   - Use **AWS API Gateway**, **Lambda**, or **S3** throttling configurations to enforce rate limits for incoming requests.
   - Implement **rate limiting** in applications to prevent rapid resource consumption due to automated processes or high traffic spikes.
   - For **Lambda functions**, configure **concurrency limits** to avoid overwhelming dependent services.

   **Example API Gateway Throttling Configuration**:
   - **Burst Limit**: 1,000 requests per second.
   - **Rate Limit**: 500 requests per second sustained.

### 6. **Periodically Review and Adjust Service Limits**
   - Regularly review service limits and IAM policies to ensure they continue to meet operational requirements without being overly restrictive.
   - Update limits as usage patterns change, new services are introduced, or significant infrastructure changes occur.

   **Steps for Periodic Review**:
   - **Quarterly Review**: Assess service limits and adjust thresholds based on recent usage data.
   - **Post-Incident Review**: Reevaluate limits if incidents are caused by reaching service quotas.
   - **Change Management Process**: Include service limit adjustments as part of major deployments.

### 7. **Document the Service Limit and IAM Policy Configuration**
   - Update the team's **runbook** to include details on service limits, IAM policies, and alert configurations.
   - Provide instructions on how to adjust service limits and set up alerts.
   - Document the process for requesting service quota increases and the associated approval workflow.

   **Runbook Sections to Update**:
   - **Service Limit Configurations**: Outline the current limits for critical services.
   - **IAM Policy Restrictions**: List policies used to control resource access and CLI permissions.
   - **Alerting Setup**: Provide details on how to configure and manage alerts for approaching limits.

### Testing
- Verify that service limits are enforced by attempting to exceed configured quotas.
- Test IAM policies by performing restricted actions to confirm that permissions are applied correctly.
- Simulate alerts by manually increasing resource usage to trigger notifications.

### Acceptance Criteria
- Should set appropriate service limits for critical AWS resources, including EC2, Lambda, S3, and DynamoDB.
- Should restrict CLI access and permissions through IAM policies following least privilege principles.
- Should configure alerts for when resource usage approaches service limits, with notifications sent to the relevant channels.
- Should implement rate limiting and throttling to prevent overloading systems.
- Should document the service limits, IAM policies, and alert configurations in the team runbook.
- Should periodically review and adjust service limits based on usage patterns and requirements.

### External Links
- [AWS Service Quotas Documentation](https://docs.aws.amazon.com/servicequotas/latest/userguide/what-is-service-quotas.html)
- [IAM Best Practices for Permissions](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
- [CloudWatch Alarms for Monitoring Service Limits](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html)
