## Summary
**As a** DevOps engineer or system administrator, **I want** to implement configuration changes under **Managed Change Management Systems (MCMs)** with a review and a **two-person rule**, **so that** any critical configuration changes are reviewed and approved by two authorized individuals before implementation, ensuring that changes are controlled, secure, and reduce the risk of errors.

Implementing a two-person rule for configuration changes ensures that all changes are properly reviewed and vetted before they are applied to the system, preventing unauthorized or accidental modifications. This process enhances security, compliance, and auditability, particularly in environments that require strict change management protocols.

### Vision
By using Managed Change Management Systems (MCMs) with a two-person review rule, the organization will maintain a high level of security and control over configuration changes. This ensures that critical changes undergo thorough review and approval, minimizing the risk of human error and ensuring compliance with governance policies.

### Background
The two-person rule is a security control mechanism designed to prevent unauthorized or improper actions by requiring two authorized individuals to approve a change before it is executed. This method is particularly useful in environments where configuration changes can have significant security, operational, or financial consequences. Integrating this process into an MCM ensures that all changes are documented, reviewed, and approved according to established governance policies.

### Purpose
The purpose of this story is to implement a formal change management process under an MCM with a two-person rule, ensuring that all configuration changes are reviewed, approved, and documented. This process mitigates the risks of unintended consequences and increases transparency in managing changes to critical systems.

## Details

### 1. **Set Up Managed Change Management System (MCM)**

   - **Choose an MCM Platform**:
     Identify the MCM system to manage changes (e.g., **ServiceNow**, **Jira Service Management**, **AWS Change Manager**, **GitOps** tools). Ensure it supports change tracking, approvals, and notifications.

   - **MCM Configuration**:
     Configure the MCM to require changes to be submitted for review before implementation. Set up workflows that include approvals by multiple users, particularly those authorized to approve configuration changes.

### 2. **Define the Two-Person Review Process**

   **Step 1**: **Establish Roles and Permissions**
   - Define roles for individuals involved in the configuration change process:
     - **Change Requester**: The individual who submits the change request.
     - **Reviewer 1**: The first reviewer responsible for validating the technical feasibility and impact of the change.
     - **Reviewer 2**: The second reviewer who ensures that the change aligns with security and operational requirements.

   **Step 2**: **Set Approval Requirements**
   - Configure the MCM system to enforce that no configuration change can be implemented unless two separate individuals approve the change. This process should involve:
     - **Technical Review**: A thorough review of the proposed change, including potential impacts on the system.
     - **Security/Compliance Review**: Ensure the change adheres to security, compliance, and operational policies.

   **Example Workflow**:
   - A DevOps engineer submits a configuration change for review.
   - Reviewer 1 (e.g., senior engineer) reviews the technical aspects and approves the change.
   - Reviewer 2 (e.g., security engineer) reviews the change for security and compliance, providing the final approval before the change is implemented.

### 3. **Document Change Requests and Reviews**

   **Step 1**: **Use Templates for Change Requests**
   - Define a template for submitting change requests in the MCM system. The template should include:
     - **Change Description**: A clear description of the proposed change.
     - **Reason for Change**: Justification for the change, including business or technical benefits.
     - **Impact Assessment**: Assessment of how the change will affect the system, including potential risks.
     - **Rollback Plan**: A plan for reverting the change if issues arise.

   **Step 2**: **Document Review Process**
   - Ensure that the MCM system logs the following for every change:
     - **Who submitted the change**.
     - **Who reviewed and approved the change**.
     - **Approval timestamps**.
     - **Comments or notes from reviewers** (e.g., concerns, additional checks needed).

   **Example Change Request**:
   - **Change Description**: Increase the size of the RDS instance to handle additional traffic.
   - **Reason for Change**: Current instance size is hitting CPU limits during peak hours.
   - **Impact Assessment**: Possible brief downtime during the instance resize.
   - **Rollback Plan**: Revert to the previous instance size if the new size does not stabilize within an hour.

### 4. **Enforce Two-Person Approval Rule**

   **Step 1**: **Configure Workflow in MCM**
   - Set up the workflow in the MCM to require the approval of two distinct individuals before changes are implemented. The system should prevent changes from being deployed unless both reviewers approve.

   **Step 2**: **Configure Alerts and Notifications**
   - Set up automatic alerts and notifications for the reviewers when a change is submitted for approval. This ensures timely reviews and helps maintain adherence to the change management process.

   **Example Workflow Configuration**:
   - In Jira Service Management: Create a workflow where any change request moves to an “Approval” state that requires two separate users to approve the change before it can move to the "In Progress" or "Completed" state.

### 5. **Implement Safeguards and Auditing**

   **Step 1**: **Prevent Single-Person Changes**
   - Ensure the MCM system automatically prevents a single person from both requesting and approving a change. This helps maintain the integrity of the two-person rule.

   **Step 2**: **Enable Change Auditing**
   - Enable detailed auditing of the change management process, ensuring that every action (submission, review, approval, and implementation) is logged and available for compliance reviews. This should include:
     - **Time of submission**.
     - **Reviewer actions and approvals**.
     - **Any comments or feedback provided by reviewers**.

### 6. **Review and Test the Change Process**

   **Step 1**: **Perform Test Changes**
   - Submit test configuration changes through the MCM system to verify that the two-person rule and review process function as expected. Ensure that the workflow does not proceed without proper approvals.

   **Step 2**: **Test Rollback Procedures**
   - Test rollback procedures for changes to ensure that if a change negatively impacts the system, it can be reversed according to the rollback plan.

   **Step 3**: **Monitor for Compliance**
   - Periodically review change logs and audit reports to ensure that all changes follow the two-person approval rule. Identify any violations and take corrective actions as needed.

### Testing

- **Two-Person Rule Testing**:
   - Test the workflow with multiple configuration changes, ensuring that no change can proceed without approval from two separate individuals.

- **Change Auditing**:
   - Ensure that detailed logs are maintained for each change, including who submitted, reviewed, and approved the changes.

- **Alert Testing**:
   - Verify that alerts and notifications are triggered when a change request is submitted for review.

### External Dependencies
- **MCM system** (e.g., ServiceNow, Jira Service Management, AWS Change Manager) for tracking and managing change requests.
- **Email or messaging services** for sending alerts and notifications to reviewers.

## Acceptance Criteria
- Should implement a two-person approval process for configuration changes in the MCM system.
- Should require two authorized individuals to review and approve changes before implementation.
- Should document all changes, reviews, and approvals, including timestamps and reviewer comments.
- Should ensure proper auditing of the change management process for compliance.

### Gherkin
```gherkin
Given a configuration change is submitted
When the change is reviewed
Then it should require two separate individuals to approve the change before it can be implemented.

Given a single individual submits and reviews a change
When the system detects the action
Then the system should block the change from being implemented and notify the user of the two-person rule.

Given a configuration change is approved by two individuals
When the change is implemented
Then the system should log the approval, including timestamps, reviewers, and any comments.
```
