
# Create a process for approving and reviewing off-script Change Management requests.
### Summary
**As a** DevOps Manager, **I want** to create a streamlined process for approving and reviewing off-script Change Management requests, **So That** any non-standard changes can be properly assessed, approved, and tracked to minimize risk to operations.

This story focuses on establishing a lightweight process for handling Change Management requests that deviate from the usual predefined scripts or procedures, ensuring a balance between flexibility and control.

### Vision
The new process will allow teams to submit off-script change requests with enough oversight to ensure that changes are safe while also allowing for exceptions when necessary. The review process should be fast enough to avoid blocking essential work but thorough enough to catch potential issues.

### Background
Off-script changes introduce variability into the system and can create unforeseen risks. Without a clear process, these changes may bypass key reviews or approvals, leading to operational problems. A formalized process helps ensure that all stakeholders are aware of the risks and that necessary safeguards are in place.

## Details
1. **Submission Process**
   - Create a standard form in your Change Management tool (e.g., Jira, ServiceNow) to capture details of off-script requests. Include fields for:
     - Description of the change.
     - Justification for why the script cannot be followed.
     - Potential risks and mitigation strategies.
     - Approvals required.

2. **Approval Workflow**
   - Establish a lightweight approval workflow where key stakeholders (DevOps lead, service owner, etc.) review the request and provide sign-off within a set timeframe (e.g., 24-48 hours).

3. **Review Criteria**
   - Ensure reviews focus on:
     - Alignment with business goals.
     - Risk analysis and contingency plans.
     - Impact on users and operations.

4. **Tracking and Auditing**
   - Use your Change Management tool to track the status and history of all off-script requests for later review.

### Testing
- Test the process by simulating an off-script change request and ensuring that it moves through submission, review, approval, and tracking without major delays.

### Acceptance Criteria
- Should have a submission form for off-script requests.
- Should have an approval process that includes necessary stakeholders.
- Should have logging and tracking of all off-script requests.
