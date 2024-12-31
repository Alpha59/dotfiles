## Summary
**As a** cloud administrator or DevOps engineer, **I want** to issue **AWS ACM certificates** for all necessary components in the service, **so that** secure communication (SSL/TLS) can be ensured between different parts of the infrastructure, reducing the risk of unauthorized access or data breaches.

AWS Certificate Manager (ACM) allows for easy provisioning and management of SSL/TLS certificates, which can be used for securing communication across services like Load Balancers (ELB), API Gateway, CloudFront, and other components that require secure HTTPS communication. Issuing and attaching these certificates ensures encrypted connections and better security for the service.

### Vision
By issuing ACM certificates for all necessary components, the team will ensure that all service communications are encrypted and secure, preventing potential security breaches or data leaks due to unencrypted connections. This will also help ensure compliance with industry security standards.

### Background
In a distributed service architecture, multiple components often communicate over the internet or internal networks. Without SSL/TLS encryption, this communication is vulnerable to interception and tampering. AWS ACM simplifies the process of managing SSL/TLS certificates by automating renewals and providing integration with services like Elastic Load Balancers (ELB), API Gateway, and CloudFront.

### Purpose
The purpose of this story is to issue and configure AWS ACM certificates for all necessary service components to secure communication and ensure compliance with best security practices.

## Details

### 1. **Identify Components That Require Certificates**
   - Components that require SSL/TLS certificates for secure communication:
     - **Elastic Load Balancer (ALB/NLB)**
     - **API Gateway**
     - **CloudFront Distributions**
     - **Custom Domain Names in Route 53**
     - **EC2 Instances (if necessary)**

   **Example Components**:
   - **ALB**: Handling incoming traffic for microservices.
   - **API Gateway**: Exposing APIs for external users or services.
   - **CloudFront**: Serving content securely via a CDN.

### 2. **Request SSL/TLS Certificates Using AWS ACM**
   - Request SSL/TLS certificates through AWS ACM for all relevant domains, subdomains, or service endpoints.
   - You can request public or private certificates depending on whether you need certificates for public-facing services or internal communication.

   **Example AWS CLI to Request a Public Certificate**:
   ```bash
   aws acm request-certificate \
     --domain-name "example.com" \
     --subject-alternative-names "*.example.com" \
     --validation-method DNS \
     --idempotency-token 12345
   ```

   - For internal services, use **Private Certificate Authorities (CA)** in ACM to issue certificates for non-public services.

   **Example to Request a Private Certificate**:
   ```bash
   aws acm request-certificate \
     --domain-name "internal.example.com" \
     --certificate-authority-arn arn:aws:acm-pca:region:account-id:certificate-authority/12345 \
     --validation-method DNS
   ```

### 3. **Validate the Certificates**
   - Validate certificates using DNS or email validation (for public certificates) or automatically for private certificates.
   - If using DNS validation, you will need to add a DNS record to your domain in **Route 53** or other DNS providers.

   **Example DNS Validation Using Route 53**:
   ```bash
   aws route53 change-resource-record-sets --hosted-zone-id ZONE_ID --change-batch '{
       "Changes": [{
           "Action": "CREATE",
           "ResourceRecordSet": {
               "Name": "_abcde.example.com",
               "Type": "CNAME",
               "TTL": 60,
               "ResourceRecords": [{"Value": "_validation.example.com"}]
           }
       }]
   }'
   ```

   After validation, the certificate status should change to **"Issued"** in AWS ACM.

### 4. **Associate ACM Certificates with Service Components**

#### a. **Elastic Load Balancer (ALB/NLB)**
   - Attach the issued certificate to your Application Load Balancer (ALB) or Network Load Balancer (NLB) to ensure that HTTPS traffic is secured.

   **Example to Attach Certificate to ALB**:
   ```bash
   aws elbv2 create-listener \
     --load-balancer-arn arn:aws:elasticloadbalancing:region:account-id:loadbalancer/app/my-alb \
     --protocol HTTPS \
     --port 443 \
     --certificates CertificateArn=arn:aws:acm:region:account-id:certificate/certificate-id \
     --default-actions Type=forward,TargetGroupArn=arn:aws:elasticloadbalancing:region:account-id:targetgroup/my-target-group
   ```

   - For each service using the ALB, ensure the HTTPS listener and certificate are correctly configured.

