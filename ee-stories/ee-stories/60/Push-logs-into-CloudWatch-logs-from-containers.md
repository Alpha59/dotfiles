## Summary
**As a** DevOps engineer or software engineer, **I want** to push logs from containers into AWS CloudWatch Logs, **so that** I can centralize log storage, monitor application health, and troubleshoot issues across distributed containerized services in real-time.

Centralizing logs in CloudWatch enables easier tracking of performance, error rates, and other application behaviors across multiple containers and environments. It improves observability, aids in troubleshooting, and allows for the creation of metrics and alarms to detect issues early.

### Vision
By pushing logs from all containers into CloudWatch Logs, the team will have a single, centralized location for monitoring logs in real-time. This ensures better visibility into application behavior across various services and helps in quickly diagnosing issues by analyzing logs from multiple containers in one place.

### Background
In containerized environments, logs generated within each container are ephemeral. Without centralized logging, logs can be lost when containers are restarted or terminated. AWS CloudWatch Logs provide a scalable and durable solution for collecting, monitoring, and analyzing logs from multiple sources. By pushing container logs into CloudWatch Logs, we ensure that logs are not lost, are easily accessible, and can be analyzed using CloudWatch’s powerful query capabilities.

### Purpose
The purpose of this story is to configure containers to push their logs to CloudWatch Logs, ensuring centralized logging across all environments, improving monitoring, and enabling more efficient troubleshooting.

## Details

### 1. **Determine Log Sources and Container Setup**
   - **Log Sources**:
     - Identify which logs need to be pushed to CloudWatch. These typically include application logs, access logs, and error logs generated inside containers.
     - Example logs:
       - Application logs (e.g., `/var/log/app.log`)
       - NGINX/Apache access logs (e.g., `/var/log/nginx/access.log`)

   - **Container Setup**:
     - Containers may be running in **Amazon ECS**, **EKS (Kubernetes)**, or **Docker** on EC2 instances. Ensure that the log configuration aligns with the container orchestrator in use.

### 2. **Configure CloudWatch Log Group**
   - **Log Group and Log Stream Setup**:
     - Create a **CloudWatch Log Group** for each containerized service. Log groups provide a way to organize logs, while log streams represent the logs for individual containers or tasks.
     - Example AWS CLI command to create a log group:
       ```bash
       aws logs create-log-group --log-group-name /my-app/logs
       ```

### 3. **Configure Logging Drivers for Containers**
   - **ECS (Amazon Elastic Container Service)**:
     - In ECS, use the **awslogs** log driver to send logs from containers to CloudWatch Logs. Configure the ECS task definition to include the necessary logging options.
     - Example ECS task definition snippet:
       ```json
       {
         "logConfiguration": {
           "logDriver": "awslogs",
           "options": {
             "awslogs-group": "/my-app/logs",
             "awslogs-region": "us-east-1",
             "awslogs-stream-prefix": "ecs"
           }
         }
       }
       ```

   - **EKS (Amazon Elastic Kubernetes Service)**:
     - For Kubernetes-based containers, use the **Fluentd** or **Fluent Bit** agent to push logs to CloudWatch Logs. Configure Fluentd/Fluent Bit to collect logs from containerized applications and forward them to CloudWatch.
     - Example Fluent Bit configuration for CloudWatch:
       ```ini
       [OUTPUT]
           Name cloudwatch
           Match *
           log_group_name my-app-log-group
           log_stream_prefix my-app-
           region us-east-1
       ```

   - **Docker on EC2**:
     - For standalone Docker containers, configure the **awslogs** log driver in the Docker run command or Docker Compose file to send logs directly to CloudWatch.
     - Example Docker command:
       ```bash
       docker run --log-driver=awslogs --log-opt awslogs-group=/my-app/logs --log-opt awslogs-region=us-east-1 my-container
       ```

### 4. **Set Up Permissions for Logging**
   - **IAM Role Configuration**:
     - Ensure that the containers have the necessary IAM permissions to write logs to CloudWatch. Attach a policy to the ECS Task Role, EC2 instance role, or Kubernetes service account.
     - Example IAM policy:
       ```json
       {
         "Version": "2012-10-17",
         "Statement": [
           {
             "Effect": "Allow",
             "Action": [
               "logs:CreateLogStream",
               "logs:PutLogEvents"
             ],
             "Resource": "arn:aws:logs:us-east-1:123456789012:log-group:/my-app/logs:*"
           }
         ]
       }
       ```

### 5. **Monitor Logs in CloudWatch**
   - **Log Streams and Insights**:
     - Once logs are pushed to CloudWatch, use the CloudWatch Logs interface to view logs in real-time or query them using CloudWatch Logs Insights for more detailed analysis.
     - Example CloudWatch Logs Insights query:
       ```sql
       fields @timestamp, @message
       | filter @message like /ERROR/
       | sort @timestamp desc
       ```

   - **CloudWatch Alarms**:
     - Set up CloudWatch Alarms to monitor log patterns, such as error frequency, and trigger alerts when certain thresholds are reached.
     - Example: Trigger an alarm when more than 10 errors occur in the last 5 minutes.

### Testing
- **Test Log Visibility**:
   - Run test containers in ECS, EKS, or Docker with the log configuration in place and verify that logs appear in CloudWatch Logs in real-time.

- **Simulate Error Conditions**:
   - Simulate error logs (e.g., by forcing an application to fail) and ensure that they are pushed to CloudWatch Logs and alerts are triggered if thresholds are exceeded.

### External Dependencies
- AWS CloudWatch Logs for storing and querying logs.
- IAM roles and policies to grant permissions for log writing.
- Fluent Bit or Fluentd agent (for Kubernetes-based logging).

## Acceptance Criteria
- Should push logs from containers into CloudWatch Logs for centralized monitoring.
- Should configure at least one log group per service with appropriate log streams.
- Should ensure real-time log visibility and set up alerts for error patterns.

### Gherkin
```gherkin
Given a containerized application running in ECS, EKS, or Docker
When the application generates logs
Then the logs should be pushed to CloudWatch Logs
And the logs should be viewable in real-time.
```
```gherkin
Given logs are being pushed to CloudWatch
When an error occurs in the application
Then the logs should reflect the error
And CloudWatch Alarms should trigger if error thresholds are exceeded.
```
