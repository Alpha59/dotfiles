## Summary
**As a** DevOps engineer or database administrator, **I want** to enable **IAM Database Authentication** for AWS RDS tables, **so that** users can authenticate to the database using their AWS IAM credentials instead of traditional username/password authentication.

Enabling IAM Database Authentication improves security by centralizing authentication management within IAM, allowing you to use temporary credentials for database access. It eliminates the need to manage passwords within the database itself, enhancing the security posture for database access and enabling role-based access control (RBAC).

### Vision
By enabling IAM Database Authentication, database access will be tightly integrated with AWS Identity and Access Management (IAM), allowing the use of temporary, time-limited credentials for secure access. This provides enhanced security by removing the need for hard-coded credentials and supporting fine-grained access controls for users and roles.

### Background
IAM Database Authentication allows you to connect to your RDS database using IAM credentials rather than traditional database passwords. It works by generating an authentication token via the AWS SDK or AWS CLI, which is used instead of a password to authenticate to the database. These tokens are temporary and automatically expire, reducing the risk of credential leakage.

IAM Database Authentication is supported for **Amazon RDS** for **MySQL** and **PostgreSQL** databases.

### Purpose
The purpose of this story is to enable IAM Database Authentication on the AWS RDS database and configure IAM roles and policies that allow users and applications to securely connect to the database without using passwords.

## Details

### 1. **Check Compatibility and Prerequisites**

   - **Supported RDS Engines**:
     - IAM Database Authentication is supported for **Amazon RDS MySQL** (versions 5.6 and later) and **Amazon RDS PostgreSQL** (versions 9.5 and later).
     - Ensure that your RDS instance is compatible before proceeding.

   - **IAM Policies**:
     - Ensure that the users or roles that need to authenticate have the correct IAM policies that allow generating authentication tokens and connecting to the RDS database.

### 2. **Enable IAM Database Authentication on the RDS Instance**

   - **Step 1**: **Open the AWS RDS Console**
     - Go to the **Amazon RDS Console** in the AWS Management Console.

   - **Step 2**: **Modify the RDS Instance**
     - Select the RDS instance for which you want to enable IAM database authentication.
     - Choose the **Modify** option.

   - **Step 3**: **Enable IAM DB Authentication**
     - In the **Database Authentication** section, enable the option for **IAM DB Authentication**.
     - Apply the changes. Depending on the instance, this may require a reboot.

   - **Step 4**: **Save Changes and Reboot the Instance**
     - Save the changes and, if required, reboot the RDS instance to apply the configuration.

   - **Example Command** (using AWS CLI):
     ```bash
     aws rds modify-db-instance \
       --db-instance-identifier my-db-instance \
       --enable-iam-database-authentication \
       --apply-immediately
     ```

### 3. **Create an IAM Role or Policy for Database Access**

   - **Step 1**: **Create or Identify the IAM Role**
     - Create or use an existing IAM role that will be granted permissions to authenticate with the RDS database.

   - **Step 2**: **Attach Policy for RDS Access**
     - Attach a policy to the IAM role that allows the user to connect to the RDS instance and generate authentication tokens.
     - Example IAM Policy:
     ```json
     {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Action": [
             "rds-db:connect"
           ],
           "Resource": [
             "arn:aws:rds-db:region:account-id:dbuser:db-cluster-id/db-username"
           ]
         }
       ]
     }
     ```
     - The `rds-db:connect` permission allows the IAM role to connect to the RDS instance as the specified database user.

### 4. **Generate an IAM Authentication Token**

   - **Step 1**: **Generate a Token Using the AWS CLI or SDK**
     - Use the AWS CLI or AWS SDK to generate a temporary authentication token. This token will be used in place of a password when connecting to the database.
     - Example Command to Generate Token:
     ```bash
     aws rds generate-db-auth-token \
       --hostname my-db-instance.cluster-region.rds.amazonaws.com \
       --port 3306 \
       --region region \
       --username db-username
     ```

   - **Step 2**: **Use the Generated Token**
     - The generated token can then be used as the password when establishing a connection to the RDS database. Tokens expire after 15 minutes, ensuring that access is time-limited.

### 5. **Configure Client Connection**

   - **Step 1**: **Connect Using the Token**
     - Configure your database client (e.g., **MySQL**, **pgAdmin**, **psql**) to use the generated IAM token as the password when connecting to the RDS instance.

   - **Step 2**: **Example for MySQL**
     - Example MySQL connection string using IAM authentication:
     ```bash
     mysql --host=my-db-instance.cluster-region.rds.amazonaws.com \
           --port=3306 \
           --ssl-ca=rds-combined-ca-bundle.pem \
           --enable-cleartext-plugin \
           --user=db-username \
           --password=<GENERATED_TOKEN>
     ```

   - **Step 3**: **Example for PostgreSQL**
     - Example PostgreSQL connection string using IAM authentication:
     ```bash
     psql "host=my-db-instance.cluster-region.rds.amazonaws.com \
           port=5432 \
           sslmode=verify-full \
           dbname=mydb \
           user=db-username \
           password=<GENERATED_TOKEN>"
     ```

### 6. **Test the IAM Authentication**

   - **Step 1**: **Test IAM User Login**
     - Test that the IAM user or role can successfully generate an authentication token and connect to the RDS database using that token.

   - **Step 2**: **Check Permissions**
     - Verify that the IAM user or role has the appropriate database permissions, ensuring they can perform the necessary actions within the database (e.g., read/write operations).

### Testing

- **Authentication Token Testing**:
   - Test the generated IAM authentication token by connecting to the database with the token. Ensure that the connection works and that the token expires after the specified time.

- **Role/Policy Testing**:
   - Test the IAM roles and policies by verifying that only authorized users can generate tokens and connect to the database.

- **Database Connection Testing**:
   - Test database connectivity using different clients (e.g., MySQL client, PostgreSQL client) to ensure that IAM authentication works across different tools.

### External Dependencies
- **IAM roles and policies**: Ensure the IAM user/role has the necessary permissions to generate authentication tokens and connect to the RDS instance.
- **AWS RDS MySQL/PostgreSQL**: Ensure that the RDS instance supports IAM Database Authentication.

## Acceptance Criteria
- Should enable IAM Database Authentication on the specified RDS instance.
- Should configure IAM policies to allow users and roles to generate authentication tokens and connect to the database.
- Should successfully test IAM-authenticated connections to the RDS instance using generated tokens.
- Should ensure that the IAM authentication token expires as expected, requiring regeneration after the token's expiration.

### Gherkin
```gherkin
Given an RDS MySQL or PostgreSQL instance
When IAM Database Authentication is enabled
Then users should be able to generate authentication tokens and connect to the database using IAM credentials.

Given an IAM role with database access permissions
When a token is generated using AWS CLI or SDK
Then the user should be able to authenticate to the RDS database using the generated token.
```
