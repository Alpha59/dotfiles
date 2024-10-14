
# Enable access logs for ELB/ALBs
### Summary
**As a** DevOps Engineer, **I want** to enable access logs for Elastic Load Balancers (ELBs) and Application Load Balancers (ALBs), **So That** we can monitor and analyze the incoming traffic, identify patterns, troubleshoot issues, and improve the overall performance and security of the application.

This story focuses on enabling access logging for ELBs and ALBs to capture detailed request information, such as the client IP, request URL, and response codes. These logs are stored in  S3 and can be used for troubleshooting, monitoring traffic, and gaining insights into application behavior.

### Vision
By enabling access logs for ELBs and ALBs, we can monitor traffic, detect anomalies, troubleshoot errors, and optimize the performance of the services behind the load balancer. The logs will provide valuable data for security auditing, performance monitoring, and root cause analysis.

### Background
Access logs for ELBs and ALBs capture important data about incoming requests and responses, such as request paths, response codes, client IPs, request latencies, and more. This data is crucial for analyzing traffic patterns, identifying performance bottlenecks, and detecting potential security threats. Enabling access logs allows us to store this data in  S3 for further analysis and long-term storage.

### Purpose
The purpose of this story is to enable access logs for all ELBs and ALBs in the system, configure logging parameters (such as the S3 bucket destination), and ensure that logs are correctly rotated and archived for future analysis.

## Details
### 1. Prepare the S3 Bucket for Log Storage
Before enabling access logs, we need an  S3 bucket to store the log files. This bucket must be configured with the appropriate permissions to allow the load balancer to write logs to it.

#### Steps to Create an S3 Bucket for Logs:
1. Navigate to the **S3 Console** and create a new bucket (or use an existing one).
2. Give the bucket a descriptive name (e.g., `my-app-access-logs`).
3. Set the appropriate permissions for the bucket to ensure that the ELB/ALB can write logs to it.

#### Example Bucket Policy for Allowing ELB/ALB to Write Logs:
```json
{
  'Version': '2012-10-17',
  'Statement': [
    {
      'Effect': 'Allow',
      'Principal': {
        'Service': 'elasticloadbalancing.amazonaws.com'
      },
      'Action': 's3:PutObject',
      'Resource': 'arn:aws:s3:::my-app-access-logs/*',
      'Condition': {
        'StringEquals': {
          'aws:SourceAccount': '<YOUR_ACCOUNT_ID>'
        },
        'ArnLike': {
          'aws:SourceArn': 'arn:aws:elasticloadbalancing:*:<YOUR_ACCOUNT_ID>:loadbalancer/*'
        }
      }
    }
  ]
}
```

- **Principal**: This allows the ELB/ALB service to write to the bucket.
- **Action**: The action `s3:PutObject` allows objects (log files) to be written to the S3 bucket.
- **Resource**: The ARN of the S3 bucket where logs will be stored.
- **Condition**: Ensures that the request comes from your AWS account and an ELB/ALB in your account.

### 2. Enable Access Logs for ELBs
If you're using **Classic Load Balancers (ELBs)**, access logs can be enabled through the AWS Management Console, AWS CLI, or AWS SDKs.

#### Steps to Enable Access Logs for an ELB in the AWS Console:
1. Navigate to the **EC2 Console**.
2. In the **Load Balancers** section, select the ELB for which you want to enable access logs.
3. Choose the **Description** tab and click on **Edit Attributes**.
4. In the **Access Logs** section, check the box to enable access logging.
5. Specify the **S3 bucket name** (e.g., `my-app-access-logs`).
6. Set a **Log Prefix** (optional) to organize logs in a specific folder within the bucket.
7. Choose the **Interval** (the frequency at which log files are delivered, e.g., 5 or 60 minutes).
8. Click **Save** to apply the changes.

#### AWS CLI Command to Enable ELB Access Logs:
```bash
aws elb modify-load-balancer-attributes     --load-balancer-name my-elb     --load-balancer-attributes '{
        'AccessLog': {
            'Enabled': true,
            'S3BucketName': 'my-app-access-logs',
            'EmitInterval': 5,
            'S3BucketPrefix': 'elb/'
        }
    }'
```

### 3. Enable Access Logs for ALBs
For **Application Load Balancers (ALBs)**, access logs can also be enabled through the AWS Management Console, AWS CLI, or AWS SDKs.

#### Steps to Enable Access Logs for an ALB in the AWS Console:
1. Navigate to the **EC2 Console**.
2. In the **Load Balancers** section, select the ALB for which you want to enable access logs.
3. Choose the **Description** tab and click on **Edit Attributes**.
4. In the **Access Logs** section, check the box to enable access logging.
5. Specify the **S3 bucket name** (e.g., `my-app-access-logs`).
6. Set a **Log Prefix** (optional) to organize logs in a specific folder within the bucket.
7. Click **Save** to apply the changes.

