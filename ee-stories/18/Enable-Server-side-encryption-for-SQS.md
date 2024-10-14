
# Enable Server-side encryption for SQS
### Summary
**As a** Security Engineer, **I want** to enable server-side encryption (SSE) for  Simple Queue Service (SQS) queues, **So That** we can ensure that sensitive data transmitted through the SQS queues is protected and complies with security and regulatory requirements.

This story focuses on enabling and configuring server-side encryption for SQS queues using AWS Key Management Service (KMS). By encrypting messages at rest, we safeguard sensitive information and reduce the risk of unauthorized access or data breaches.

### Vision
Enabling server-side encryption for SQS queues ensures that any data sent through the queue is encrypted at rest, protecting it from unauthorized access. By leveraging AWS KMS, we can manage encryption keys securely and control access to encrypted data, ensuring compliance with security best practices and regulatory requirements.

### Background
Currently, SQS queues may not have encryption enabled, which could expose sensitive data if accessed improperly. Server-side encryption helps mitigate this risk by ensuring that all data stored in the queue is encrypted automatically. Enabling SSE also aligns with security standards and compliance requirements for handling sensitive information.

### Purpose
The purpose of this story is to enable server-side encryption (SSE) for SQS queues using AWS KMS, ensuring that all messages stored in the queue are encrypted at rest. This initiative aims to protect sensitive data, meet compliance requirements, and strengthen the overall security of the system.

## Details
1. **Identify the SQS Queues for Encryption**:
    - Review the existing SQS queues in the AWS environment and identify the queues that handle sensitive data or require encryption to comply with security policies.
    - Prioritize high-importance queues where encryption is essential due to regulatory requirements or data sensitivity.

2. **Choose a KMS Key for Encryption**:
    - Choose the appropriate AWS Key Management Service (KMS) key to use for encryption. You can:
      - Use an **AWS-managed KMS key** (default option) for simplicity.
      - Create and use a **customer-managed KMS key** if you require more control over the key, such as setting key rotation policies or access control.
    - Ensure that the KMS key has the necessary permissions to encrypt and decrypt messages for the SQS queue.

3. **Enable Server-Side Encryption (SSE) on SQS Queues**:
    - For each identified SQS queue, enable server-side encryption. This can be done using the AWS Management Console, AWS CLI, or Infrastructure as Code tools such as AWS CloudFormation or Terraform.
    - **AWS Console**:
      - Navigate to the **SQS dashboard**.
      - Select the SQS queue that needs encryption.
      - Under **Queue Actions**, choose **Edit**.
      - In the **Encryption** section, select **Enable server-side encryption**.
      - Select the **KMS key** to use for encryption (either AWS-managed or customer-managed).
      - Save the changes.
    - **AWS CLI**:
      Use the `set-queue-attributes` command to enable SSE for the queue:
      ```bash
      aws sqs set-queue-attributes       --queue-url https://sqs.<region>.amazonaws.com/<account_id>/<queue_name>       --attributes '{'KmsMasterKeyId': 'arn:aws:kms:<region>:<account_id>:key/<key_id>'}'
      ```

4. **Configure Key Policies and Permissions**:
    - Ensure that the KMS key policies are properly configured to allow access to the necessary AWS Identity and Access Management (IAM) roles or users that interact with the SQS queue.
    - Update IAM policies to grant permissions for `kms:Encrypt`, `kms:Decrypt`, `kms:GenerateDataKey`, and other necessary actions related to the KMS key.

5. **Test the SQS Queue Encryption**:
    - Test the SQS queue by sending a sample message to the encrypted queue and verifying that encryption is functioning correctly.
    - Use AWS CloudWatch or AWS KMS logs to verify that encryption operations are being performed successfully.
    - Confirm that the appropriate KMS key is being used to encrypt the data.

6. **Monitor and Audit Encryption Activity**:
    - Set up monitoring and auditing for the KMS key usage and SQS queue activity. Use CloudWatch Logs, AWS CloudTrail, and AWS KMS logs to track key usage and ensure that encryption is functioning as expected.
    - Monitor any unauthorized attempts to access encrypted data, and ensure that the KMS key is being used in accordance with security policies.

7. **Document the Encryption Setup**:
    - Document the encryption setup for the SQS queues, including details of the KMS key used, the permissions required, and the process for enabling encryption.
    - Ensure that team members are aware of how to enable encryption for new SQS queues in the future, and provide guidelines for managing KMS keys and monitoring encryption.

### Testing
- Test the encryption of messages by sending sample data to the encrypted SQS queue and verifying that encryption occurs by checking KMS usage logs.
- Test the decryption of messages to ensure that authorized users and services can still access the data.
- Ensure that IAM roles and policies are configured correctly by verifying that only authorized users can send and receive messages from the encrypted queue.
- Monitor AWS CloudTrail logs to ensure that all encryption and decryption actions are logged and that no unauthorized access attempts are recorded.

### External Dependencies
- Access to AWS KMS to manage encryption keys and configure key policies for encryption.
- Collaboration with the security team to define key management policies, access control, and monitoring for KMS keys.
- Integration with monitoring tools such as AWS CloudWatch and CloudTrail to track encryption activity and key usage.

## Acceptance Criteria
- Should have enabled server-side encryption for all identified SQS queues using the appropriate AWS KMS key.
- Should have configured the necessary KMS key policies and IAM permissions to ensure secure access to encrypted data.
- Should have tested the encryption by sending and receiving messages from the encrypted queue and verifying that encryption is functioning as expected.
- Should have set up monitoring and auditing for KMS key usage and SQS queue activity, ensuring that encryption is tracked and unauthorized access is prevented.
- Should have documented the encryption setup and provided guidelines for managing encryption for future SQS queues.

### Gherkin
#### Scenario: Enabling Server-Side Encryption on SQS Queue
Given an SQS queue that requires encryption,
When server-side encryption is enabled,
Then all messages sent to the queue should be encrypted using the specified KMS key.

#### Scenario: Testing Encrypted SQS Queue
Given the server-side encryption is enabled for an SQS queue,
When a message is sent to the queue,
Then the message should be encrypted, and the encryption activity should be logged in AWS KMS logs.

#### Scenario: Verifying Permissions for Encrypted SQS Queue
Given that encryption is enabled for an SQS queue,
When an unauthorized user tries to access the queue,
Then access should be denied, and the attempt should be logged for review.

## API
N/A

## External Links
- [AWS SQS Server-Side Encryption Documentation](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-server-side-encryption.html)
- [AWS KMS Key Management](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html)
