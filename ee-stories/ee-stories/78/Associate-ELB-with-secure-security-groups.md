## Summary
**As a** cloud security engineer or AWS architect, **I want** to associate the **Elastic Load Balancer (ELB)** with **secure security groups**, **so that** the ELB only allows traffic from trusted sources and minimizes exposure to attacks, ensuring that the services behind the ELB are well-protected from unauthorized access.

By associating the ELB with tightly controlled security groups, you define the inbound and outbound traffic rules that determine which IP addresses, services, or applications can interact with your ELB and the backend services it directs traffic to. This setup ensures secure access, proper traffic routing, and enhanced protection against external threats.

### Vision
By associating the ELB with secure security groups, the team will ensure that all traffic passing through the ELB adheres to specific security rules, minimizing unauthorized access and attack vectors. This will result in improved network security, providing better protection for services behind the load balancer.

### Background
Elastic Load Balancers distribute incoming application traffic across multiple instances, containers, or Lambda functions. Without proper security group configuration, the ELB could be exposed to malicious traffic. Security groups act as virtual firewalls, controlling the inbound and outbound traffic for your ELB. Configuring security groups correctly ensures only authorized traffic reaches the ELB, securing the application.

### Purpose
The purpose of this story is to configure secure security groups for the ELB, defining precise rules for incoming and outgoing traffic to protect backend services from unauthorized access and potential threats.

## Details

### 1. **Create or Identify Secure Security Groups**
   - **Inbound Rules**: Define inbound rules that only allow traffic from trusted sources, such as specific IP ranges (CIDR blocks), other AWS security groups (e.g., EC2 instances or VPCs), or ports that must remain open (e.g., port 443 for HTTPS traffic).
   - **Outbound Rules**: Allow outbound traffic only to specific IP addresses or other AWS services (e.g., backend instances, databases) to limit exposure.

   **Best Practices for Security Groups**:
   - Allow traffic only on necessary ports (e.g., port 443 for HTTPS or 80 for HTTP, if needed).
   - Use **least privilege** principles by restricting IP ranges (e.g., only allow trusted internal IP addresses for admin access).
   - Deny all incoming traffic except from trusted sources.
   - Configure security groups for **stateless** or **stateful** services to manage connections efficiently.

   **Example of Inbound Security Group Rules**:
   | Protocol | Port Range | Source            | Description                 |
   |----------|------------|-------------------|-----------------------------|
   | TCP      | 443        | 0.0.0.0/0         | Allow HTTPS traffic          |
   | TCP      | 80         | 0.0.0.0/0         | Allow HTTP traffic (optional)|
   | TCP      | 22         | x.x.x.x/32        | Allow SSH only from admin IP |

   **Example of Outbound Security Group Rules**:
   | Protocol | Port Range | Destination | Description                    |
   |----------|------------|-------------|--------------------------------|
   | All      | All        | 0.0.0.0/0   | Allow outbound traffic to any  |

### 2. **Configure Security Group for ELB**
   - Navigate to **EC2 Console** -> **Load Balancers** and select the appropriate ELB.
   - Under the **Security** tab, choose **Edit security groups**.
   - Select an existing secure security group, or create a new one following the best practices mentioned above.

   **AWS CLI Example**:
   - Create a new security group:
     ```bash
     aws ec2 create-security-group --group-name elb-secure-group --description "Security group for ELB" --vpc-id vpc-xxxxxx
     ```

   - Add rules to the security group to allow HTTPS traffic (port 443) only:
     ```bash
     aws ec2 authorize-security-group-ingress --group-id sg-xxxxxx --protocol tcp --port 443 --cidr 0.0.0.0/0
     ```

   - Attach the security group to the ELB:
     ```bash
     aws elb apply-security-groups-to-load-balancer --load-balancer-name my-elb --security-groups sg-xxxxxx
     ```

