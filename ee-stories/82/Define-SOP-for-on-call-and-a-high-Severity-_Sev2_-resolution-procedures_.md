### Summary
**As a** DevOps Engineer, **I want** to define a Standard Operating Procedure (SOP) for on-call duties and high-severity (Sev2) resolution procedures **So That** the on-call team can consistently and effectively handle Sev2 incidents, ensuring quick mitigation of customer-impacting issues with minimal downtime.

This SOP outlines the responsibilities, steps, and procedures for the on-call engineer to follow during a Sev2 incident. It ensures a consistent, repeatable process for diagnosing, mitigating, and resolving high-severity issues that could impact customers or cause a breach of service-level agreements (SLAs).

### Vision
By establishing a clear SOP for on-call engineers and Sev2 incident response, we ensure that incidents are handled swiftly, consistently, and with minimal service disruption. This reduces the time to resolution, mitigates the impact on customers, and ensures that critical information is recorded and communicated properly.

### Background
Sev2 incidents are high-severity issues that typically affect a significant portion of customers or a critical function of the system. These incidents require immediate attention from the on-call engineer to prevent or minimize the negative impact on service availability, performance, or customer experience. Having a structured approach ensures efficient and consistent incident management.

---

### On-Call SOP and Sev2 Incident Resolution Procedure

#### 1. **On-Call Responsibilities**
- **Availability**: The on-call engineer must be available and reachable at all times during their shift, with appropriate alerting mechanisms (e.g., PagerDuty, Slack) in place.
- **Monitoring**: Continuously monitor operational dashboards, alerts, and metrics to detect potential issues early.
- **Incident Response**: Respond to alerts within 5 minutes of receiving the notification, especially for Sev2 incidents.
- **Documentation**: Maintain detailed documentation of actions taken during an incident for post-mortem analysis and knowledge sharing.

---

#### 2. **Defining a Sev2 Incident**
A **Sev2** incident is defined as:
- A partial outage or degradation in performance that impacts a significant portion of users.
- A critical feature or service is unavailable or malfunctioning.
- There is a high likelihood of SLA breach if not resolved within a defined period (e.g., 30-60 minutes).
- Significant security vulnerabilities are discovered, requiring immediate mitigation.

---

#### 3. **Sev2 Resolution Procedure**

##### Step 1: **Acknowledge the Incident**
- **Timeframe**: Acknowledge the Sev2 alert within 5 minutes of receiving the notification.
- **Action**: Acknowledge the alert in the monitoring tool (e.g., PagerDuty) to notify the team that the issue is being handled.

##### Step 2: **Assess Impact**
- **Identify the Issue**: Review the alert details, logs, and dashboards to identify the affected components (e.g., services, databases, APIs).
- **Assess the Scope**: Determine the scope of the impact (e.g., percentage of affected users, affected services).
- **Check Dependencies**: Check for downstream or upstream dependencies that may also be impacted.

##### Step 3: **Mitigate Immediate Impact**
- **Temporary Workarounds**: If possible, apply a temporary fix to mitigate the customer impact while working on a long-term resolution.
  - Example: Redirect traffic to a backup service or failover to a secondary instance.
- **Throttle or Disable Problematic Features**: If a specific feature is causing the issue, temporarily disable it to reduce load or prevent further failures.

##### Step 4: **Engage Additional Support**
- **Escalation**: If the issue cannot be resolved within 15 minutes, escalate to the appropriate engineering or support teams.
- **Notify Stakeholders**: Inform key stakeholders (e.g., product owners, senior management) of the incident and ongoing efforts, using predefined communication channels (e.g., email, Slack).

##### Step 5: **Apply a Fix**
- **Fix the Root Cause**: Implement the required fix, such as:
  - Restarting services or instances.
  - Rolling back recent deployments if they are suspected to be the cause.
  - Patching or updating the affected system components.

##### Step 6: **Monitor Recovery**
- **Confirm Resolution**: Once the fix is applied, monitor the system to ensure that services are recovering and normal operations are restored.
- **Verify**: Check customer-facing metrics (e.g., latency, error rates) to confirm that the issue is resolved and no further impact is occurring.

##### Step 7: **Update Incident Status**
- **Document Resolution**: Update the incident tracker or monitoring tool with the details of the resolution steps taken.
- **Close the Incident**: Once the issue is confirmed resolved, close the incident and notify stakeholders of the resolution.

---

#### 4. **Post-Incident Actions**

##### Step 1: **Post-Mortem and RCA (Root Cause Analysis)**
- **Timeline**: Conduct a post-mortem within 24-48 hours of the incident resolution.
- **RCA**: Investigate and document the root cause of the incident, identifying contributing factors and potential areas for improvement.
- **Action Items**: Define and assign follow-up actions to prevent recurrence (e.g., applying additional monitoring, increasing auto-scaling limits).

##### Step 2: **Document Learnings**
- **Knowledge Base**: Document the incident, resolution steps, and lessons learned in a centralized knowledge base (e.g., Confluence, internal wiki).
- **Share with the Team**: Ensure that the entire team is aware of the incident and the steps taken, providing a detailed write-up for future reference.

---

#### 5. **Escalation and Communication Protocols**

- **Sev1 Escalation**: If the Sev2 incident worsens and becomes critical (e.g., complete service outage), escalate it to Sev1 and notify senior leadership immediately.
- **Customer Communication**: If customer-facing, ensure customer support teams are informed to communicate with users regarding the status and expected resolution timeline.

---

### Acceptance Criteria
- Should define clear on-call responsibilities and Sev2 incident handling procedures.
- Should ensure that all Sev2 incidents are acknowledged within 5 minutes and resolved or mitigated within the defined SLA.
- Should document each Sev2 incident and ensure a post-mortem is conducted within 24-48 hours.
- Should create clear escalation paths and communication protocols to keep stakeholders informed during and after incidents.

This SOP standardizes the process for handling high-severity incidents, ensuring consistency and speed in resolving critical issues, minimizing downtime, and reducing the overall impact on customers.
