## Summary
**As a** DevOps engineer or cloud architect, **I want** to **create a secure S3 bucket construct in CDK as an opinionated L2 construct**, **so that** teams can easily deploy S3 buckets with security best practices enforced by default.

An L2 construct in the AWS Cloud Development Kit (CDK) provides a higher-level abstraction that simplifies infrastructure management while enforcing best practices. Creating an opinionated L2 construct for secure S3 buckets ensures that all S3 buckets created with this construct will have secure configurations by default, such as encryption, access logging, and restricted public access, reducing the likelihood of data exposure.

### Vision
By creating a secure, opinionated L2 S3 bucket construct in CDK, the team will have a standardized way to create S3 buckets that comply with security standards automatically. This will simplify development workflows, reduce the need for manual configuration, and improve the security posture of all S3 bucket implementations.

### Background
AWS S3 is a widely used storage service, but misconfigurations can lead to data breaches or unauthorized access. Security best practices for S3 include enabling server-side encryption, blocking public access, configuring access logging, and enforcing versioning. By developing an L2 construct in CDK, we can encapsulate these best practices and make them the default configuration for all S3 buckets created through the construct.

### Purpose
The purpose of this story is to create a reusable, opinionated L2 construct in CDK that provisions secure S3 buckets with recommended security configurations. This construct will encapsulate security settings, making it easier for teams to follow best practices.

## Details

### 1. **Define Security Configurations for the S3 Bucket**
   - The L2 construct should include the following secure configurations by default:
     - **Server-Side Encryption**: Enable server-side encryption with AWS-managed keys (SSE-S3) or customer-managed keys (SSE-KMS).
     - **Block Public Access**: Configure the bucket to block all public access by default.
     - **Access Logging**: Enable access logging for the bucket, with logs stored in a separate bucket.
     - **Versioning**: Turn on versioning to maintain previous versions of objects.
     - **Secure Transport (HTTPS)**: Enforce requests to be made over HTTPS only.
     - **Default Bucket Policy**: Apply a default policy that restricts access to specific IAM roles or users if needed.

   **Example Secure Configuration Parameters**:
   - **Encryption Type**: `SSE-S3` (default) or `SSE-KMS` if a KMS key is provided.
   - **Block Public Access Settings**: Enabled for all public access types.
   - **Access Logging Bucket**: Specify a separate S3 bucket for access logs.

### 2. **Develop the CDK L2 Construct**
   - Implement the L2 construct using TypeScript, Python, or Java for AWS CDK.
   - The construct should extend the base `s3.Bucket` class and apply the specified secure configurations.
   - Provide default settings, but allow parameters for overriding (e.g., custom KMS key, logging bucket).
   - Include sensible defaults, such as creating a logging bucket automatically if none is specified.

   **Example Code for TypeScript CDK Implementation**:
   ```typescript
   import * as s3 from 'aws-cdk-lib/aws-s3';
   import * as cdk from 'aws-cdk-lib';
   import { Construct } from 'constructs';

   export interface SecureBucketProps extends s3.BucketProps {
       readonly enableSseKms?: boolean;
       readonly kmsKeyArn?: string;
   }

   export class SecureBucket extends s3.Bucket {
       constructor(scope: Construct, id: string, props?: SecureBucketProps) {
           super(scope, id, {
               ...props,
               versioned: true,
               encryption: props?.enableSseKms ? s3.BucketEncryption.KMS : s3.BucketEncryption.S3_MANAGED,
               encryptionKey: props?.enableSseKms && props?.kmsKeyArn ? cdk.aws_kms.Key.fromKeyArn(scope, 'KmsKey', props.kmsKeyArn) : undefined,
               blockPublicAccess: s3.BlockPublicAccess.BLOCK_ALL,
               enforceSSL: true,
           });

           // Enable access logging
           if (!props?.serverAccessLogsBucket) {
               const logBucket = new s3.Bucket(this, 'AccessLogsBucket', {
                   encryption: s3.BucketEncryption.S3_MANAGED,
                   blockPublicAccess: s3.BlockPublicAccess.BLOCK_ALL,
               });
               this.addLifecycleRule({ enabled: true, expiration: cdk.Duration.days(90) });
               this.addServerAccessLogs(logBucket);
           }
       }
   }
   ```

### 3. **Provide Options for Overriding Default Configurations**
   - Allow customization of certain secure configurations to meet different project requirements:
     - **Custom KMS Key**: If `enableSseKms` is true, provide an option to specify a custom KMS key.
     - **Access Logging Options**: Allow the user to specify an existing logging bucket.
     - **Bucket Policy Customization**: Provide a method for adding custom bucket policies if needed.

### 4. **Add Documentation and Examples**
   - Document the usage of the L2 construct, including the default configurations and how to customize them.
   - Provide code examples for using the construct with different configuration options.
   - Explain the security benefits of each configuration and how they protect data stored in the S3 bucket.

   **Example Documentation Section**:
   - **Usage Example**:
   ```typescript
   const secureBucket = new SecureBucket(this, 'MySecureBucket', {
       enableSseKms: true,
       kmsKeyArn: 'arn:aws:kms:region:account-id:key/key-id',
   });
   ```

   - **Customization Options**:
     - **enableSseKms**: Set to `true` to use server-side encryption with a KMS key.
     - **loggingBucket**: Specify an existing bucket to use for access logs.

### 5. **Test the L2 Construct**
   - Write unit and integration tests to ensure that the construct applies all secure configurations correctly.
   - Test different configurations (e.g., using default settings, custom KMS key).
   - Verify that the resulting S3 bucket adheres to security best practices.

   **Example Testing Approach**:
   - **Test 1**: Verify that an S3 bucket created with the default construct settings is encrypted, blocks public access, and has versioning enabled.
   - **Test 2**: Verify that providing a custom KMS key results in KMS encryption being applied to the bucket.
   - **Test 3**: Ensure that access logging is enabled and properly configured.

### 6. **Update the Runbook with Usage Guidelines**
   - Document how to use the L2 construct in the team's runbook.
   - Provide best practices for using the construct in various environments (e.g., development, staging, production).
   - Include troubleshooting tips for common issues (e.g., permissions errors with KMS keys).

   **Runbook Sections to Update**:
   - **Creating Secure S3 Buckets**: Instructions for using the SecureBucket construct.
   - **Customizing Security Settings**: Guide to modifying the default configurations.

### Testing
- Validate that all security configurations (encryption, public access blocking, logging) are applied correctly.
- Verify that custom configurations (e.g., KMS key usage, custom logging buckets) function as expected.
- Conduct a code review to ensure best practices are followed in the construct's implementation.

### Acceptance Criteria
- Should implement an L2 construct that creates S3 buckets with security best practices enabled by default.
- Should support customizations for key settings such as encryption type, logging configuration, and bucket policies.
- Should provide comprehensive documentation and examples for using the construct.
- Should include tests that validate the security configurations and customization options.
- Should update the runbook with usage guidelines and troubleshooting tips.

### External Links
- [AWS S3 Security Best Practices](https://docs.aws.amazon.com/AmazonS3/latest/userguide/security-best-practices.html)
- [AWS CDK Documentation](https://docs.aws.amazon.com/cdk/latest/guide/home.html)
- [KMS Encryption with S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingKMSEncryption.html)
