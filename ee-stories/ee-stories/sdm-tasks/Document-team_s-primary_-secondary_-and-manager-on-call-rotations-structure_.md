## On-Call Rotations Structure and Acceptance Criteria

### Purpose
This document outlines the structure of the team’s primary, secondary, and manager on-call rotations. It also defines the acceptance criteria that team members must meet before being added to the primary or secondary on-call rotations to ensure readiness and operational excellence.

---

### On-Call Rotations Structure

#### 1. **Primary On-Call**
- **Role**: First responder to operational alerts and incidents.
- **Responsibilities**:
  - Monitor and respond to all alerts within SLA.
  - Perform initial triage and resolve incidents when possible.
  - Escalate issues to the secondary on-call or manager on-call if unresolved within the specified timeframe.
- **Schedule**:
  - Weekly rotation among qualified team members.
  - Coverage: 24/7 during the assigned week.
- **Expectations**:
  - Be available and responsive during on-call hours.
  - Provide timely and accurate updates in incident management systems.

---

#### 2. **Secondary On-Call**
- **Role**: Backup responder when the primary on-call cannot resolve an issue.
- **Responsibilities**:
  - Assist the primary on-call in resolving escalated incidents.
  - Provide guidance or support for complex issues.
  - Act as the first escalation point for unresolved alerts.
- **Schedule**:
  - Weekly rotation offset from the primary on-call rotation.
- **Expectations**:
  - Be available for consultation and escalation support.
  - Participate in post-incident reviews for escalated incidents.

---

#### 3. **Manager On-Call**
- **Role**: Escalation point for major incidents or operational challenges.
- **Responsibilities**:
  - Make critical decisions during Sev1 and Sev2 incidents.
  - Ensure that the team adheres to incident response protocols.
  - Communicate major incidents to stakeholders.
- **Schedule**:
  - Bi-weekly or monthly rotation among team managers.
- **Expectations**:
  - Be reachable during critical incidents.
  - Review and approve incident post-mortems and follow-up actions.

---

### On-Call Acceptance Criteria

#### 1. **Technical Readiness**
- **Primary On-Call**:
  - Demonstrated understanding of the system architecture and dependencies.
  - Ability to diagnose and resolve common alerts independently.
  - Proficiency with monitoring tools (e.g., CloudWatch, Datadog) and incident management platforms (e.g., PagerDuty, Jira).
  - Completion of shadowing at least two primary on-call shifts.
- **Secondary On-Call**:
  - Advanced knowledge of the system, including edge cases and failure modes.
  - Experience resolving escalated incidents or complex issues.
  - Completion of at least two rotations as primary on-call.

---

#### 2. **Operational Readiness**
- **Primary On-Call**:
  - Familiarity with all runbooks and playbooks.
  - Proven ability to respond to alerts within SLA.
  - Participation in on-call drills or incident simulations.
- **Secondary On-Call**:
  - Proven ability to guide primary on-call responders during incidents.
  - Familiarity with escalation policies and stakeholder communication protocols.

---

#### 3. **Behavioral Readiness**
- **Primary On-Call**:
  - Ability to remain calm and composed under pressure.
  - Effective communication skills for incident updates and escalation.
- **Secondary On-Call**:
  - Leadership skills to guide and mentor the primary on-call.
  - Clear and concise communication with stakeholders and team members.

---

### Training and Onboarding Process
1. **Orientation**:
   - Provide an overview of on-call roles and responsibilities.
   - Introduce team tools and workflows.
2. **Runbook Familiarization**:
   - Assign team members to review all relevant runbooks.
   - Conduct guided walk-throughs of critical procedures.
3. **Shadowing**:
   - Shadow an experienced on-call engineer for at least two shifts.
4. **Certification**:
   - Complete a readiness assessment covering technical, operational, and behavioral criteria.

---

### Maintenance and Updates
- **Quarterly Review**:
  - Review and update the on-call rotation schedule.
  - Assess team member readiness and provide additional training if needed.
- **Feedback Collection**:
  - Gather feedback from on-call engineers about the rotation structure and readiness process.

---

### Acceptance Criteria for On-Call Readiness
- Should demonstrate technical, operational, and behavioral readiness through training and shadowing.
- Should complete a readiness assessment with approval from the team lead.
- Should be added to the primary or secondary rotation only after meeting all criteria.

---

### Gherkin

**Feature**: On-Call Rotations and Readiness
**Scenario**: Adding team members to on-call rotations
- **Given** the team's on-call structure,
- **When** a team member meets the readiness criteria,
- **Then** they should be added to the primary or secondary on-call rotations.

This structure ensures a robust and efficient on-call rotation, minimizing downtime and ensuring a high standard of operational excellence.
