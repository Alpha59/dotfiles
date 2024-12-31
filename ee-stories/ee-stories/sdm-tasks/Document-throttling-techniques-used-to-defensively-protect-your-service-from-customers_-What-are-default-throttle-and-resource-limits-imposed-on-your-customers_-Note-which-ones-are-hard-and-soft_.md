## Summary
**As a** system architect, **I want** to document the throttling techniques and default resource limits imposed on our customers **so that** we can protect our service from overuse, ensure equitable resource distribution, and maintain high service quality for all users.

### Vision
The vision for this documentation is to provide a clear and transparent overview of the mechanisms in place to manage customer access and resource consumption effectively. This ensures that our system remains stable and responsive under varying load conditions.

### Background
Effective management of customer requests and resource usage is crucial to prevent system overloads and to maintain fairness among users. Throttling techniques and resource limits are employed to control this interaction, ensuring that no single customer can monopolize system resources.

### Purpose
The purpose of this documentation is to outline the strategies used to throttle customer requests and set resource limits, detailing which are hard limits (cannot be exceeded) and which are soft limits (can be adjusted upon request).

## Throttling Techniques and Resource Limits Documentation

### 1. **API Request Throttling**
   - **Mechanism**: Rate limiting using a token bucket algorithm.
   - **Default Limit**: 1,000 requests per minute per user.
   - **Type**: Soft limit - customers can request an increase through support.
   - **Purpose**: To prevent any single user from flooding the service with excessive requests that could impact service performance for others.

### 2. **Data Transfer Limits**
   - **Mechanism**: Bandwidth throttling.
   - **Default Limit**: 500 GB per month.
   - **Type**: Hard limit - dictated by service tier and not adjustable beyond the highest paid tier.
   - **Purpose**: To manage network resource utilization and ensure consistent service levels.

### 3. **Concurrent Connections**
   - **Mechanism**: Connection limits per account.
   - **Default Limit**: 100 simultaneous connections.
   - **Type**: Soft limit - can be adjusted based on customer's operational requirements and justification.
   - **Purpose**: To ensure fair usage and prevent any user from consuming disproportionate connection resources.

### 4. **Storage Quotas**
   - **Mechanism**: Quota management on customer data storage.
   - **Default Limit**: 10 TB of storage per account.
   - **Type**: Hard limit - increases can be purchased in increments of 1 TB up to a maximum of 50 TB.
   - **Purpose**: To manage physical and virtual storage resources effectively and ensure availability for all users.

### 5. **Compute Resource Allocation**
   - **Mechanism**: CPU and memory allocation limits based on service tier.
   - **Default Limit**: 4 vCPUs and 16 GB RAM for the standard tier.
   - **Type**: Soft limit - customers can scale up through higher service tiers or custom configurations.
   - **Purpose**: To prevent resource hogging and ensure that compute resources are equitably distributed among customers.

### Monitoring and Enforcement
- **Tools**: Use AWS CloudWatch for monitoring and AWS Service Quotas to enforce these limits.
- **Alerts**: Set up alerts for approaching or exceeding limits to notify customers and our operations team proactively.

## Acceptance Criteria
- Should have all throttling mechanisms and resource limits well-documented with clear justifications for each.
- Should clearly distinguish between hard and soft limits, providing pathways for customers to request increases where applicable.
- Should ensure that monitoring systems are in place to enforce these limits and alert relevant parties when thresholds are approached or exceeded.

### Gherkin
Given a customer's operation,
When the operation approaches a predefined resource or rate limit,
Then the system should enforce the limit, notify the customer, and offer guidance on how to request adjustments if applicable.

This documentation will serve as a critical resource for customer support, sales, and engineering teams to understand and manage customer interactions with our service, ensuring a stable, fair, and responsive system environment for all users.
