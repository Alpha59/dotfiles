## Summary
**As a** cloud infrastructure engineer, **I want** to review all SSL certificates and ensure that they are stored in AWS Certificate Manager (ACM), **so that** we can simplify certificate management, enable automatic renewals, and ensure that the system remains secure and compliant with best practices.

This review will involve identifying all SSL certificates in use across the system, ensuring that they are properly stored in ACM, and migrating any manually managed certificates to ACM where possible. Using ACM will reduce the risk of expired certificates causing service outages and streamline the management of SSL certificates across AWS services.

### Vision
By storing all SSL certificates in AWS Certificate Manager (ACM), we can automate the renewal of certificates, improve security by using centrally managed certificates, and ensure compliance with best practices for managing SSL/TLS certificates. This will reduce manual overhead, prevent certificate expiration incidents, and simplify the management of certificates across multiple AWS services.

### Background
Currently, SSL certificates may be stored manually in various places, such as on EC2 instances or within custom configurations, making it difficult to track, renew, and manage them consistently. Manual certificate management increases the risk of certificates expiring and causing service interruptions. AWS ACM offers an automated solution for managing certificates, including renewals, making it easier to maintain security and availability.

### Purpose
The purpose of this story is to review all SSL certificates in use, ensure that they are migrated to and managed by AWS ACM, and implement automatic renewals. This will improve security, reduce the risk of certificate expiration, and streamline the management of SSL certificates across the infrastructure.

## Details

### 1. **Identify All SSL Certificates**
   - **Inventory Existing Certificates**:
     - Identify all SSL certificates currently in use across the system, including:
       - Certificates used for load balancers (e.g., ALB, NLB).
       - Certificates used on EC2 instances or web servers (e.g., Nginx, Apache).
       - Certificates for internal services or API gateways.
     - Document the current storage location and expiration date for each certificate.

   - **Check for Expiration Dates**:
     - For each identified certificate, check its expiration date to prioritize certificates that are close to expiring.
     - Ensure that no certificate is set to expire soon without a plan for renewal.

### 2. **Verify SSL Certificates in ACM**
   - **Check ACM for Stored Certificates**:
     - Review the AWS ACM console to verify which certificates are already stored and managed by ACM.
     - Identify any certificates that are missing from ACM but are in use across the system.

### 3. **Migrate Manually Managed Certificates to ACM**
   - **Issue New Certificates in ACM**:
     - For certificates not already in ACM, issue new certificates via ACM. This includes certificates for public-facing services (e.g., websites, APIs) and internal services where applicable.
     - Use DNS or email validation to confirm ownership of the domain for new ACM certificates.

   - **Replace Manually Managed Certificates**:
     - Replace existing manually managed certificates with ACM-managed certificates. This includes updating configurations on services like Elastic Load Balancers (ELBs), API Gateway, or EC2 instances to use the new ACM certificates.

   - **Ensure Zero Downtime Migration**:
     - Plan certificate migrations carefully to avoid downtime. For services that cannot tolerate downtime, apply new ACM certificates in a staged manner, ensuring there is no service disruption during the transition.

### 4. **Enable Automatic Renewal**
   - **Configure ACM Auto-Renewal**:
     - Ensure that all certificates managed by ACM are set to renew automatically. This will prevent certificates from expiring and causing service outages.
     - Confirm that any necessary DNS records for certificate validation are properly configured to allow automatic renewal without manual intervention.

### 5. **Monitoring and Alerts**
   - **Set up Expiration Alerts**:
     - Configure alerts (e.g., AWS CloudWatch) to notify the team if any SSL certificate is approaching its expiration date and is not set for automatic renewal.
     - Ensure that alerts are configured for all certificates, including those that are managed outside of ACM (if any remain).

   - **Monitor Certificate Health**:
     - Use monitoring tools to track the health of SSL certificates and ensure that they remain valid, trusted, and properly configured across all services.

### 6. **Documentation and Best Practices**
   - **Document SSL Certificate Locations**:
     - Update internal documentation to reflect where all SSL certificates are stored and how they are managed (ACM or otherwise).

   - **Best Practices for SSL/TLS**:
     - Ensure that SSL certificates follow best practices, including:
       - Using strong encryption algorithms.
       - Enforcing HTTPS for all public-facing services.
       - Periodically reviewing and rotating certificates for added security.

### Testing
- **Test Certificate Migration**:
   - Test the migration of certificates from manual management to ACM by deploying ACM certificates in a non-production environment and verifying that the service operates correctly with the new certificates.

- **Test Auto-Renewal**:
   - Simulate the auto-renewal process by issuing a short-term certificate in ACM and verifying that it is renewed automatically before expiration.

- **Service Validation**:
   - Test each service (e.g., API Gateway, ELB) after switching to ACM certificates to ensure that SSL/TLS is functioning correctly and the certificate is properly installed and trusted.

### External Dependencies
- DNS configuration for domain validation when issuing new SSL certificates via ACM.
- Existing SSL certificates on third-party services (if applicable) that may need to be replaced.

## Acceptance Criteria
- Should have all SSL certificates identified and documented.
- Should have all SSL certificates stored and managed in ACM where possible.
- Should have automatic renewals enabled for all ACM-managed certificates.
- Should have alerts and monitoring configured to track certificate expiration and health.
- Should have migration tested and verified in a non-production environment before applying to production.

### Gherkin
```gherkin
Given an SSL certificate is in use on a service
When the service is reviewed for certificate management
Then the certificate should be migrated to AWS ACM
And automatic renewal should be enabled to prevent expiration.
```

## API
N/A

## External Links
- [AWS Certificate Manager (ACM) Documentation](https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html)
- [AWS CloudWatch Alarms for Certificate Expiration](https://docs.aws.amazon.com/acm/latest/userguide/acm-certificate-expiration-notifications.html)
- [SSL/TLS Best Practices](https://www.ssllabs.com/projects/best-practices/)
