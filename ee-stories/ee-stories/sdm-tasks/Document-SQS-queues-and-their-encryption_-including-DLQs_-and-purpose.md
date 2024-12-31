## SQS Queues Documentation: Encryption, DLQs, and Purpose

### Purpose
To document all SQS queues in the system, detailing their encryption configurations, Dead Letter Queues (DLQs), and primary purposes. This ensures alignment with security best practices, facilitates troubleshooting, and improves operational transparency.

---

### SQS Queues Overview

| **Queue Name**            | **Purpose**                                      | **Encryption**        | **DLQ**                     | **Retention Period** | **Visibility Timeout** |
|----------------------------|--------------------------------------------------|------------------------|-----------------------------|-----------------------|-------------------------|
| **OrderProcessingQueue**  | Handles order processing requests.               | AWS-managed SSE (AES-256) | **OrderProcessingDLQ**     | 4 days               | 30 seconds             |
| **NotificationQueue**     | Sends notifications (e.g., emails, SMS).         | AWS-managed SSE (AES-256) | **NotificationDLQ**        | 2 days               | 20 seconds             |
| **PaymentQueue**          | Processes payment-related messages.              | AWS-managed SSE (AES-256) | **PaymentDLQ**             | 5 days               | 60 seconds             |
| **InventoryUpdateQueue**  | Updates inventory records asynchronously.         | AWS-managed SSE (AES-256) | **InventoryUpdateDLQ**     | 4 days               | 45 seconds             |
| **ShippingQueue**         | Handles shipping requests for order fulfillment. | AWS-managed SSE (AES-256) | **ShippingDLQ**            | 7 days               | 60 seconds             |
| **DataSyncQueue**         | Synchronizes data between services.              | Customer-managed CMK   | **DataSyncDLQ**            | 14 days              | 90 seconds             |

---

### Detailed Documentation

#### 1. **OrderProcessingQueue**
- **Purpose**: Processes customer orders and initiates downstream services (e.g., payment, inventory update).
- **Encryption**: AWS-managed SSE (AES-256) ensures data at rest is encrypted by default.
- **DLQ**: **OrderProcessingDLQ**
  - **Purpose**: Captures messages that fail to process after 3 retries.
  - **Retention Period**: 7 days.
- **Notes**: Monitored with CloudWatch for message age and visibility timeout breaches.

#### 2. **NotificationQueue**
- **Purpose**: Sends notifications to customers, including order confirmations and promotional messages.
- **Encryption**: AWS-managed SSE (AES-256).
- **DLQ**: **NotificationDLQ**
  - **Purpose**: Stores messages that fail delivery due to service unavailability.
  - **Retention Period**: 5 days.
- **Notes**: Integrated with SNS for multi-channel notifications.

#### 3. **PaymentQueue**
- **Purpose**: Processes payment transactions and communicates with the payment gateway.
- **Encryption**: AWS-managed SSE (AES-256).
- **DLQ**: **PaymentDLQ**
  - **Purpose**: Captures failed payment messages for manual review.
  - **Retention Period**: 7 days.
- **Notes**: Configured with high visibility timeout due to external API dependencies.

#### 4. **InventoryUpdateQueue**
- **Purpose**: Updates inventory levels based on completed orders or returns.
- **Encryption**: AWS-managed SSE (AES-256).
- **DLQ**: **InventoryUpdateDLQ**
  - **Purpose**: Stores messages that cannot update inventory due to system errors.
  - **Retention Period**: 7 days.
- **Notes**: Supports high-throughput scenarios; latency monitored via CloudWatch.

#### 5. **ShippingQueue**
- **Purpose**: Coordinates shipping label generation and tracking with logistics providers.
- **Encryption**: AWS-managed SSE (AES-256).
- **DLQ**: **ShippingDLQ**
  - **Purpose**: Retains failed shipping requests for analysis.
  - **Retention Period**: 14 days.
- **Notes**: Includes long retention period to debug logistics API failures.

#### 6. **DataSyncQueue**
- **Purpose**: Synchronizes data between services or regions, ensuring consistency.
- **Encryption**: Customer-managed CMK for enhanced security and auditing.
- **DLQ**: **DataSyncDLQ**
  - **Purpose**: Holds synchronization messages that fail due to data conflicts or timeouts.
  - **Retention Period**: 14 days.
- **Notes**: Used in high-security scenarios; CMK access is logged and audited.

---

### Key Configuration Details

#### Encryption
- **AWS-Managed SSE**:
  - Default encryption provided by AWS for ease of management.
  - Encryption keys are managed and rotated automatically.
- **Customer-Managed CMK**:
  - Provides full control over encryption keys.
  - Enables logging and auditing of encryption key usage.

#### DLQs
- Purpose: Capture messages that cannot be processed after the maximum number of retries.
- **Monitoring**:
  - CloudWatch alarms for message age and DLQ message counts.
  - Alerts trigger when DLQs exceed predefined thresholds.

#### Retry Policy
- All queues implement a retry mechanism to handle transient failures:
  - **Exponential Backoff**: Retrying at increasing intervals to avoid overwhelming dependencies.
  - **Maximum Retry Attempts**: Configured per queue, typically 3 to 5 retries.

#### Timeouts
- **Visibility Timeout**:
  - Ensures in-flight messages are locked during processing.
  - Configured based on average processing time of the queue's workload.

---

### Monitoring and Maintenance

1. **Monitoring**:
   - **Metrics**: Monitor `ApproximateNumberOfMessagesVisible` and `ApproximateAgeOfOldestMessage`.
   - **Alarms**: Set thresholds for message age and visibility timeout breaches.
2. **Review**:
   - Conduct quarterly reviews to validate DLQ usage and encryption compliance.
3. **Security Audits**:
   - Verify CMK policies for queues with customer-managed encryption.
   - Ensure compliance with organizational and regulatory requirements.

---

### Acceptance Criteria
- All SQS queues should have encryption enabled.
- Each queue should have an associated DLQ with appropriate retention and retry policies.
- Documentation should provide a clear understanding of the purpose and configuration of each queue.

---

### Gherkin

**Feature**: SQS Queue Documentation
**Scenario**: Document encryption, DLQs, and purpose of SQS queues
- **Given** a list of SQS queues,
- **When** their encryption, DLQs, and configurations are reviewed,
- **Then** the documentation should be comprehensive and meet security standards.

This documentation ensures operational transparency, security compliance, and readiness for troubleshooting or audits.
