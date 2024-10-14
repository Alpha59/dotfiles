
# Define data policy compliant with customer and customer device data in both North America And EU for retaining and removing data
### Summary
**As a** Compliance Officer or Data Governance Specialist, **I want** to define a data retention and removal policy that complies with both North American (NA) and European Union (EU) regulations concerning customer and customer device data, **So That** we adhere to regional legal requirements while protecting customer privacy and managing data efficiently.

This policy outlines how customer data and customer device data should be retained and removed, in compliance with relevant regulations such as the **General Data Protection Regulation (GDPR)** in the EU and **Consumer Privacy Regulations** (such as the **California Consumer Privacy Act (CCPA)**) in North America.

### Vision
The goal of this policy is to ensure that customer and customer device data is retained only as long as necessary for the specified purposes and that it is securely removed after that time in accordance with both North American and European Union legal frameworks. This will minimize risks related to data breaches, ensure compliance with privacy regulations, and build customer trust.

### Background
North America and the EU have different regulations governing data retention and privacy. The **GDPR** in the EU mandates strict controls over how customer data is stored, processed, and deleted, giving customers the 'right to be forgotten.' In North America, laws such as the **CCPA** and industry-specific regulations (e.g., HIPAA for healthcare data) define how companies must handle customer data, with a focus on transparency, consent, and data access. An organization that operates across both regions must develop a compliant data retention and removal policy that satisfies both sets of regulations.

### Purpose
The purpose of this data policy is to outline compliant processes for retaining and removing customer and customer device data to meet the privacy regulations of both North America and the EU. It establishes guidelines for how long data is retained, how it is securely deleted, and under what conditions customer requests for data removal or access are fulfilled.

## Data Policy Outline
### 1. Definitions
#### **Customer Data**
Refers to any information that relates to an identified or identifiable individual, including personal data such as names, email addresses, phone numbers, payment information, and purchase history.

#### **Customer  Data**
Refers to data collected from devices that are linked to an individual customer, including IoT devices, smartphones, computers, and other connected devices. This data may include usage statistics, geolocation data, device identifiers (e.g., MAC address), and diagnostic information.

### 2. Data Retention Policy
The data retention policy will define how long customer data and customer device data is kept based on the type of data, regulatory requirements, and business needs.

#### 2.1 General Retention Guidelines
- **Minimum Necessary**: Data should be retained only as long as it is necessary for the original purpose for which it was collected or as required by law.
- **Purpose Limitation**: Data may not be used for any other purpose beyond what was originally specified unless explicit consent is obtained from the customer.

#### 2.2 Retention Periods
Different data types should have specific retention periods based on legal and business requirements:

| Data Type                    | Retention Period NA (CCPA)    | Retention Period EU (GDPR)  | Justification                               |
|------------------------------|-------------------------------|-----------------------------|--------------------------------------------|
| **Personal Identifiable Information (PII)** | As required for business purposes or 7 years after the customer relationship ends, whichever is shorter | Until consent is withdrawn or purpose fulfilled, typically up to 7 years | Aligns with financial reporting and contractual obligations |
| **Customer Transaction Data** | 5 years from the date of transaction completion | 5 years from the date of transaction completion | Regulatory requirement for tax and audit |
| ** Usage and Diagnostics Data** | 2 years from the date of collection | 2 years or until customer requests deletion | Shorter retention based on diagnostic need |
| **Marketing Data (e.g., Email Lists)** | 1 year after last customer interaction or until consent withdrawn | 1 year after last customer interaction or until consent withdrawn | Consent-based marketing retention policy |
| **Payment Information**        | Immediately deleted after transaction completion unless otherwise required for recurring payments | Immediately deleted after transaction completion unless recurring payments | PCI-DSS compliance, sensitive data retention |
| **Customer Support Data**      | 2 years after case closure | 2 years after case closure | For audit and customer support tracking |
| **Legal and Compliance Data**  | As required by applicable law (e.g., 7 years for financial records) | As required by applicable law (e.g., 7 years for financial records) | Compliance with legal obligations |

#### 2.3 Exceptions to Retention Periods
- **Legal Obligations**: Some data may need to be retained beyond the standard period for legal or regulatory reasons (e.g., court orders, fraud investigations).
- **Customer Requests**: Customers in both North America and the EU have the right to request their data be deleted ('Right to be Forgotten'). Exceptions apply for data that must be retained for legal or contractual reasons.

### 3. Data Removal Policy
The data removal policy defines how customer and device data is securely deleted once it reaches the end of its retention period or upon customer request, in accordance with GDPR and CCPA requirements.

#### 3.1 Secure Deletion
All data should be securely deleted or anonymized in a way that ensures it cannot be reconstructed or recovered.

