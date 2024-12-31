## Summary
**As a** cloud infrastructure manager, **I want** to document all custom EC2 AMIs (Amazon Machine Images) used in our AWS environments for non-production and production accounts **so that** we can manage and track the versions, security configurations, and usage of these images across different environments efficiently.

### Vision
The vision for this documentation is to maintain a clear and controlled repository of custom AMIs, ensuring that each environment—from development to production—uses the appropriate, secure, and approved image. This will help in maintaining operational consistency, security compliance, and swift deployment capabilities.

### Background
Our deployment process across AWS environments currently utilizes various custom EC2 AMIs. However, there's a lack of comprehensive documentation detailing these AMIs and their specific purposes, leading to potential risks in security and configuration drifts between environments.

### Purpose
The purpose of this documentation is to catalog all custom EC2 AMIs used within our organization, specifying their configurations, intended use cases, and deployment environments. This will aid in better resource management, enhance security measures, and support audit processes.

## Documented Custom EC2 AMIs

### Table of Custom EC2 AMIs

| AMI ID           | Description                                 | Base Image  | Environment Used | Security Configuration                   | Version Control                  |
|------------------|---------------------------------------------|-------------|------------------|-----------------------------------------|----------------------------------|
| **ami-0abcd1234** | Base AMI for web servers                   | Ubuntu 20.04 | Non-prod         | Hardened according to CIS benchmarks    | Tagged with build number         |
| **ami-0defg5678** | Optimized AMI for compute-heavy tasks      | Amazon Linux 2 | Non-prod, Prod  | Encrypted EBS volumes, no root login    | Versioned quarterly              |
| **ami-0hijk9012** | Data processing AMI with pre-installed tools | Ubuntu 18.04 | Non-prod         | Network access restricted to internal   | Linked to specific project sprints |
| **ami-0lmno3456** | High-security AMI for sensitive data handling | Ubuntu 20.04 | Prod            | SELinux enforced, audit logging enabled | Managed with Git SHA             |
| **ami-0pqr6789** | General-purpose AMI for backend services    | Amazon Linux 2 | Non-prod, Prod  | Standard security group settings        | Continuous updates from latest release |

### Version Control and Image Updates
- **Image Registry**: All custom AMIs are registered and managed within the AWS EC2 AMI service, with access restricted based on roles.
- **Update Policy**: Custom AMIs are updated bi-annually or as needed for security patches. Changes are tracked through an internal version control system linked to change logs.

### Security and Compliance
- **Security Baseline**: Each AMI adheres to a predefined security baseline that includes OS hardening, pre-installed security agents, and configuration according to the least privilege principle.
- **Compliance Audits**: Regular audits are conducted to ensure all custom AMIs meet our internal security standards and regulatory requirements.

### Monitoring and Maintenance
- **AMI Deprecation**: Outdated AMIs are deprecated with advance notice to all stakeholders, followed by a phased removal process.
- **Usage Tracking**: Automated tools track the usage of each AMI to prevent unauthorized or unintended deployments.

### External Dependencies
- **Third-party Security Tools**: Integration with tools like Trend Micro for real-time monitoring and alerting on security issues.
- **AWS Services**: Reliance on AWS services like AWS Systems Manager for patch management and AWS IAM for access control.

## Acceptance Criteria
- Should have a complete inventory of all custom EC2 AMIs currently in use across non-prod and prod environments.
- Should have documented security configurations for each AMI.
- Should have a process in place for the regular updating and deprecation of AMIs.

### Gherkin
Given an environment requires a deployment,
When selecting an AMI for deployment,
Then only AMIs that are approved, secure, and appropriate for the specific environment should be available for use.

By documenting and managing these custom EC2 AMIs effectively, we ensure that our AWS environments are secure, consistent, and in line with our operational standards and compliance requirements.
