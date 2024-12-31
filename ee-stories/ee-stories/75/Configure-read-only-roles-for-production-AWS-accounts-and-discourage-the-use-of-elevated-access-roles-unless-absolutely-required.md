## Summary
**As a** security engineer or AWS administrator, **I want** to configure **read-only roles for production AWS accounts** and discourage the use of **elevated access roles** unless absolutely required, **so that** the risk of unintended or malicious changes to production environments is minimized, and security and governance are maintained.

Restricting elevated access roles ensures that critical resources in production environments are protected from accidental changes and reduces the attack surface in the event of compromised credentials. Granting read-only access allows team members to monitor and debug issues without risking the integrity of the production environment.

### Vision
By configuring read-only roles for production AWS accounts, we can ensure that only authorized users with minimal privileges can access the production environment for monitoring and troubleshooting. Elevated roles with write or administrative permissions should be granted on a case-by-case basis, reducing the likelihood of security incidents and maintaining a more secure and controlled environment.

### Background
Allowing unrestricted or elevated access to production environments increases the risk of accidental or malicious changes to critical infrastructure. Best practices recommend the use of **least privilege access**, where users only have the necessary permissions to perform their job. In most cases, read-only access is sufficient for monitoring and troubleshooting purposes, while elevated roles should be used only when absolutely necessary and tracked.

### Purpose
The purpose of this story is to configure read-only roles for users accessing production AWS accounts, ensuring that elevated access is discouraged and only granted when required. This practice will help minimize security risks and promote the principle of least privilege access.

## Details

### 1. **Create and Assign Read-Only Roles**

#### a. **AWS Managed Policy for Read-Only Access**
   - AWS provides a managed policy called `ReadOnlyAccess`, which grants read-only permissions to most AWS services. This can be applied to IAM roles for users accessing the production environment.

   **Example of Attaching the Managed Read-Only Policy**:
   ```bash
   aws iam create-role --role-name ReadOnlyProductionRole \
     --assume-role-policy-document file://trust-policy.json

   aws iam attach-role-policy --role-name ReadOnlyProductionRole \
     --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess
   ```

#### b. **Custom Read-Only Policy for Specific Resources**
   - If tighter controls are needed, create custom policies that provide read-only access to specific services or resources within the production environment.

   **Example Custom Policy for Read-Only S3 Access**:
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": [
           "s3:GetObject",
           "s3:ListBucket"
         ],
         "Resource": [
           "arn:aws:s3:::my-production-bucket",
           "arn:aws:s3:::my-production-bucket/*"
         ]
       }
     ]
   }
   ```

   - Attach this custom policy to the required IAM roles or users accessing specific AWS resources in production.

### 2. **Configure Elevated Access Roles for Production**

#### a. **Create Roles with Write Access Only When Necessary**
   - For users or processes that require write access to production resources (e.g., making changes to infrastructure or deploying updates), create separate roles with more restrictive policies.
   - These roles should be assumed temporarily and monitored closely.

   **Example: Creating an Elevated Access Role for EC2 Changes**:
   ```bash
   aws iam create-role --role-name EC2ElevatedAccessRole \
     --assume-role-policy-document file://trust-policy.json

   aws iam attach-role-policy --role-name EC2ElevatedAccessRole \
     --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess
   ```

#### b. **Use MFA and Approval Workflows for Elevated Access**
   - Enforce **Multi-Factor Authentication (MFA)** for roles with elevated access. This provides an extra layer of security, requiring users to authenticate with a second factor before assuming the elevated role.
   - Implement approval workflows using AWS **IAM Access Analyzer**, **AWS Identity Center**, or custom tools to ensure elevated roles are only used when necessary.

   **Example of Enforcing MFA for an IAM Role**:
   ```json
   {
     "Version": "2012-10-17",
     "Statement": {
       "Effect": "Deny",
       "Action": "*",
       "Resource": "*",
       "Condition": {
         "BoolIfExists": {
           "aws:MultiFactorAuthPresent": "false"
         }
       }
     }
   }
   ```

### 3. **Audit and Monitor Role Usage**

#### a. **Enable CloudTrail for Monitoring Role Assumption**
   - Enable **AWS CloudTrail** in the production account to track the use of elevated access roles and monitor all actions performed in the environment.
   - Set up alerts in **CloudWatch** or **Datadog** to notify the team when elevated roles are assumed or when specific high-risk actions are performed.

   **Example: Monitoring Role Assumption with CloudWatch Events**:
   ```bash
   aws events put-rule --name "MonitorElevatedAccess" \
     --event-pattern '{
       "source": ["aws.iam"],
       "detail-type": ["AWS API Call via CloudTrail"],
       "detail": {
         "eventName": ["AssumeRole"],
         "requestParameters": {
           "roleArn": ["arn:aws:iam::account-id:role/EC2ElevatedAccessRole"]
         }
       }
     }'
   ```

#### b. **Audit IAM Roles Regularly**
   - Use AWS **IAM Access Analyzer** or **AWS Config** to audit the use of IAM roles and verify that permissions align with the principle of least privilege.
   - Regularly review logs to identify any unauthorized or unnecessary use of elevated roles in production.

### 4. **Enforce Principle of Least Privilege**
   - Ensure that roles and policies are designed to provide only the necessary permissions for each specific task.
   - Regularly review and update role policies to remove unnecessary permissions.

   **Example Best Practice**:
   - Use **service-specific roles** to grant the minimum required access (e.g., a role for read-only access to DynamoDB, a separate role for deploying updates to EC2, etc.).

### 5. **Documentation and Communication**
   - Document the policy around the use of read-only and elevated access roles, explaining when and how elevated roles should be used and the approval process involved.
   - Communicate this policy clearly to all team members to ensure compliance and understanding of security best practices.

### Testing
- Test the read-only roles by assigning them to users and verifying that they can access resources without modifying them.
- Test elevated roles by enforcing MFA and approval workflows, ensuring that only authorized users can assume the role and perform actions.
- Simulate alerts and monitoring for role assumption using CloudTrail and CloudWatch to verify that notifications are sent when elevated roles are used.

## Acceptance Criteria
- Should configure and assign read-only roles with limited access to AWS production resources.
- Should configure elevated access roles with necessary permissions and enforce MFA and approval workflows.
- Should monitor and log the use of elevated roles and set up alerts for unauthorized or suspicious activity.
- Should document and communicate the use of roles, ensuring compliance with least privilege principles.

### External Links
- [AWS IAM Access Analyzer](https://aws.amazon.com/iam/access-analyzer/)
- [AWS CloudTrail Documentation](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-user-guide.html)
- [AWS Managed Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-vs-inline.html)