### 3. **Use SSL/TLS for Secure Communication**
   - Ensure that the ELB is configured to use **SSL/TLS** to encrypt communication between the client and the load balancer. Use **AWS Certificate Manager (ACM)** to manage SSL certificates and assign them to the ELB.

   **Steps**:
   - Request or import an SSL/TLS certificate via **AWS ACM**.
   - Configure the ELB listener to handle HTTPS traffic on port 443 and associate the SSL certificate.

   **Example AWS CLI to Associate SSL Certificate with an ELB**:
   ```bash
   aws elb set-load-balancer-listener-ssl-certificate \
     --load-balancer-name my-elb \
     --load-balancer-port 443 \
     --ssl-certificate-id arn:aws:acm:region:account-id:certificate/certificate-id
   ```

### 4. **Configure Logging and Monitoring for ELB**
   - Enable **Access Logs** for the ELB to track traffic patterns and identify potential security issues.
   - Use **CloudWatch Alarms** to monitor traffic and trigger notifications if there are spikes in traffic, unusual patterns, or potential threats.

   **Enable Access Logs**:
   ```bash
   aws elb modify-load-balancer-attributes \
     --load-balancer-name my-elb \
     --load-balancer-attributes AccessLog={"Enabled"=true,"S3BucketName"="my-logs-bucket","EmitInterval"=5,"S3BucketPrefix"="ELBLogs"}
   ```

   **Set CloudWatch Alarms for Unusual Traffic Patterns**:
   ```bash
   aws cloudwatch put-metric-alarm --alarm-name "ELB-Traffic-Spike" \
     --metric-name "RequestCount" --namespace "AWS/ELB" \
     --statistic "Sum" --period 300 --threshold 1000 --comparison-operator GreaterThanThreshold \
     --evaluation-periods 1 --alarm-actions arn:aws:sns:region:account-id:MySNSTopic
   ```

### 5. **Test Security Group Configuration**
   - Verify that the security group is correctly restricting traffic by running penetration tests or scanning the ELB for open ports.
   - Ensure that only the configured ports (e.g., 443) are open and that only allowed IP addresses can access the ELB.

   **Testing Tools**:
   - Use **nmap** or other network scanning tools to test the security group and identify any open ports or vulnerabilities.
   - Example `nmap` command to test open ports:
     ```bash
     nmap -p 443 <elb-domain-name>
     ```

   - Verify that SSL/TLS encryption is properly configured by using **SSL Labs** or other SSL testing tools.

### 6. **Regularly Review and Update Security Groups**
   - Review security groups periodically to ensure that rules remain effective and that no unnecessary ports are open.
   - Implement automated monitoring using **AWS Config** rules to detect security group misconfigurations and ensure compliance with security best practices.

   **Example AWS Config Rule**:
   - Use AWS Config to detect security groups with wide-open rules:
     ```bash
     aws configservice put-config-rule --config-rule-name restricted-ssh --source Owner=AWS,SourceIdentifier=INCOMING_SSH_DISABLED
     ```

### Testing
- Verify that traffic through the ELB is restricted according to the security group rules by attempting to access the ELB from unauthorized IP addresses or over closed ports.
- Ensure that HTTPS traffic is encrypted with the proper SSL certificate.
- Monitor CloudWatch Logs for any signs of unauthorized access attempts or unusual traffic patterns.

### Acceptance Criteria
- Should associate the ELB with secure security groups that allow only authorized traffic on necessary ports.
- Should configure the ELB to use SSL/TLS encryption for secure communication.
- Should enable logging and monitoring to track traffic patterns and detect potential threats.
- Should test security group rules to ensure that only authorized traffic is allowed.
- Should regularly review and update security group configurations to adhere to best practices.

### External Links
- [AWS Security Groups Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)
- [AWS Elastic Load Balancer Documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/what-is-load-balancing.html)
- [AWS Config Rules for Security Group Management](https://docs.aws.amazon.com/config/latest/developerguide/securitygroup-rules.html)
