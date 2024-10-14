
# Reevaluate alarm thresholds for services and Sev3/Sev2 thresholds
### Summary
**As a** Site Reliability Engineer, **I want** to reevaluate alarm thresholds for services and define updated thresholds for Sev3 and Sev2 incidents, **So That** we can ensure that alarms are appropriately triggered for performance degradation and critical issues, minimizing false positives and false negatives while maintaining service reliability and reducing downtime.

This story focuses on reviewing and refining the alarm thresholds for services to better reflect current performance requirements and operational expectations. It also includes reevaluating thresholds for Severity 3 (Sev3) and Severity 2 (Sev2) incidents to ensure that incidents are classified appropriately based on their impact, enabling a more effective and efficient incident response.

### Vision
By reevaluating alarm thresholds and updating Sev3 and Sev2 incident thresholds, we ensure that alarms are triggered for actual performance degradation or critical issues, preventing unnecessary alerts while ensuring that the operations team is informed promptly of impactful incidents. Properly defined thresholds allow the team to focus on meaningful issues and respond effectively to prevent outages or mitigate service impact.

### Background
Current alarm thresholds and incident classification levels (Sev3, Sev2) may no longer align with the evolving performance and operational requirements of services. This can result in either too many false alarms or missed critical issues. Without proper threshold management, the system may fail to detect significant issues in time, or it may overwhelm the operations team with non-critical alerts. Reevaluating these thresholds ensures more accurate incident management and timely responses to performance degradation or outages.

### Purpose
The purpose of this story is to review and refine alarm thresholds for services, as well as Sev3 and Sev2 incident thresholds. This initiative aims to improve the accuracy and effectiveness of alarms, reduce noise from false positives, and ensure that incidents are classified based on their actual impact, leading to better operational responses and improved service reliability.

## Details
1. **Review Current Alarm Thresholds**:
    - Gather data on the current alarm thresholds for each critical service, including CPU utilization, memory usage, response times, error rates, and other relevant metrics.
    - Analyze historical alarm data to determine if alarms are being triggered too frequently (false positives) or if critical issues are being missed (false negatives).
    - Collect feedback from the operations and engineering teams to identify which alarms are effective and which ones may need adjustment.

2. **Evaluate Current Sev3 and Sev2 Thresholds**:
    - Review the current definitions and thresholds for Severity 3 (Sev3) and Severity 2 (Sev2) incidents, including response time expectations and the impact level that triggers each severity.
    - Reassess incident classifications based on their actual impact on user experience, system performance, and business operations.
    - Consider new factors such as dependencies on external services, changes in service architecture, or increased user traffic that may require adjustments to the incident thresholds.

3. **Set Updated Alarm Thresholds**:
    - Adjust alarm thresholds to better reflect the current performance expectations and prevent false positives or missed critical issues. This could involve:
      - Setting higher thresholds for CPU and memory utilization if the current levels are too low for the expected traffic.
      - Refining error rate thresholds for key APIs to trigger alarms when error rates exceed normal operational bounds.
      - Adjusting response time thresholds to reflect actual user expectations and business SLAs.
    - Ensure that alarm thresholds are aligned with service-level agreements (SLAs) and operational needs.

4. **Redefine Sev3 and Sev2 Thresholds**:
    - Define updated thresholds for Sev3 and Sev2 incidents based on the operational impact. Example criteria:
      - **Sev3**: Non-critical service degradation, performance issues affecting a small subset of users, or slower-than-expected response times. Requires attention but does not immediately impact critical functionality.
      - **Sev2**: Significant service degradation, functionality loss for a large portion of users, or high error rates that threaten system availability. Requires immediate attention and response.
    - Document the updated criteria for Sev3 and Sev2 incidents to ensure consistent classification by the operations team.

5. **Test Updated Thresholds in a Staging Environment**:
    - Implement the updated thresholds in a staging or test environment and run tests to ensure that alarms are triggered as expected based on the new settings.
    - Simulate service degradation or failures to verify that Sev3 and Sev2 incidents are classified correctly and that the appropriate alarms are triggered.

6. **Monitor and Adjust Thresholds in Production**:
    - Once the updated thresholds are implemented in production, monitor the alarms and incident responses to ensure they align with operational expectations.
    - Continuously gather feedback from the operations team to identify if further adjustments are needed based on real-world behavior and incident management.
    - Review alarms periodically to ensure they continue to reflect the system's performance and adjust thresholds as necessary.

### Testing
- Test the updated alarm thresholds in a controlled staging environment to ensure they are accurately reflecting performance degradation and issues.
- Simulate different failure scenarios and validate that the correct Sev3 or Sev2 alarms are triggered based on the updated thresholds.
- Monitor the volume and relevance of alarms triggered after implementing the new thresholds to ensure that unnecessary alerts are minimized while critical issues are caught promptly.
- Ensure that the correct alerts are sent to the incident response team when Sev3 and Sev2 incidents occur.

### External Dependencies
- Access to monitoring tools (e.g., AWS CloudWatch, Datadog, Prometheus) for configuring and testing updated alarm thresholds.
- Integration with the incident management platform (e.g., PagerDuty, Opsgenie) to test incident classification and response workflows.
- Collaboration with the operations and development teams to define and validate alarm and incident thresholds.

## Acceptance Criteria
- Should have reviewed and analyzed current alarm thresholds and incident classification levels (Sev3 and Sev2) for critical services.
- Should have adjusted alarm thresholds based on performance requirements, historical data, and operational feedback.
- Should have redefined and documented the thresholds for Sev3 and Sev2 incidents to reflect their actual impact on the system.
- Should have tested the updated thresholds in a staging environment to ensure accurate alarm triggering and incident classification.
- Should have implemented the updated thresholds in production, monitored alarm behavior, and made adjustments as necessary based on feedback.

### Gherkin
#### Scenario: Updating Alarm Thresholds for Services
Given the current alarm thresholds,
When the performance data is reviewed and analyzed,
Then the alarm thresholds should be updated to better reflect current performance requirements and reduce false positives.

#### Scenario: Triggering Correct Sev3 and Sev2 Incidents
Given the updated thresholds for Sev3 and Sev2 incidents,
When service degradation or failure occurs,
Then the correct severity level (Sev3 or Sev2) should be triggered based on the impact on the system and user experience.

#### Scenario: Testing Updated Alarm Thresholds
Given the implementation of updated thresholds in a staging environment,
When simulated service failures or performance issues occur,
Then the alarms should trigger based on the new thresholds and be categorized correctly as Sev3 or Sev2 incidents.

## API
N/A

## External Links
- [AWS CloudWatch Alarms Documentation](https://docs.aws.amazon.com/
- [Datadog Monitor Configuration](https://docs.datadoghq.com/monitors/)
- [Incident Management Best Practices](https://www.pagerduty.com/blog/incident-response-best-practices/)
