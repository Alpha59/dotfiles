## Summary
**As a** DevOps engineer or cloud architect, **I want** to **enable backups for worst-case scenarios such as DynamoDB (DDB) data loss or Elasticsearch cluster failure**, **so that** critical data can be recovered and restored quickly, minimizing downtime and ensuring business continuity.

Enabling regular backups for key services like DynamoDB and Elasticsearch protects against data loss due to system failures, accidental deletions, or other unforeseen issues. These backups provide a safeguard to restore data to a known good state, ensuring the resilience of the system in case of catastrophic events.

### Vision
By implementing automated backup strategies for DynamoDB and Elasticsearch, the team will be prepared to recover quickly from severe data loss scenarios. The backups will be configured to capture regular snapshots of data and maintain retention policies that balance data recovery needs with storage costs.

### Background
In distributed systems, data loss can occur due to various factors, including hardware failures, software bugs, or human error. Services such as DynamoDB and Elasticsearch do not automatically provide comprehensive backup solutions, making it necessary to configure and manage backup policies. Regular backups and tested restoration procedures are essential for disaster recovery planning.

### Purpose
The purpose of this story is to set up automated backups for DynamoDB and Elasticsearch, ensuring that data can be restored in worst-case scenarios such as data corruption, accidental deletion, or complete service failure.

## Details

### 1. **Enable DynamoDB Backups**
   - Use **AWS DynamoDB On-Demand Backup** to take snapshots of the database at regular intervals.
   - Enable **Point-In-Time Recovery (PITR)** for DynamoDB tables to allow recovery to any point within the last 35 days.
   - Configure automated backups to run on a daily or weekly schedule, depending on data criticality.

   **Example Configuration for Enabling PITR Using AWS CLI**:
   ```bash
   aws dynamodb update-continuous-backups --table-name MyDDBTable \
       --point-in-time-recovery-specification PointInTimeRecoveryEnabled=true
   ```

   **AWS CDK Configuration for On-Demand Backups**:
   ```typescript
   import * as cdk from 'aws-cdk-lib';
   import * as dynamodb from 'aws-cdk-lib/aws-dynamodb';

   const table = new dynamodb.Table(this, 'MyDDBTable', {
       partitionKey: { name: 'ID', type: dynamodb.AttributeType.STRING },
       billingMode: dynamodb.BillingMode.PAY_PER_REQUEST,
       pointInTimeRecovery: true, // Enable PITR
   });

   // Configure a backup plan
   new dynamodb.CfnBackup(this, 'MyDDBBackup', {
       tableName: table.tableName,
       backupName: 'MyDDBTableBackup',
   });
   ```

   **Retention Policy**:
   - Keep daily backups for the past 7 days.
   - Retain weekly backups for 4 weeks.
   - Retain monthly backups for 6 months.

### 2. **Enable Elasticsearch Snapshots**
   - Use **Amazon Elasticsearch Service (now OpenSearch Service)** to schedule automated snapshots of the cluster.
   - Configure daily snapshots to a secure S3 bucket to enable cluster restoration in case of failure.
   - Use **IAM policies** to grant the Elasticsearch service access to the specified S3 bucket.

   **Example Configuration for Enabling Snapshots**:
   - Create an S3 bucket for snapshots (e.g., `my-elasticsearch-snapshots`).
   - Configure an IAM role for Elasticsearch to access the S3 bucket.

   **IAM Policy for Elasticsearch S3 Access**:
   ```json
   {
       "Version": "2012-10-17",
       "Statement": [
           {
               "Effect": "Allow",
               "Action": [
                   "s3:PutObject",
                   "s3:GetObject",
                   "s3:DeleteObject",
                   "s3:ListBucket"
               ],
               "Resource": [
                   "arn:aws:s3:::my-elasticsearch-snapshots",
                   "arn:aws:s3:::my-elasticsearch-snapshots/*"
               ]
           }
       ]
   }
   ```

   **Enable Daily Snapshots Using OpenSearch Configuration**:
   - Use the OpenSearch **snapshot API** to register the repository and schedule the snapshots.
   ```bash
   curl -X PUT "https://your-domain-endpoint/_snapshot/my_backup_repo" -H 'Content-Type: application/json' -d'
   {
       "type": "s3",
       "settings": {
           "bucket": "my-elasticsearch-snapshots",
           "region": "us-west-2",
           "role_arn": "arn:aws:iam::123456789012:role/MyElasticsearchSnapshotRole"
       }
   }'
   ```

### 3. **Automate the Backup Process Using AWS Backup**
   - Use **AWS Backup** to manage and automate backup schedules for both DynamoDB and Elasticsearch.
   - Create a **backup plan** in AWS Backup that specifies the backup schedule, retention rules, and resources to be backed up.
   - Enable cross-region and cross-account backup replication if needed to improve disaster recovery options.

   **Example AWS Backup Plan Using the Console or AWS CLI**:
   ```bash
   aws