#### b. **API Gateway**
   - Associate the ACM certificate with a custom domain for an API Gateway, ensuring that any traffic to your API is encrypted.

   **Example to Associate ACM Certificate with API Gateway**:
   ```bash
   aws apigateway create-domain-name \
     --domain-name "api.example.com" \
     --certificate-arn arn:aws:acm:region:account-id:certificate/certificate-id
   ```

   - Update the API Gateway mappings to route traffic through the custom domain using the issued certificate.

#### c. **CloudFront Distribution**
   - Attach the issued ACM certificate to your **CloudFront** distribution to serve HTTPS content from your CDN.

   **Example to Attach Certificate to CloudFront**:
   ```bash
   aws cloudfront create-distribution --distribution-config '{
     "CallerReference": "unique-string",
     "Aliases": {
       "Quantity": 1,
       "Items": ["example.com"]
     },
     "ViewerCertificate": {
       "ACMCertificateArn": "arn:aws:acm:region:account-id:certificate/certificate-id",
       "SSLSupportMethod": "sni-only",
       "MinimumProtocolVersion": "TLSv1.2_2019"
     }
   }'
   ```

#### d. **Custom Domain in Route 53**
   - For any custom domains in **Route 53** that require SSL/TLS encryption, attach the ACM certificate to secure access via HTTPS.

### 5. **Set Up Automatic Renewal for ACM Certificates**
   - AWS ACM automatically renews certificates before they expire, as long as they are in use with services like ELB, API Gateway, or CloudFront.
   - Monitor the **certificate renewal process** using **CloudWatch** and ensure that certificates are automatically updated without downtime.

   **Monitor Certificate Renewal Status**:
   - Use CloudWatch metrics to monitor certificate renewal status and set up alarms if a certificate renewal fails.

   **Example CloudWatch Alarm for Certificate Expiry**:
   ```bash
   aws cloudwatch put-metric-alarm \
     --alarm-name "CertExpirationAlarm" \
     --metric-name "DaysToExpiry" \
     --namespace "AWS/CertificateManager" \
     --statistic "Minimum" \
     --period 86400 \
     --threshold 30 \
     --comparison-operator "LessThanThreshold" \
     --evaluation-periods 1 \
     --alarm-actions arn:aws:sns:region:account-id:MySNSTopic
   ```

### 6. **Testing the Certificates**
   - Test each component to ensure that SSL/TLS encryption is functioning correctly.
   - Use tools like **SSL Labs** to test the security of the certificate, ensuring that all best practices (e.g., TLSv1.2 or higher) are followed.

   **Example Test Using curl**:
   ```bash
   curl -v https://api.example.com
   ```

   - Verify that the connection uses the correct SSL certificate and protocol (e.g., TLS 1.2 or TLS 1.3).

### Testing
- Verify that all services (e.g., API Gateway, ALB, CloudFront) are correctly using the ACM certificates.
- Test the automatic renewal process by monitoring for upcoming certificate expirations and ensuring that certificates are renewed without downtime.
- Perform penetration tests or use SSL testing tools (e.g., SSL Labs) to ensure the security of each certificate and component.

### Acceptance Criteria
- Should issue ACM certificates for all necessary service components (ALB, API Gateway, CloudFront, etc.).
- Should associate the certificates with all relevant services to enable SSL/TLS encryption.
- Should ensure automatic renewal is set up for all ACM certificates and monitor the renewal status.
- Should test each service to confirm that SSL/TLS encryption is functioning properly.
- Should provide alerts or notifications for any issues with certificate expiration or renewal.

### External Links
- [AWS ACM Documentation](https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html)
- [Using ACM with Elastic Load Balancing](https://docs.aws.amazon.com/acm/latest/userguide/acm-services.html#elasticloadbalancing)
- [Using ACM with API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-custom-domains.html)
- [Using ACM with CloudFront](https://docs.aws.amazon.com/acm/latest/userguide/acm-services.html#cloudfront)
