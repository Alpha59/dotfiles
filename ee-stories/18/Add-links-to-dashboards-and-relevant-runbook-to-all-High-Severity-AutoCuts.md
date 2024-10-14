
# Add links to dashboards and relevant runbook to all High Severity AutoCuts
### Summary
**As a** Site Reliability Engineer, **I want** to add links to dashboards and relevant runbooks to all High Severity (Sev-1 and Sev-2) AutoCuts, **So That** we can ensure that the team has quick access to key information and response procedures during high-severity incidents, enabling faster diagnosis and resolution.

This story focuses on adding links to relevant monitoring dashboards and runbooks directly to the AutoCut tickets generated for High Severity incidents. By including these links, the team can immediately access the data and step-by-step remediation procedures necessary to address the issue, reducing the time to recovery and minimizing the impact on service availability.

### Vision
Adding links to dashboards and runbooks in all High Severity AutoCuts ensures that the team has immediate access to the tools and documentation needed to respond quickly to incidents. This streamlined access helps reduce incident response time and ensures that best practices and procedures are followed consistently during critical events.

### Background
Currently, when a High Severity AutoCut is generated, team members may need to manually locate the relevant dashboards and runbooks, which can delay incident resolution. By embedding these links directly in the AutoCut tickets, we provide faster access to key information, enabling quicker diagnosis and remediation of the issue.

### Purpose
The purpose of this story is to ensure that all High Severity (Sev-1 and Sev-2) AutoCut tickets include links to the relevant monitoring dashboards and runbooks. This initiative aims to reduce incident resolution time and ensure that the team has immediate access to critical information needed to resolve high-impact issues.

## Details
1. **Identify High Severity AutoCuts**:
    - Review the existing AutoCut system and identify the criteria used to classify incidents as High Severity (Sev-1 and Sev-2).
    - Ensure that the AutoCuts generated for critical incidents include triggers such as:
      - **Service outages**
      - **Severe performance degradation**
      - **Critical error rates or failed dependencies**

2. **Determine Relevant Dashboards and Runbooks for Each Service**:
    - For each High Severity AutoCut type, identify the relevant dashboards that provide real-time monitoring data for the affected service or component. These may include:
      - AWS CloudWatch dashboards for monitoring system health, resource utilization, and latency.
      - Datadog or Prometheus dashboards for tracking key metrics such as error rates, response times, and availability.
    - Identify the appropriate runbook for each AutoCut type. The runbook should include:
      - **Step-by-step remediation procedures**: Specific actions the team should take to resolve the issue.
      - **Escalation paths**: Guidelines for escalating incidents if initial remediation steps fail.
      - **Relevant contacts**: Information on who to contact (e.g., service owners, stakeholders) during the incident.

3. **Modify AutoCut Templates to Include Links**:
    - Modify the AutoCut ticket templates to include sections that automatically pull in links to relevant dashboards and runbooks based on the type of incident.
    - For example, an AutoCut triggered by an EC2 instance failure should automatically include a link to the relevant EC2 monitoring dashboard and the EC2-specific runbook.
    - Ensure that these links are embedded directly in the AutoCut ticket, so team members can access them immediately upon receiving the ticket.

4. **Integrate Links into AutoCut Workflow**:
    - Work with the development and operations teams to ensure that links to dashboards and runbooks are automatically populated into the AutoCut tickets when a high-severity incident occurs.
    - Ensure that links are formatted clearly and are easy to access from the ticket description or the incident management system.

5. **Test AutoCut Integration with Dashboards and Runbooks**:
    - Simulate High Severity incidents to verify that AutoCut tickets are generated correctly with the appropriate links to dashboards and runbooks.
    - Test multiple incident scenarios to ensure that the correct links are being populated based on the type of service affected and the specific incident triggers.
    - Confirm that team members can quickly access the relevant dashboards and runbooks from the AutoCut tickets and that the information provided is sufficient for resolving the issue.

6. **Update Documentation and Train Team**:
    - Document the updated AutoCut process, including how links to dashboards and runbooks are automatically included in the tickets.
    - Ensure that all relevant teams are aware of the new process and understand how to use the AutoCut tickets effectively during incident response.
    - Provide training on how to navigate the linked dashboards and follow the runbooks to resolve incidents efficiently.

7. **Review and Optimize Over Time**:
    - Regularly review the AutoCut tickets generated during incidents to ensure that the correct links are being included and that the runbooks are up to date.
    - Gather feedback from the team on the usefulness of the linked dashboards and runbooks, and make improvements as needed.
    - Continuously update runbooks and dashboards to reflect changes in system architecture, services, and incident response procedures.

### Testing
- Simulate various High Severity incidents to verify that AutoCut tickets include links to the appropriate dashboards and runbooks.
- Test the usability of the links by ensuring that team members can quickly access the correct information directly from the ticket.
- Validate that the dashboards and runbooks linked in the tickets provide the necessary data and guidance for resolving incidents.
- Confirm that incident response times are reduced by using the linked information to quickly diagnose and resolve issues.

### External Dependencies
- Integration with the existing AutoCut system and incident management platform to modify the templates and include dashboard and runbook links.
- Access to AWS CloudWatch, Datadog, Prometheus, and other monitoring tools for setting up and linking relevant dashboards.
- Collaboration with the operations and development teams to ensure that the correct runbooks are included and kept up to date.

## Acceptance Criteria
- Should have added links to relevant dashboards and runbooks in all High Severity (Sev-1 and Sev-2) AutoCut tickets.
- Should have tested the integration by simulating High Severity incidents and verifying that the correct links are included in the tickets.
- Should have ensured that team members can quickly access the linked dashboards and runbooks to diagnose and resolve incidents.
- Should have updated documentation and provided training to the team on how to use the new AutoCut tickets with linked resources.
- Should have established a process for reviewing and updating the linked dashboards and runbooks as the system evolves.

### Gherkin
#### Scenario: Adding Links to Dashboards and Runbooks in High Severity AutoCuts
Given a High Severity incident occurs,
When an AutoCut is generated,
Then the ticket should include links to the relevant dashboards and runbooks for resolving the incident.

#### Scenario: Testing Links in High Severity AutoCuts
Given that an AutoCut ticket is generated for a simulated High Severity incident,
When the team views the ticket,
Then they should be able to quickly access the linked dashboards and runbooks to begin diagnosing and resolving the issue.

#### Scenario: Accessing Runbooks and Dashboards from AutoCut Tickets
Given an ongoing High Severity incident,
When a team member opens the AutoCut ticket,
Then they should see links to both the relevant monitoring dashboard and the remediation runbook, allowing them to resolve the issue efficiently.

## API
N/A

## External Links
- [AWS CloudWatch Dashboards Documentation](https://docs.aws.amazon.com/
- [Best Practices for Incident Response Playbooks](https://www.pagerduty.com/blog/incident-response-playbooks/)
