## Summary
**As a** system reliability engineer, **I want** to determine if each of our service components has the required minimum number of hosts per Availability Zone (AZ) in every region for regional services, or 3 hosts per AZ for Availability Zone Isolated (AZI) services **so that** we can ensure high availability, fault tolerance, and compliance with our architectural standards.

### Vision
The vision for this assessment is to solidify our infrastructure's resilience and reliability by ensuring all components are appropriately distributed across Availability Zones and regions according to their service classification (regional or AZI).

### Background
Our services are deployed across multiple AWS regions and AZs to enhance fault tolerance and minimize latency for users. Correct host distribution is crucial for maintaining service availability during AZ outages and for balancing loads effectively across the infrastructure.

### Purpose
The purpose of this assessment is to verify that our deployment strategy aligns with best practices for high availability and disaster recovery, particularly focusing on the sufficiency of host distribution per AZ in line with service requirements.

## Methodology for Determination

### 1. **Inventory of Service Components**
   - **Action**: Compile a comprehensive list of all service components, including databases, application servers, caching layers, and backend services.
   - **Data Source**: Infrastructure as Code (IaC) definitions, AWS Management Console, and internal service registries.

### 2. **Classification of Services**
   - **Action**: Classify each service as either regional or AZI based on their operational requirements and design specifications.
   - **Criteria**:
     - **Regional Service**: Requires at least 1 host per AZ in each region it operates.
     - **AZI Service**: Requires a minimum of 3 hosts per AZ to ensure higher fault tolerance.

### 3. **Current Host Distribution**
   - **Action**: Review current deployment configurations to determine the number of hosts each service component has in each AZ.
   - **Tools**: AWS EC2 Dashboard, AWS CLI, and custom scripts to query AWS APIs.

### 4. **Assessment of Compliance**
   - **Action**: Compare the actual host distribution against the required minimums for regional and AZI services.
   - **Method**:
     - For regional services, ensure there is at least 1 host per AZ in every region.
     - For AZI services, verify there are at least 3 hosts per AZ.

### 5. **Document Findings and Recommendations**
   - **Action**: Document any discrepancies, risks, or non-compliance issues. Provide recommendations for alignment with best practices.
   - **Format**: Internal report with detailed tables, graphs, and actionable steps for remediation.

## Acceptance Criteria
- Should have a detailed report that shows host distribution for each service component across AZs and regions.
- Should identify any components that do not meet the minimum host requirements.
- Should provide recommendations for adjustments where necessary to ensure compliance with the defined architectural standards.

### Gherkin
Given the existing host distribution data,
When analyzed against the regional and AZI service requirements,
Then the report should indicate whether each service component complies with the minimum host distribution standards.

By completing this assessment, we aim to enhance our system's resilience against regional failures, optimize load distribution, and maintain continuous service availability, thereby upholding our commitment to reliability and customer satisfaction.
