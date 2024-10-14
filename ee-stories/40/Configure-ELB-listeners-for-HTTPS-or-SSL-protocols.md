
# Configure ELB listeners for HTTPS or SSL protocols
### Summary
**As a** DevOps Engineer, **I want** to configure Elastic Load Balancer (ELB) listeners for HTTPS or SSL protocols, **So That** I can ensure secure communication between clients and backend services by enforcing encrypted data transmission through SSL/TLS protocols.

This story focuses on configuring HTTPS listeners for an Application Load Balancer (ALB) or Classic Load Balancer in AWS, ensuring secure transmission of data. SSL/TLS certificates will be required to enable encrypted communication, and security best practices for protocols and cipher suites will be followed.

### Vision
By configuring ELB listeners for HTTPS or SSL protocols, we secure the communication between clients and backend servers, ensuring data is encrypted in transit and adhering to security best practices, such as using strong encryption algorithms and securing SSL certificates.

### Background
In AWS, Elastic Load Balancers (ELB) distribute traffic between backend services and clients. To secure communication, HTTPS (for ALB) or SSL (for Classic Load Balancers) can be configured as listener protocols. This ensures that all client communication is encrypted using SSL/TLS certificates. These certificates can be managed through AWS Certificate Manager (ACM) or imported manually if required.

## Details

### Steps for Configuring HTTPS/SSL on ELB

#### 1. **Prerequisites**
   - **SSL/TLS Certificate**: Obtain an SSL/TLS certificate. You can use AWS Certificate Manager (ACM) to create or import a certificate, or use a third-party certificate that you import manually into AWS.
     - To request a certificate from ACM:
       ```bash
       aws acm request-certificate --domain-name yourdomain.com --validation-method DNS
       ```
   - **Elastic Load Balancer (ALB or Classic)**: Ensure that an ALB or Classic Load Balancer is already set up. If not, create one using the AWS Console or AWS CLI.
   - **Security Groups**: Update the security groups attached to the ELB to allow inbound traffic on port 443 (HTTPS).

#### 2. **Configure HTTPS Listener for Application Load Balancer (ALB)**
   2.1. **Create or Modify an HTTPS Listener**:
   - For an existing ALB, modify the listeners to add or configure the HTTPS listener. This listener listens on port 443 and forwards traffic to backend targets using HTTP or HTTPS.

   Example AWS CLI command to create an HTTPS listener:
   ```bash
   aws elbv2 create-listener --load-balancer-arn <load-balancer-arn>      --protocol HTTPS --port 443      --certificates CertificateArn=<certificate-arn>      --default-actions Type=forward,TargetGroupArn=<target-group-arn>
   ```
   - **CertificateArn**: ARN of the SSL/TLS certificate (from ACM or manually imported).
   - **TargetGroupArn**: The ARN of the target group that the ALB forwards traffic to.

   2.2. **Configure SSL Policies**:
   - AWS provides predefined SSL policies that determine which protocols and ciphers the ALB uses to communicate with clients. Choose a policy based on security requirements (e.g., `ELBSecurityPolicy-2016-08` or `ELBSecurityPolicy-TLS-1-2-2017-01`).

   Example CLI command to modify the SSL policy:
   ```bash
   aws elbv2 modify-listener --listener-arn <listener-arn>      --ssl-policy ELBSecurityPolicy-TLS-1-2-2017-01
   ```

