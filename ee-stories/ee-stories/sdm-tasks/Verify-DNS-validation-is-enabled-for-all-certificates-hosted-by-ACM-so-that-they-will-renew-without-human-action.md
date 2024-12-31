## Summary
**As a** cloud operations engineer, **I want** to verify that DNS validation is enabled for all certificates hosted by AWS Certificate Manager (ACM) **so that** the certificates can automatically renew without requiring human intervention, ensuring uninterrupted service and enhanced security.

### Vision
The vision for this task is to provide a seamless, automated process for certificate renewal that minimizes the risk of service disruption due to expired certificates and reduces the manual workload on our team.

### Background
DNS validation allows ACM to automatically renew certificates by verifying domain ownership through DNS records. However, there's a need to confirm that all our ACM-hosted certificates are properly configured for DNS validation, as any oversight could lead to failed renewals and service interruptions.

### Purpose
The purpose of this verification is to ensure that all ACM certificates are set up correctly to utilize DNS validation for renewals, thereby improving our security posture and operational efficiency.

## Verification Steps

### 1. **List All ACM Certificates**
   - **Action**: Use the AWS Command Line Interface (CLI) or Management Console to list all certificates managed by ACM.
   - **Command**:
     ```
     aws acm list-certificates --certificate-statuses ISSUED
     ```

### 2. **Check DNS Validation Configuration**
   - **Action**: For each certificate listed, check the validation method specified.
   - **Command**:
     ```
     aws acm describe-certificate --certificate-arn <CertificateArn>
     ```
   - **Expected Output**: Ensure that the `ValidationMethod` is set to `DNS`.

### 3. **Review DNS Records**
   - **Action**: Confirm that the required DNS records (CNAME provided by ACM for validation) are present in the DNS configuration of the domain.
   - **Tool**: Use DNS lookup tools or directly query the DNS configuration to check for the presence of ACM DNS validation records.

### 4. **Automate Monitoring and Alerts**
   - **Action**: Set up monitoring to alert if a certificate's validation method changes or if DNS records are missing or incorrect.
   - **Implementation**: Use AWS CloudWatch to monitor ACM event history and trigger SNS notifications for any changes affecting DNS validation.

### 5. **Document Verification Process**
   - **Action**: Maintain documentation on the process and results of DNS validation checks for all ACM certificates.
   - **Purpose**: Ensures continuity and serves as a reference for future audits and compliance checks.

## Acceptance Criteria
- Should have confirmed that all ACM-managed certificates use DNS validation.
- Should have verified the correctness and presence of DNS validation records for each certificate.
- Should have set up automated monitoring and alerts for DNS validation status.

### Gherkin
Given a certificate managed by ACM,
When it is time for the certificate to renew,
Then the system should automatically renew the certificate using DNS validation without any errors or manual intervention.

## External Dependencies
- **DNS Provider Cooperation**: Coordination with the DNS provider to ensure timely updates to DNS records as required by ACM.
- **AWS Services**: Dependency on ACM for managing certificates and CloudWatch for monitoring.

By verifying and ensuring that DNS validation is enabled for all certificates hosted by ACM, we mitigate the risk of certificate expiration issues and enhance our operational resilience. This approach not only safeguards our services but also aligns with best practices for automated certificate management.
