## Summary
**As a** service team, **I want** to document the Managed Change Management (MCM) process and templates to ensure they meet the bar-raising standards and include a well-defined on-call rotation **so that** the team can consistently manage changes, minimize risks, and maintain service reliability during deployments.

### Vision
The vision for this documentation is to standardize the MCM process, ensure all templates are comprehensive and actionable, and establish a robust on-call mechanism to handle any incidents arising from changes. This ensures seamless change management while upholding operational excellence.

### Background
MCM is a critical practice for managing changes to services, including deployments, updates, and feature rollouts. A bar-raising MCM process reduces risks, ensures thorough validation, and provides mechanisms to handle incidents effectively.

### Purpose
The purpose of this documentation is to define the team’s MCM process, outline template requirements, and establish an on-call rotation for handling MCM-related incidents.

---

## MCM Process Documentation

### 1. **MCM Workflow**
#### A. **Stages of MCM**
1. **Change Request**:
   - Identify the scope, purpose, and type of change (e.g., deployment, configuration update).
   - Create an MCM request in the designated tool (e.g., Jira, ServiceNow).
   - Include key details such as service name, change description, and target timeline.

2. **Impact Assessment**:
   - Evaluate the potential impact on users, systems, and dependencies.
   - Identify risks and mitigation strategies.
   - Confirm test coverage and validation plans.

3. **Approval Process**:
   - Obtain approval from relevant stakeholders (e.g., service owners, on-call engineers).
   - Use an automated system to track approvals.

4. **Implementation**:
   - Schedule the change during a low-traffic window if applicable.
   - Follow the predefined runbook or playbook for the change.
   - Monitor the system during and after implementation.

5. **Post-Change Validation**:
   - Verify that the change was successful and metrics are within acceptable thresholds.
   - Rollback immediately if issues arise, following the rollback procedure in the MCM template.

6. **Documentation and Review**:
   - Update logs and documentation with the results of the change.
   - Conduct a retrospective if the change caused an incident.

---

### 2. **MCM Template Requirements**
#### A. **Key Sections**
1. **Change Summary**:
   - **Purpose**: Clearly state the reason for the change.
   - **Scope**: Define the systems and components affected.

2. **Impact Analysis**:
   - **Affected Users/Services**: List all impacted stakeholders.
   - **Risk Assessment**: Identify potential failure points and their likelihood.
   - **Mitigation Plan**: Provide strategies to minimize risks.

3. **Execution Plan**:
   - **Step-by-Step Instructions**: Outline detailed steps for implementation.
   - **Pre-Change Checks**: Include health checks to confirm readiness.
   - **Post-Change Checks**: Specify validation steps to confirm success.

4. **Rollback Plan**:
   - **Trigger Conditions**: Define when a rollback should be initiated.
   - **Rollback Steps**: Provide detailed instructions for reverting the change.

5. **Approval Checklist**:
   - List required approvals, including from service owners and on-call engineers.
   - Include timestamps for approvals.

6. **Monitoring Plan**:
   - Define metrics to monitor during and after the change.
   - Specify thresholds for alarms and alerts.

7. **Incident Response**:
   - Include contact information for the MCM on-call engineer.
   - Provide escalation paths for unresolved issues.

---

### 3. **Bar-Raising Standards**
#### A. **Validation Requirements**
- Automated tests covering new and existing functionality.
- Pre-deployment integration testing in staging environments.
- Manual review of MCM templates for completeness and clarity.

#### B. **Risk Mitigation**
- Use canaries or fractional deployments for high-impact changes.
- Include a clear rollback procedure in every MCM template.
- Monitor all relevant metrics during and after the change.

---

### 4. **MCM On-Call Rotation**
#### A. **Roles and Responsibilities**
1. **Primary On-Call**:
   - Monitors changes during the scheduled window.
   - Responds to incidents and escalates if needed.

2. **Secondary On-Call**:
   - Acts as a backup in case the primary is unavailable.
   - Assists with major incidents requiring additional resources.

#### B. **Rotation Schedule**
- Maintain a weekly rotation for on-call engineers.
- Use automated scheduling tools (e.g., PagerDuty, Opsgenie) to manage rotations.
- Notify the team at least two weeks in advance of schedule changes.

#### C. **Incident Handling**
1. **Initial Response**:
   - Acknowledge the alert within 5 minutes.
   - Assess the severity and scope of the issue.
2. **Mitigation**:
   - Follow the rollback plan if necessary.
   - Implement temporary fixes if rollback is not feasible.
3. **Escalation**:
   - Escalate to service owners or senior engineers for unresolved issues.

---

### 5. **Testing and Maintenance**
#### A. **MCM Drills**
- Schedule quarterly MCM drills to simulate high-impact changes.
- Validate the effectiveness of templates, processes, and on-call rotations.

#### B. **Review Process**
- Conduct an annual review of MCM templates and processes.
- Solicit feedback from team members and stakeholders.

---

## Acceptance Criteria
- Should document a comprehensive MCM process with clear workflows and responsibilities.
- Should define bar-raising MCM templates that cover all critical aspects of change management.
- Should establish a well-structured on-call rotation for handling MCM incidents.
- Should schedule regular MCM drills and reviews for continuous improvement.

---

### Gherkin
Given an MCM request,
When the team follows the documented process,
Then the change should be implemented successfully, with minimal risk and quick response to any incidents.

This documentation ensures a high-quality, standardized approach to change management, reducing risks and improving team readiness during service updates.
