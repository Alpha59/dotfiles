
# Document DMS processes, creation, and Constraints of DMS
### Summary
**As a** DevOps Engineer, **I want** to document the process of creating and managing Database Migration Service (DMS) tasks, including key constraints and limitations, **So That** teams can efficiently use DMS to migrate data between databases while understanding the caveats and constraints associated with the service.

This document focuses on the steps to create and manage AWS Database Migration Service (DMS) tasks, its key components, and the constraints that users need to consider when using DMS. AWS DMS enables users to migrate databases with minimal downtime by using continuous data replication.

### Vision
By documenting the DMS creation process and its constraints, we ensure that users have a clear understanding of how to set up and execute data migrations while being aware of potential issues or limitations. This will streamline the migration process, prevent common pitfalls, and enhance the overall experience of migrating databases using DMS.

### Background
AWS Database Migration Service (DMS) supports data migration between heterogeneous and homogeneous database engines with minimal downtime. It helps migrate data between on-premise databases to AWS or between AWS services. DMS supports popular databases like MySQL, PostgreSQL, Oracle, SQL Server, and more.

## Details

### Key Components of AWS DMS

1. **Source Database**
   - The database from which data will be migrated. DMS supports various databases such as MySQL, PostgreSQL, Oracle, SQL Server, MongoDB, etc.
   - The source database must be accessible by AWS DMS with the necessary permissions to read and extract data.

2. **Target Database**
   - The destination database where data will be migrated. Similar to the source, DMS supports several target databases and the target must be prepared to accept incoming data.

3. **Replication Instance**
   - DMS requires a replication instance to perform data migration. The replication instance processes the data migration tasks, reading data from the source and writing it to the target database.
   - Choose an instance size based on the volume of data and the performance requirements of the migration task.

4. **Endpoints**
   - Source and target databases are configured as endpoints in DMS. An endpoint consists of connection details (e.g., host, port, user credentials) and migration settings.
   - Endpoint settings may need to be configured to match the specific requirements of the source and target databases.

5. **Migration Task**
   - A DMS migration task defines the type of migration and the data to be moved:
     - **Full Load**: Migrates all existing data from the source to the target.
     - **Change Data Capture (CDC)**: Continuously captures changes in the source database and replicates them to the target in near real-time.
     - **Full Load + CDC**: Migrates existing data and continuously replicates changes during the migration process.

### Steps for Creating and Managing DMS Tasks

#### 1. **Setting up DMS Components**
   1.1. **Create a Replication Instance**:
   - From the AWS Management Console, go to the DMS service and choose **Create replication instance**.
   - Select an appropriate instance size based on the size of the database and the expected load.
   - Ensure the replication instance can connect to both the source and target databases by configuring the correct VPC and security group settings.

   Example command using AWS CLI:
   ```bash
   aws dms create-replication-instance --replication-instance-identifier my-replication-instance    --replication-instance-class dms.r5.large --allocated-storage 100
   ```

   1.2. **Create Source and Target Endpoints**:
   - Create endpoints for both the source and target databases, providing connection details (hostname, port, database name, and credentials).
   - Test the connection to ensure DMS can connect to both databases.

   Example command for creating an endpoint:
   ```bash
   aws dms create-endpoint --endpoint-identifier my-source-endpoint --endpoint-type source    --engine-name mysql --username myuser --password mypassword    --server-name mydb.example.com --port 3306 --database-name mydb
   ```

   1.3. **Create Migration Task**:
   - Define a migration task by specifying the source and target endpoints, the replication instance, and the type of migration (full load, CDC, or both).
   - Configure migration settings such as table mappings, pre-migration tasks, and validation settings.

   Example command:
   ```bash
   aws dms create-replication-task --replication-task-identifier my-migration-task    --source-endpoint-arn arn:aws:dms:source-endpoint --target-endpoint-arn arn:aws:dms:target-endpoint    --migration-type full-load-and-cdc --table-mappings file://mappings.json --replication-instance-arn arn:aws:dms:replication-instance
   ```

#### 2. **Monitoring and Managing DMS Tasks**
   2.1. **Monitor the Migration**:
   - Use the AWS DMS console or CloudWatch metrics to monitor the status of the migration task. Look for key metrics such as data transfer rates, error counts, and task status.

   2.2. **Validate Data Integrity**:
   - After the migration is complete, validate that the data on the target matches the source using tools like DMS data validation or external comparison utilities.
   - If CDC is used, confirm that changes are being replicated correctly by monitoring logs or querying the target database.

   2.3. **Handle Failures and Retries**:
   - If the migration task encounters errors, troubleshoot by reviewing CloudWatch logs and DMS task logs.
   - DMS automatically retries some errors, but if the migration fails, it may need to be restarted after resolving the underlying issue.

   2.4. **Complete the Migration**:
   - Once the full load and change data capture are complete, validate that the target is up-to-date and matches the source. You can then stop the CDC process and switch over the application to the target database.

### Constraints and Limitations of AWS DMS

1. **Database Schema Changes**
   - AWS DMS is primarily designed for data migration, not schema migration. For schema migration, AWS recommends using **AWS Schema Conversion Tool (SCT)** to convert database schemas between heterogeneous databases.
   - DMS can create basic schema objects like tables and primary keys, but complex objects like indexes, stored procedures, and triggers must be handled separately.

2. **Limited Data Types**
   - Some data types (e.g., complex binary objects, user-defined types) may not be supported in all database engines. Data type conversions may be required when migrating between heterogeneous databases.

3. **Replication Instance Performance**
   - The performance of the migration depends on the size and configuration of the replication instance. Under-provisioned instances can lead to slower migrations, particularly for large datasets or high-throughput applications.

4. **Network Latency**
   - Network latency can impact migration performance, especially when migrating between on-premise databases and AWS. It is recommended to use **AWS Direct Connect** or **VPN** to minimize network issues.

5. **Task Failures**
   - DMS tasks may fail due to issues such as network interruptions, incorrect endpoint configurations, or database-specific limitations. Monitoring and retries are essential to ensure the migration completes successfully.

6. **Unsupported Features**
   - Certain database-specific features (e.g., partitioning, clustering, materialized views) are not migrated by DMS and must be handled manually during migration.

7. **Data Validation**
   - AWS DMS provides basic validation for ensuring the data transferred matches between source and target. However, for complex validation, additional third-party tools or custom scripts may be required.

8. **CDC Limitations**
   - DMS’s Change Data Capture (CDC) feature is useful for near real-time replication but has limitations in terms of delay or unsupported operations depending on the source database engine and configuration.

### Testing
- Test the migration process on a small set of data before migrating the entire production database.
- Validate network connectivity, replication instance performance, and data integrity.
- Perform load testing on the target database after migration to ensure it can handle the expected application load.

### Acceptance Criteria
- Should have set up DMS components including replication instance, source/target endpoints, and migration tasks.
- Should have migrated data using full load, CDC, or a combination.
- Should have documented constraints and limitations of AWS DMS for informed decision-making during migrations.
- Should have monitored the migration using CloudWatch and logs, and handled any failures or retries.
- Should have validated the integrity of the migrated data on the target.
