## On-Call Escalation Process and SDM Expectations

### Purpose
This document outlines the process for on-call engineers to escalate incidents to the Software Development Manager (SDM) or higher based on customer impact or other critical requirements. It also details the expectations for SDMs during escalations to ensure effective resolution and communication.

---

### Escalation Process

#### 1. **When to Escalate**
Escalation to the SDM or higher is required under the following conditions:
- **Customer Impact**:
  - Sev1 (Critical): Complete service outage or significant degradation affecting all customers.
  - Sev2 (High): Partial outage or significant degradation affecting a subset of customers.
- **Prolonged Incident**:
  - Incident remains unresolved for over 30 minutes, despite primary and secondary on-call efforts.
- **Lack of Expertise**:
  - On-call engineers require decisions or guidance beyond their expertise or authority.
- **External Dependencies**:
  - Incident involves third-party dependencies requiring senior-level engagement.
- **Stakeholder Notification**:
  - Incident necessitates immediate communication to internal or external stakeholders.

---

#### 2. **Escalation Workflow**
1. **On-Call Actions**:
   - Attempt to resolve the incident using runbooks and playbooks.
   - Log all actions and observations in the incident management system (e.g., PagerDuty, Jira).
   - Determine escalation need based on the criteria above.

2. **Contact SDM**:
   - Use pre-defined escalation channels (e.g., phone, Slack, email).
   - Provide the following details:
     - **Incident Summary**: Brief description of the issue.
     - **Customer Impact**: Number of customers affected and severity.
     - **Actions Taken**: Steps already taken to resolve the issue.
     - **Current Status**: Incident status, including blocked areas and dependencies.

3. **SDM Response**:
   - Acknowledge the escalation within **5 minutes**.
   - Join the incident call or chat to provide guidance and make decisions.

4. **Escalation Beyond SDM**:
   - If additional authority or expertise is required, the SDM escalates to the appropriate higher-level manager, Director, or VP.

---

### SDM Expectations During Escalations

#### 1. **Immediate Actions**
- **Acknowledge Escalation**:
  - Respond to the on-call engineer within **5 minutes** of being contacted.
- **Join Incident Call**:
  - Actively participate in incident resolution by joining the call or chat.
- **Evaluate Incident Severity**:
  - Confirm or adjust the severity level based on customer impact and business priorities.

#### 2. **Decision-Making**
- **Prioritize Actions**:
  - Guide the on-call team on the immediate steps to minimize impact.
  - Approve or decline proposed solutions based on risk assessment.
- **Resource Allocation**:
  - Engage additional resources, including secondary teams, if needed.
- **Escalation**:
  - Escalate to higher management or external partners when necessary.

#### 3. **Stakeholder Communication**
- **Internal Stakeholders**:
  - Notify leadership, product managers, and other affected teams about the incident.
  - Provide updates at regular intervals (e.g., every 15 minutes for Sev1).
- **External Stakeholders**:
  - Ensure timely and accurate communication with customers if required.
  - Approve customer-facing status updates on incident progress.

#### 4. **Post-Incident Actions**
- **Root Cause Analysis (RCA)**:
  - Participate in or delegate post-mortem analysis.
  - Ensure action items are documented and tracked.
- **Follow-Up Communication**:
  - Update stakeholders on incident resolution and preventative measures.

---

### Communication Channels

| **Escalation Type**       | **Primary Channel**      | **Backup Channel**    |
|---------------------------|--------------------------|-----------------------|
| Immediate Escalation       | Phone call to SDM        | PagerDuty escalation  |
| Non-Urgent Communication   | Slack direct message     | Email                 |
| Stakeholder Updates        | Incident Management System (e.g., Jira) | Slack Incident Channel |

---

### Incident Logging Requirements

For all escalations:
- **Document**:
  - Incident summary.
  - Actions taken before escalation.
  - Decisions made by the SDM.
  - Follow-up steps.
- **Tool**: Use the designated incident tracking tool (e.g., Jira, PagerDuty).

---

### Maintenance and Review

#### 1. **Quarterly Review**:
- Review and update escalation criteria and workflows.
- Collect feedback from on-call engineers and SDMs to improve the process.

#### 2. **Training**:
- Provide regular training to SDMs on escalation protocols and incident management.

---

### Acceptance Criteria
- Should define clear escalation criteria for on-call engineers.
- Should outline detailed SDM responsibilities during and after escalation.
- Should ensure incident logging and stakeholder communication protocols are followed.

---

### Gherkin

**Feature**: On-Call Escalation to SDM
**Scenario**: Escalating a critical incident to the SDM
- **Given** a customer-impacting incident,
- **When** the on-call engineer determines escalation is required,
- **Then** the SDM should be contacted within 5 minutes and provide guidance.

This process ensures rapid escalation and effective resolution of critical incidents while maintaining clear communication and accountability.
