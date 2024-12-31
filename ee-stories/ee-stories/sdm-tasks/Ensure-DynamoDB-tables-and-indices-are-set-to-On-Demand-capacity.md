## Summary
**As a** database administrator, **I want** to ensure that all DynamoDB tables and their indices are set to On-Demand capacity mode **so that** we can manage the scalability and cost-effectiveness of our database operations without the need for manual intervention or capacity planning.

### Vision
The vision for this task is to optimize our database operations by leveraging the On-Demand capacity mode in DynamoDB, which provides flexible scaling capabilities and simplifies operational management by automatically adjusting to application traffic.

### Background
DynamoDB offers two capacity modes: Provisioned and On-Demand. While Provisioned requires careful capacity planning and can lead to over-provisioning or throttling if underestimated, On-Demand offers seamless scaling and payment for only the read and write requests made.

### Purpose
The purpose of setting DynamoDB tables and indices to On-Demand capacity mode is to eliminate the operational burden of capacity planning, reduce the risk of throttling during unexpected spikes, and potentially lower costs by paying only for what is used.

## Steps to Ensure On-Demand Capacity Mode

### 1. **Audit Current Capacity Settings**
   - **Action**: List all DynamoDB tables and their current capacity settings.
   - **Tool**: AWS Management Console or AWS CLI command:
     ```
     aws dynamodb list-tables
     aws dynamodb describe-table --table-name <TableName>
     ```

### 2. **Identify Tables Not on On-Demand**
   - **Action**: Identify which tables and their associated indices are not set to On-Demand capacity mode.
   - **Criteria**: Check the `BillingModeSummary` in the table description. If it is not `PAY_PER_REQUEST`, the table is not on On-Demand.

### 3. **Plan Transition to On-Demand**
   - **Action**: Develop a plan to transition these tables to On-Demand, considering the potential impact on performance and costs.
   - **Considerations**:
     - Peak traffic analysis to understand potential cost implications.
     - Backup and restore strategies to safeguard data during the transition.

### 4. **Execute Transition**
   - **Action**: Convert tables from Provisioned to On-Demand capacity mode.
   - **Command**:
     ```
     aws dynamodb update-table --table-name <TableName> --billing-mode PAY_PER_REQUEST
     ```
   - **Monitoring**: Monitor performance and cost metrics closely after the transition to evaluate the impact.

### 5. **Document and Communicate Changes**
   - **Action**: Document the changes made to each table and communicate these changes to relevant stakeholders.
   - **Details**: Include the rationale for changes, expected benefits, and any observed impacts on performance or cost.

## Acceptance Criteria
- Should have verified and documented the current capacity settings of all DynamoDB tables.
- Should have a list of tables that are not on On-Demand and a detailed plan for transitioning them.
- Should successfully transition identified tables to On-Demand capacity mode without disrupting service.
- Should monitor and report the effects of the transition on application performance and database costs.

### Gherkin
Given a DynamoDB table set to Provisioned capacity mode,
When the table is transitioned to On-Demand capacity mode,
Then it should handle varying loads without manual scaling or increased latency, and costs should align with actual usage.

This systematic approach to ensuring all DynamoDB tables are set to On-Demand capacity mode will help in optimizing our database operations for scalability, performance, and cost-efficiency, aligning with our operational goals and service commitments.
