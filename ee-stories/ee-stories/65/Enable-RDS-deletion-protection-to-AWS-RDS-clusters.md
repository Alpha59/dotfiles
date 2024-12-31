## Summary
**As a** DevOps engineer or database administrator, **I want** to enable **RDS Deletion Protection** for AWS RDS clusters, **so that** accidental deletion of critical database instances is prevented, ensuring data availability and minimizing the risk of unintentional loss of databases in production environments.

RDS Deletion Protection is a feature that prevents the accidental deletion of an RDS instance or cluster. When enabled, this feature ensures that an additional confirmation step is required before an RDS cluster or instance can be deleted. This is particularly important for production environments where unintended deletion could cause significant data loss and downtime.

### Vision
By enabling RDS Deletion Protection, we safeguard critical RDS clusters and databases from accidental deletions, ensuring database availability and reducing the risk of human error. This adds a protective layer in production environments where deletion can have severe consequences.

### Background
In AWS, it's possible to delete an RDS instance or cluster through the console, CLI, or API. However, if Deletion Protection is enabled, the system will not allow deletion unless the protection is first disabled. This is a crucial feature for production databases that should not be deleted under normal operational circumstances.

### Purpose
The purpose of this story is to enable Deletion Protection for AWS RDS clusters, ensuring that accidental deletion of critical databases is prevented and that the process to delete any RDS cluster or instance requires additional steps to disable protection first.

## Details

### 1. **Identify the RDS Clusters for Deletion Protection**
   - **Select Production and Critical Databases**:
     - Identify all RDS clusters and instances that are critical for your organization (e.g., production databases, business-critical databases). Deletion Protection should be enabled for these instances to prevent accidental deletion.

   **Example**:
   - RDS Cluster: `prod-cluster`
   - RDS Instance: `prod-db-instance-1`

### 2. **Enable Deletion Protection via AWS Console**

   - **Step 1**: **Open the AWS RDS Console**
     - Go to the **AWS Management Console** and navigate to **Amazon RDS**.

   - **Step 2**: **Select the RDS Cluster or Instance**
     - In the RDS Dashboard, select the RDS cluster or instance that you want to protect.

   - **Step 3**: **Modify the RDS Cluster or Instance**
     - Click on the **Modify** button for the selected cluster or instance.

   - **Step 4**: **Enable Deletion Protection**
     - Scroll down to the **Deletion Protection** section.
     - Check the box for **Enable deletion protection** to activate this feature.

   - **Step 5**: **Apply the Changes**
     - Save the changes. Depending on the instance, the change may apply immediately without requiring a reboot.

   **Note**: If Deletion Protection is enabled, you will not be able to delete the instance or cluster without first disabling this protection.

### 3. **Enable Deletion Protection via AWS CLI**

   You can also enable Deletion Protection using the AWS CLI for more efficient management across multiple instances.

   - **Example Command for Enabling Deletion Protection on a Cluster**:
     ```bash
     aws rds modify-db-cluster \
     --db-cluster-identifier prod-cluster \
     --deletion-protection \
     --apply-immediately
     ```

   - **Example Command for Enabling Deletion Protection on a Single Instance**:
     ```bash
     aws rds modify-db-instance \
     --db-instance-identifier prod-db-instance-1 \
     --deletion-protection \
     --apply-immediately
     ```

### 4. **Verify the Deletion Protection Status**

   - **Step 1**: **Check the Console**
     - Return to the RDS dashboard and confirm that Deletion Protection is enabled for the specified clusters and instances. The **Deletion Protection** column should show **Enabled**.

   - **Step 2**: **Check via AWS CLI**
     - Use the AWS CLI to confirm that Deletion Protection is enabled.
     - Example Command:
       ```bash
       aws rds describe-db-instances --db-instance-identifier prod-db-instance-1 --query 'DBInstances[*].DeletionProtection'
       ```

### 5. **Test Deletion Protection**

   - **Step 1**: **Attempt to Delete the RDS Cluster or Instance**
     - Try deleting the RDS cluster or instance through the console or CLI. If Deletion Protection is enabled, AWS will block the deletion and display an error indicating that the resource is protected.

   - **Step 2**: **Disable Deletion Protection and Delete**
     - To delete the resource, you must first disable Deletion Protection by modifying the cluster or instance and unchecking the **Enable Deletion Protection** option. Only after this is disabled will deletion be allowed.

### Testing

- **Manual Deletion Test**:
   - Attempt to delete an RDS instance or cluster with Deletion Protection enabled to ensure that AWS prevents the deletion.

- **Validation via AWS CLI**:
   - Use the AWS CLI to confirm that Deletion Protection is enabled on all critical instances and clusters.

### External Dependencies
- **AWS RDS Console or AWS CLI**: Required to enable Deletion Protection for clusters or instances.
- **IAM Permissions**: Ensure that the user or role performing these actions has the appropriate permissions to modify RDS instances.

## Acceptance Criteria
- Should enable Deletion Protection for all specified RDS clusters and instances.
- Should prevent accidental deletion of protected RDS resources.
- Should successfully test that deletion attempts are blocked unless Deletion Protection is disabled.
- Should verify that Deletion Protection is enabled across all critical databases.

### Gherkin
```gherkin
Given an RDS cluster with Deletion Protection enabled
When an attempt is made to delete the cluster
Then the deletion should be blocked and an error message should indicate that Deletion Protection is enabled.

Given an RDS instance with Deletion Protection enabled
When a user checks the status of the instance
Then Deletion Protection should be marked as enabled in both the console and CLI.
```