#### AWS CLI Command to Enable ALB Access Logs:
```bash
aws elbv2 modify-load-balancer-attributes     --load-balancer-arn arn:aws:elasticloadbalancing:region:account-id:loadbalancer/app/my-alb/1234567890abcdef     --attributes 'Key=access_logs.s3.enabled,Value=true Key=access_logs.s3.bucket,Value=my-app-access-logs Key=access_logs.s3.prefix,Value=alb/'
```

### 4. Verify Access Logs Configuration
After enabling access logs, you should verify that the logs are being written to the S3 bucket as expected.

#### Steps to Verify:
1. Navigate to the **S3 Console** and open the bucket where the logs are being stored.
2. Ensure that the logs are being written to the correct folder (based on the prefix you specified).
3. Check that log files are being created at the specified intervals (e.g., every 5 minutes or 60 minutes).

### 5. Review Log Content
The log files contain detailed information about the requests and responses handled by the load balancer. Each log entry includes details such as:
  - **Client IP**: The IP address of the client that made the request.
  - **Request Path**: The URL path of the request.
  - **Response Code**: The HTTP status code returned to the client.
  - **Latency**: The total time taken to process the request.
  - **Target IP**: The IP address of the backend target that processed the request.

Sample log entry for an ALB:
```
https 2021-09-23T17:52:34.019392Z app/my-alb/1234567890abcdef 192.0.2.44:62480 10.0.0.1:80 0.000 0.002 0.000 200 200 0 57 'GET http://my-app.com:80/index.html HTTP/1.1' 'curl/7.66.0' - - arn:aws:elasticloadbalancing:region:account-id:targetgroup/my-target-group/1234567890abcdef 'Root=1-5f47c3de-328f2e43b725d71fdf8233aa' '-' '-'
```

### 6. Set Up Log Rotation and Retention Policies
Log files can grow rapidly in size, especially for high-traffic applications. To manage storage costs and maintain an organized log archive, set up log rotation and retention policies using S3 lifecycle rules.

#### Steps to Set Up Log Retention in S3:
1. Navigate to the **S3 Console** and open the bucket where the logs are stored.
2. Go to the **Management** tab and click on **Create lifecycle rule**.
3. Define a rule to archive or delete logs after a certain period (e.g., move to **Glacier** after 30 days, delete after 90 days).

### 7. Monitor and Analyze Logs
The logs can be used for monitoring, troubleshooting, and analyzing application performance. Tools such as ** Athena** or **AWS CloudWatch Logs** can be used to query the logs and gain insights into the traffic patterns, errors, and performance of the services behind the load balancer.

#### Example Athena Query for ALB Logs:
```sql
SELECT *
FROM alb_logs
WHERE elb_status_code = 500
ORDER BY time DESC
LIMIT 10;
```

### Testing
- **Log Verification Test**: Ensure that logs are being written to the correct S3 bucket and directory at the specified intervals.
- **Log Content Test**: Verify that the log entries contain the correct details, such as client IPs, request paths, and response codes.
- **Log Retention Test**: Ensure that the S3 lifecycle rules are applied correctly and logs are archived or deleted after the retention period.

### External Dependencies
- ** S3**: Ensure that the S3 bucket is correctly configured to receive and store the access logs.
- **AWS EC2 Console**: For configuring and managing ELBs and ALBs.
- **Athena or CloudWatch Logs**: For querying and analyzing the log data.

## Acceptance Criteria
- Should have enabled access logs for all ELBs and ALBs.
- Should have configured the S3 bucket for storing logs, with appropriate permissions and lifecycle policies.
- Should have verified that logs are being written to the bucket at the specified intervals.
- Should have set up monitoring and analysis tools for querying and analyzing the logs.
- Should have established log retention policies to manage storage costs.

### Gherkin
#### Scenario: Enabling Access Logs for ELB
Given an ELB is configured,
When I enable access logs,
Then logs should be written to the specified S3 bucket,
And the logs should contain details of incoming requests and responses.

#### Scenario: Enabling Access Logs for ALB
Given an ALB is configured,
When I enable access logs,
Then logs should be written to the specified S3 bucket,
And the logs should contain details of incoming requests and responses.

#### Scenario: Verifying Access Logs in S3
Given access logs are enabled for the load balancer,
When I check the S3 bucket,
Then I should see log files created at the specified intervals,
And the log files should contain valid request and response data.

## External Links
- [ELB Access Logs Documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/access-log-collection.html)
- [ALB Access Logs Documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html)
- [S3 Lifecycle Policy Documentation](https://docs.aws.amazon.com/