#### 3. **Configure SSL Listener for Classic Load Balancer**
   3.1. **Create or Modify an SSL Listener**:
   - For Classic Load Balancers, add an SSL listener that listens on port 443 and forwards traffic to backend instances using HTTP or HTTPS.

   Example AWS CLI command to create an SSL listener:
   ```bash
   aws elb create-load-balancer-listeners --load-balancer-name my-load-balancer      --listeners 'Protocol=SSL,LoadBalancerPort=443,InstanceProtocol=HTTP,InstancePort=80,SSLCertificateId=<certificate-arn>'
   ```
   - **SSLCertificateId**: The ID of the SSL certificate uploaded or managed by ACM.
   - **InstanceProtocol**: This can be set to HTTP or HTTPS, depending on whether the backend instance requires encrypted traffic.

   3.2. **Configure SSL Policies for Classic ELB**:
   - For Classic Load Balancers, use the `set-load-balancer-policies-of-listener` API to apply an SSL security policy.

   Example:
   ```bash
   aws elb set-load-balancer-policies-of-listener --load-balancer-name my-load-balancer      --load-balancer-port 443      --policy-names ELBSecurityPolicy-TLS-1-2-2017-01
   ```

#### 4. **Configure Backend Targets**
   - For ALB, ensure that the backend target group is configured with either HTTP or HTTPS protocol. If HTTPS is used between the ALB and targets, ensure the target instances have valid SSL certificates.
   - For Classic ELB, ensure the backend instances accept either HTTP or HTTPS traffic based on the configuration.

#### 5. **DNS Configuration**
   - Once the ELB is configured with HTTPS/SSL listeners, update your DNS records to point to the ELB. If using a custom domain name, ensure the DNS points to the load balancer’s public DNS or use an alias if you are using Route 53.

   Example command to create a DNS alias in Route 53:
   ```bash
   aws route53 change-resource-record-sets --hosted-zone-id <hosted-zone-id>      --change-batch file://dns-alias.json
   ```

   Example `dns-alias.json`:
   ```json
   {
     'Comment': 'Update record to point to ALB',
     'Changes': [
       {
         'Action': 'UPSERT',
         'ResourceRecordSet': {
           'Name': 'yourdomain.com',
           'Type': 'A',
           'AliasTarget': {
             'HostedZoneId': 'Z32O12XQLNTSW2',  // Example hosted zone ID
             'DNSName': 'my-load-balancer-1234567890.us-east-1.elb.amazonaws.com',
             'EvaluateTargetHealth': false
           }
         }
       }
     ]
   }
   ```

#### 6. **Monitoring and Validation**
   - Validate that the ELB is correctly handling HTTPS requests by testing with a web browser or tools like `curl` or Postman.
   - Example `curl` command to test the SSL connection:
     ```bash
     curl -I https://yourdomain.com
     ```
   - Monitor the load balancer in CloudWatch for SSL negotiation issues, errors, or traffic anomalies.

#### 7. **Enforce HTTPS Using Redirects (Optional)**
   - For ALB, you can enforce HTTPS by redirecting all HTTP traffic to HTTPS using a redirect action.
   - Example CLI command to create a listener rule for HTTP to HTTPS redirection:
   ```bash
   aws elbv2 create-rule --listener-arn <listener-arn> --priority 1      --conditions Field=host-header,HostHeaderConfig.Values=yourdomain.com      --actions Type=redirect,RedirectConfig='{Protocol=https,Port=443,StatusCode=HTTP_301}'
   ```

### SSL Certificate Renewal (If using ACM)
   - If using ACM, ensure that the certificate is set to automatically renew before expiration.
   - For third-party certificates, schedule regular manual updates and certificate uploads to prevent SSL expiration.

### Testing
- Validate that the HTTPS listener is correctly configured by visiting the website and inspecting the SSL certificate.
- Use SSL testing tools like **SSL Labs** or **OpenSSL** to ensure the site supports modern SSL/TLS protocols and uses secure cipher suites.
- Ensure HTTP to HTTPS redirection (if configured) works correctly.

### Acceptance Criteria
- Should have configured an HTTPS/SSL listener for the Elastic Load Balancer.
- Should have successfully applied SSL certificates using ACM or imported certificates.
- Should have tested the configuration to ensure secure HTTPS traffic is properly routed to backend instances.
- Should have monitoring and logging set up to track SSL negotiation and ELB traffic.
- Should have verified SSL policies for ensuring secure protocols and cipher suites are used.
