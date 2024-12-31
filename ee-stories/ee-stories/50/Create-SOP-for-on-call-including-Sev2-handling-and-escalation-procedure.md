## Summary
**As an** on-call engineer, **I want** a standard operating procedure (SOP) for handling on-call duties, specifically for Sev2 incidents and escalation procedures, **so that** all engineers can efficiently and consistently manage critical incidents, minimizing downtime and ensuring rapid resolution.

This SOP outlines the steps required to handle on-call responsibilities, with a focus on Sev2 incident management and proper escalation paths. The document ensures all on-call engineers understand their duties, know how to respond to critical incidents, and are aware of the proper escalation procedures to follow.

### Vision
A clear and well-documented SOP will ensure consistency in how Sev2 incidents are handled across the team, improving response times, reducing downtime, and ensuring that critical issues are appropriately escalated when necessary. This benefits the business by minimizing the impact of incidents and ensuring timely resolutions, while also helping engineers manage on-call duties with confidence.

### Background
Sev2 incidents are critical, but not necessarily service-wide outages, and must be handled quickly to avoid escalation to Sev1 or widespread customer impact. The current process for Sev2 handling lacks formal documentation, leading to inconsistent responses and delayed escalations. This SOP aims to standardize the approach to ensure that on-call engineers follow a consistent, reliable process.

### Purpose
The purpose of this SOP is to provide clear, step-by-step instructions for handling Sev2 incidents, ensuring that the on-call engineer knows how to assess the situation, mitigate the issue, and escalate if needed. It also establishes a clear escalation path to ensure incidents are resolved as quickly as possible.

## Details

### On-Call Responsibilities:
1. **Monitoring Systems**:
   - Continuously monitor alerts through the designated monitoring tools (e.g., AWS CloudWatch, Datadog, PagerDuty).
   - Acknowledge alerts within 5 minutes of receiving them.

2. **Sev2 Incident Definition**:
   - Sev2 incidents are defined as critical service failures that impact a portion of the system or a subset of customers but are not yet widespread outages. Examples include high latencies in key APIs or the failure of critical background jobs.

### Steps to Handle Sev2 Incidents:
1. **Initial Assessment**:
   - Acknowledge the alert and assess the incident severity by reviewing logs, dashboards, and the affected services.
   - Confirm that the incident qualifies as a Sev2 by checking for service degradation or partial unavailability.

2. **Incident Mitigation**:
   - Apply any known workarounds or mitigation steps, such as restarting services, scaling resources, or reverting recent deployments.
   - If the issue can be resolved quickly (<15 minutes), document the actions taken and communicate the resolution to stakeholders.

3. **Communication**:
   - Notify the incident management channel or Slack channel of the incident. Provide details about the service impacted, mitigation steps taken, and expected resolution time.
   - Update the communication at regular intervals (every 15-30 minutes) until the issue is resolved or escalated.

### Escalation Procedure for Sev2 Incidents:
1. **Escalation to Senior Engineer/Manager**:
   - If no resolution is possible within 15 minutes, escalate the incident to the senior engineer or designated on-call manager.
   - Provide them with the incident summary, including actions taken so far, logs, and any known mitigation efforts.

2. **Escalation to Sev1**:
   - If the issue begins to affect a broader portion of the service or becomes a full outage, escalate the incident to a Sev1. Follow the Sev1 incident protocol immediately, notifying leadership and major stakeholders.

3. **Post-Incident Review**:
   - After the Sev2 incident is resolved, schedule a post-incident review. Document the incident timeline, mitigation steps, and lessons learned. Create action items to prevent recurrence.

### Testing
- Conduct mock incident simulations to ensure that engineers follow the SOP correctly.
- Test the escalation process to ensure proper communication channels and timely responses.

### External Dependencies
- Monitoring tools (e.g., AWS CloudWatch, Datadog, PagerDuty) must be correctly configured to trigger alerts for Sev2 incidents.
- Proper permissions and access for the on-call engineer to resolve or escalate issues.

## Acceptance Criteria
- Should have the on-call SOP documented and accessible to all team members.
- Should have Sev2 handling steps clearly outlined, including assessment, mitigation, and communication protocols.
- Should have a defined escalation path for Sev2 incidents, leading to a Sev1 escalation if needed.
- Should have completed mock incident tests to validate the process and ensure all engineers understand their responsibilities.

### Gherkin
```gherkin
Given an on-call engineer is monitoring the system
When a Sev2 incident occurs
Then they should follow the documented SOP to assess, mitigate, communicate, and escalate the issue if necessary.
```

## API
N/A

## External Links
- [PagerDuty On-Call Documentation](https://support.pagerduty.com/docs/on-call-basics)
- [AWS Incident Response Guidelines](https://aws.amazon.com/incident-response/)