- **Permanent Deletion**: Use methods such as secure deletion (e.g., cryptographic erasure or secure wiping) to ensure that data is irrecoverable.
- **Anonymization**: If data must be retained for analytics or business purposes, it should be anonymized in compliance with GDPR and CCPA requirements, ensuring that no individual can be identified from the data.

#### 3.2 Customer Data Deletion Requests
- **GDPR (EU)**: Customers have the right to request that their personal data be deleted (Right to be Forgotten). Requests must be fulfilled within 30 days of receipt, except where the data must be retained for legal or contractual reasons.
- **CCPA (NA)**: Customers have the right to request that their personal data be deleted. Companies must comply within 45 days unless an exception applies, such as data required to complete a transaction or meet legal obligations.

#### 3.3 Data Removal Process
For each type of customer and device data, the data removal process includes:
  - **Trigger**: Data is marked for deletion either when the retention period ends or upon a valid customer request.
  - **Verification**: A validation process to ensure the data is no longer required by any legal, regulatory, or business needs.
  - **Deletion**: Use of secure deletion methods such as data wiping or cryptographic erasure.
  - **Confirmation**: A confirmation step, providing either an internal log of the deletion or a notification to the customer that their request has been fulfilled (for GDPR/CCPA).

#### 3.4 Data Deletion in Backups and Archives
Data retained in backups or archives must also be securely deleted once it reaches the end of its retention period or is subject to a customer deletion request:
- **Backup Retention**: Specify how long backup copies are kept and ensure that expired data is removed from those backups. This might involve periodic backup rotation and deletion processes.
- **Audit Trail**: Keep a record of the data deletion process for compliance purposes, including details of what data was deleted and when.

### 4. Compliance with GDPR (EU)
To comply with GDPR in the EU, the following principles must be adhered to:
  - **Lawfulness, Fairness, and Transparency**: Ensure that customers are informed about how their data is being used and retained, and obtain explicit consent for data collection where required.
  - **Purpose Limitation**: Only collect and retain data for the specific purpose stated to the customer.
  - **Data Minimization**: Collect and retain only the minimum amount of data necessary for the purpose.
  - **Accuracy**: Ensure that data is accurate and kept up-to-date. If it is no longer needed or inaccurate, it should be deleted or corrected.
  - **Right to Erasure**: Customers can request the deletion of their data, and this must be fulfilled within 30 days.
  - **Accountability and Documentation**: Maintain records of data processing activities, retention schedules, and deletion logs.

### 5. Compliance with CCPA (NA)
To comply with CCPA in North America, the following principles must be followed:
  - **Right to Know**: Customers can request to know what personal data is being collected and how long it will be retained.
  - **Right to Delete**: Customers can request that their personal data be deleted, with certain exceptions (e.g., data required to complete transactions or comply with legal obligations).
  - **Right to Opt-Out**: Customers can opt out of the sale of their personal data.
  - **Data Retention Transparency**: Clearly communicate the retention period for customer data, and delete data when it is no longer needed.

### 6. Customer Notification and Consent Management
- **Data Retention Policy Disclosure**: Customers should be informed of the data retention and deletion policy through the privacy policy or other communication channels.
- **Consent Management**: Ensure that consent for data collection, retention, and processing is obtained where necessary, and allow customers to withdraw consent at any time.

### 7. Monitoring and Auditing
- **Automated Monitoring**: Implement automated monitoring to track data retention periods and trigger alerts when data reaches the end of its retention period.
- **Auditing**: Conduct regular audits of data retention and deletion processes to ensure compliance with GDPR and CCPA, and maintain an audit trail of deletion activities.

### Testing
- **Data Retention Test**: Ensure that customer and device data is retained for the appropriate duration and that alerts are triggered when the retention period is nearing its end.
- **Data Deletion Test**: Test the secure deletion process to confirm that data is deleted from both primary systems and backups.
- **Compliance Test**: Conduct regular audits to verify that the data retention and removal processes comply with GDPR and CCPA requirements.

### External Dependencies
- **S3 Lifecycle Policies**: For managing the deletion of data stored in AWS.
- **Data Retention and Deletion Automation Tools**: Tools for automating the enforcement of retention schedules and secure deletion.
- **Customer Consent Management Systems**: To manage customer opt-ins, opt-outs, and data deletion requests.

## Acceptance Criteria
- Should have defined retention periods for all types of customer and device data that comply with GDPR and CCPA.
- Should have implemented secure deletion processes that adhere to both GDPR and CCPA requirements.
- Should have mechanisms in place to handle customer data deletion requests within the required timeframes (30 days for GDPR, 45 days for CCPA).
- Should have automated monitoring in place to trigger data deletion when retention periods end.
- Should have conducted audits to ensure compliance with retention and deletion policies.

## External Links
- [GDPR Compliance Guide](https://gdpr.eu/)
- [CCPA Compliance Guide](https://oag.ca.gov/privacy/ccpa)
