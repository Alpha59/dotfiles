## Summary
**As a** DevOps or security engineer, **I want** to configure **Amazon Simple Queue Service (SQS)** to allow cross-account access only for trusted accounts, **so that** I can control which external AWS accounts can interact with my SQS queues, ensuring that only authorized accounts have access, improving security, and preventing unauthorized access to the system.

Configuring SQS with fine-grained permissions ensures that only trusted AWS accounts can read from or write to your SQS queues, which is critical for maintaining the integrity and security of your messaging system, especially in multi-account environments.

### Vision
By restricting cross-account access to SQS queues, the team can ensure that only trusted accounts have permission to interact with the queues. This will reduce the risk of unauthorized access, data leakage, and potential abuse, while still allowing collaboration between specific accounts within the organization or with approved external accounts.

### Background
SQS queues can be accessed across accounts, but allowing unrestricted cross-account access can expose the service to potential security risks. Therefore, it’s essential to configure the appropriate policies that allow access only from trusted AWS accounts. This ensures that only authorized accounts can perform actions such as sending or receiving messages, while preventing unauthorized accounts from interacting with your queues.

### Purpose
The purpose of this story is to configure SQS queue policies that allow cross-account access only for trusted AWS accounts. The solution should also include monitoring and auditing of access to ensure that the configuration remains secure and functional.

## Details

### 1. **Identify Trusted AWS Accounts**
   - **Trusted Accounts**:
     - Identify the specific AWS accounts that need access to the SQS queue. This may include other accounts within the same organization or external accounts with a valid use case for accessing the queue.
     - Example trusted accounts:
       - **Account A** (internal services account): `123456789012`
       - **Account B** (external partner): `098765432109`

### 2. **Configure SQS Queue Policy**
   - **SQS Queue Policy**:
     - Use an SQS queue policy to explicitly allow access only to trusted accounts. The policy defines which actions can be performed (e.g., `SendMessage`, `ReceiveMessage`, `DeleteMessage`, `PurgeQueue`) and which accounts are permitted to perform these actions.

   - **Queue Policy Example**:
     - The following is an example SQS policy allowing access for two trusted accounts (`123456789012` and `098765432109`) to send and receive messages. Other accounts are denied access by default.
       ```json
       {
         "Version": "2012-10-17",
         "Id": "SQSQueuePolicy",
         "Statement": [
           {
             "Effect": "Allow",
             "Principal": {
               "AWS": [
                 "arn:aws:iam::123456789012:root",
                 "arn:aws:iam::098765432109:root"
               ]
             },
             "Action": [
               "sqs:SendMessage",
               "sqs:ReceiveMessage",
               "sqs:DeleteMessage",
               "sqs:GetQueueAttributes",
               "sqs:GetQueueUrl"
             ],
             "Resource": "arn:aws:sqs:us-east-1:111122223333:my-queue",
             "Condition": {
               "StringEquals": {
                 "aws:SourceAccount": "111122223333"
               }
             }
           }
         ]
       }
       ```
     - **Explanation**:
       - **Principal**: Specifies the AWS accounts (`123456789012`, `098765432109`) that are allowed access.
       - **Action**: Lists the SQS actions these accounts are allowed to perform (`SendMessage`, `ReceiveMessage`, etc.).
       - **Resource**: Specifies the ARN of the SQS queue (`my-queue`) to which the policy applies.
       - **Condition**: Ensures that only requests originating from the same AWS account (`111122223333`) are allowed.

### 3. **IAM Role Configuration for Trusted Accounts**
   - **IAM Role or User Permissions**:
     - In the trusted AWS accounts, configure IAM roles or users with the appropriate permissions to interact with the SQS queue. The roles/users in the trusted accounts need permissions to invoke the SQS actions allowed in the SQS queue policy.
     - Example IAM policy for a trusted account:
       ```json
       {
         "Version": "2012-10-17",
         "Statement": [
           {
             "Effect": "Allow",
             "Action": [
               "sqs:SendMessage",
               "sqs:ReceiveMessage",
               "sqs:DeleteMessage"
             ],
             "Resource": "arn:aws:sqs:us-east-1:111122223333:my-queue"
           }
         ]
       }
       ```

   - **Role or User Creation**:
     - In the trusted account, create an IAM role or user with the above policy attached. This will allow the trusted account to interact with the SQS queue.

### 4. **Monitor and Audit SQS Access**
   - **CloudTrail Logs**:
     - Use AWS CloudTrail to monitor and log all SQS access. CloudTrail can be configured to capture all API calls made to SQS, including `SendMessage`, `ReceiveMessage`, and `DeleteMessage` operations. This ensures that all interactions with the SQS queue can be audited and reviewed.
     - Example: Review CloudTrail logs to ensure that only the trusted accounts are accessing the queue.

   - **CloudWatch Alarms**:
     - Set up CloudWatch alarms to trigger notifications when unusual access patterns or unauthorized access attempts are detected. For example, trigger an alarm if an untrusted account attempts to access the queue.
     - Example CloudWatch alarm setup:
       - Set an alarm on `sqs:SendMessage` or `sqs:ReceiveMessage` actions performed by an unrecognized AWS account.

   - **SQS Metrics**:
     - Monitor SQS metrics such as the number of messages sent/received and any error metrics (e.g., `AccessDenied`) to identify potential issues or unauthorized access attempts.

### 5. **Test Cross-Account Access**
   - **Simulate Access from Trusted Accounts**:
     - Test access from each trusted AWS account to ensure that they can successfully send and receive messages from the SQS queue.
     - Example: Use the AWS CLI from the trusted account to send a message:
       ```bash
       aws sqs send-message --queue-url https://sqs.us-east-1.amazonaws.com/111122223333/my-queue \
       --message-body "Test Message from Trusted Account"
       ```

   - **Simulate Access from Untrusted Accounts**:
     - Test access from an untrusted AWS account to ensure that access is denied as expected. This helps validate that the security controls are working properly.
     - Example: Attempt to send a message from an untrusted account and verify that access is denied:
       ```bash
       aws sqs send-message --queue-url https://sqs.us-east-1.amazonaws.com/111122223333/my-queue \
       --message-body "Unauthorized message"
       ```
     - Expected result: Access is denied with an error message like `AccessDenied`.

### Testing
- **Cross-Account Access Test**:
   - Ensure that trusted accounts can access the SQS queue and perform allowed actions (e.g., `SendMessage`, `ReceiveMessage`), while untrusted accounts are denied access.

- **CloudWatch and CloudTrail Monitoring Test**:
   - Confirm that all SQS access is logged in CloudTrail and that alerts are triggered if unauthorized access is attempted.

### External Dependencies
- **CloudTrail** for auditing SQS access.
- **IAM roles/policies** for granting the required permissions to trusted accounts.
- **CloudWatch** for monitoring and alerting on SQS usage.

## Acceptance Criteria
- Should allow cross-account access to SQS only for trusted accounts using the defined SQS policy.
- Should monitor and audit all access to the SQS queue using CloudTrail and CloudWatch.
- Should trigger alerts if unauthorized access is attempted.

### Gherkin
```gherkin
Given an SQS queue with a policy restricting cross-account access
When a trusted account sends or receives a message from the queue
Then the request should succeed
And the request should be logged in CloudTrail.
```
```gherkin
Given an untrusted account attempts to access the SQS queue
When they try to send or receive a message
Then the request should be denied
And an alert should be triggered for unauthorized access.
```
