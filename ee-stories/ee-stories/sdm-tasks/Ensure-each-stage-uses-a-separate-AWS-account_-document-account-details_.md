## Using Separate AWS Accounts for Each Stage and Documenting Account Details

### Purpose
This document outlines the best practice of using separate AWS accounts for each stage of the deployment lifecycle (e.g., development, staging, production) and provides guidance for documenting and managing AWS account details. Using separate accounts helps improve security, minimize the risk of human error, and ensure resource isolation between environments.

---

### 1. **Why Use Separate AWS Accounts for Each Stage?**

#### **Security**:
- **Environment Isolation**: Using different AWS accounts for each environment (e.g., development, staging, and production) ensures that resources in one environment do not inadvertently affect others.
- **Least Privilege**: By segregating accounts, you can apply strict access control policies tailored to each environment, ensuring that users in the development environment have minimal access to production resources.

#### **Cost Management**:
- **Billing Isolation**: Separating accounts allows for better cost tracking and control, as AWS charges each account independently. You can apply specific budgets or limits to each account and monitor usage without mixing costs between environments.

#### **Compliance**:
- Different environments might have different compliance requirements (e.g., production may require stricter controls). Using separate accounts allows you to implement policies tailored to each environment’s specific needs.

#### **Resource Management**:
- **Environment-Specific Resources**: For instance, different VPCs, IAM policies, and EC2 instances can be provisioned for different environments, ensuring that resources are isolated and tailored for their specific use case.
- **Access Control**: IAM roles and policies can be configured to limit access to sensitive production data, while development teams can have unrestricted access to development resources.

---

### 2. **Account Details and Best Practices**

#### **Account Setup**:
- Create AWS accounts using **AWS Organizations** to centrally manage multiple accounts.
- Each stage (development, staging, production) should have its own AWS account within the organization.

#### **Account Structure**:
1. **Development Account**:
   - **Purpose**: For developers to build, test, and deploy code.
   - **Access Control**: More flexible permissions for developers and dev teams, with access to all non-sensitive resources.
   - **Region**: Typically, all regions are available, but resource deployment may be limited to a specific region for cost control.
   - **IAM Roles**: Developers can be assigned roles like **Developer** or **Admin**, depending on the necessary level of access.
   - **Cost**: This account should have the lowest cost but include resources for testing.

2. **Staging Account**:
   - **Purpose**: A pre-production environment to test and validate code before deployment to production.
   - **Access Control**: Only certain roles (e.g., QA, DevOps) should have access to this account, with minimal access to production environments.
   - **Region**: Same region as production, but isolated from production to prevent accidental changes.
   - **IAM Roles**: Roles like **QA** and **Staging Admin** can be used here to perform pre-production validation.
   - **Cost**: This account can have a higher cost, but it should not be as high as production.

3. **Production Account**:
   - **Purpose**: The live environment for running the application at scale.
   - **Access Control**: Strict permissions, only authorized personnel (e.g., Production Admins, Security, and Operations teams) should have access. Any direct access to production resources should be highly controlled.
   - **Region**: A multi-AZ setup to ensure high availability and fault tolerance. Choose the region that best supports your latency, cost, and compliance needs.
   - **IAM Roles**: **Production Admin** roles for administrative access, with **read-only** roles for auditors and compliance teams.
   - **Cost**: Production accounts should be optimized for performance and scale, but careful cost management is essential to avoid unexpected charges.

---

### 3. **Documenting Account Details**

For each account, you should document the following details:

#### **Account Details Table**

| **Account Name**      | **Purpose**                              | **Access Control**                                | **IAM Roles**                       | **Region(s)**                  | **Resource Isolation**    | **Cost Center/Tagging**       | **Compliance Requirements** |
|-----------------------|------------------------------------------|--------------------------------------------------|-------------------------------------|--------------------------------|----------------------------|-----------------------------|-----------------------------|
| **Dev Account**        | Development & testing environment        | Flexible access for developers                   | Developer, Admin                   | US-East-1                      | VPC isolation, IAM policies | Tag with `dev` and project name | Minimal compliance requirements |
| **Staging Account**    | Pre-production testing                   | Restricted access for QA and DevOps               | QA, Staging Admin                  | US-East-1                      | VPC isolation, IAM policies | Tag with `staging` and project name | Security policies for testing |
| **Production Account** | Live production environment             | Restricted, minimal access to authorized personnel | Production Admin, Read-Only Auditor | US-East-1, US-West-2            | VPC isolation, IAM policies | Tag with `prod` and project name  | Must meet compliance standards (e.g., SOC 2, GDPR) |

#### **AWS Account Identification Details**:
For each AWS account, document the following for administrative purposes:

- **Account ID**: Unique identifier for the AWS account.
- **Root Email**: Email address used to manage the account.
- **Account Name**: The name of the AWS account.
- **IAM User Names**: List of users with different roles (e.g., Admin, Developer, Read-Only).
- **Role Names**: Roles used for cross-account access and permissions.

#### **Example of Documenting Account Details**:
```markdown
### AWS Account: Development Account
- **Account ID**: 1234-5678-9012
- **Root Email**: devadmin@company.com
- **IAM Users**:
  - `dev-user-1` - Developer
  - `dev-user-2` - Developer
  - `dev-admin` - Admin
- **IAM Roles**:
  - `Developer` - Access to development and test resources.
  - `Admin` - Full access to all resources in the account.
- **Regions**: US-East-1
- **Cost Tag**: `env=dev, project=webapp`
- **Compliance**: Minimal (adherence to company internal security policies)
```

---

### 4. **Managing Cross-Account Access**
Cross-account access is useful when you need to manage resources across multiple accounts, such as for security monitoring or centralized logging.

#### **Cross-Account IAM Roles**:
- **Role Assumption**: Create **IAM roles** in the production account that can be assumed by users or services in the staging or development accounts. This ensures secure, controlled access to production resources when necessary.

#### **Example**:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::production-account-id:role/ProductionAdmin"
    }
  ]
}
```

---

### 5. **Automation and Infrastructure as Code (IaC)**

#### **Using AWS Organizations for Account Management**:
- AWS Organizations can help manage multiple AWS accounts by providing a centralized way to govern permissions, control billing, and enforce security policies across the accounts.

#### **Example AWS Organization Setup**:
- **Service Control Policies (SCPs)**: Use SCPs to enforce policies across all accounts, ensuring that certain actions (e.g., deleting resources or changing IAM policies) are prohibited in sensitive accounts like production.

#### **Using Terraform for Cross-Account Infrastructure**:
You can use **Terraform** or **CloudFormation** to automate the creation and management of resources in each AWS account, ensuring consistency across environments.

```hcl
module "prod-vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "prod-vpc"
  cidr = "10.0.0.0/16"
  azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
  enable_nat_gateway = true
  enable_vpn_gateway = false
}
```

---

### Acceptance Criteria
- **Separate AWS Accounts**: Ensure that each stage (development, staging, production) has a separate AWS account.
- **Access Control**: Implement strict IAM roles and policies per environment to ensure least privilege access.
- **Automation**: Use **IaC** tools to automate the deployment of resources across accounts.
- **Account Documentation**: Maintain detailed documentation for each AWS account, including account ID, IAM roles, and access control policies.

---

### Gherkin

**Feature**: Use Separate AWS Accounts for Each Stage
**Scenario**: Ensure each environment has a separate AWS account with detailed documentation
- **Given** the team uses separate AWS accounts for each stage,
- **When** resources are provisioned or modified,
- **Then** each environment should be isolated with appropriate IAM roles and policies, and all account details should be documented.

By following these best practices, the team ensures secure, scalable, and well-managed AWS infrastructure across multiple environments while minimizing risks associated with cross-environment access.
