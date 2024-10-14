
# Investigate the most frequently requested ticket types and to design AWS Lambda functions for automating their resolution
## Summary
[//]:# (This summary outlines the initiation of a project to investigate the most frequently requested ticket types and to design AWS Lambda functions for automating their resolution. This will enhance the efficiency of the support system by reducing manual intervention and speeding up response times.)

**AS an** on-call team member,
**I WANT** to investigate the top ticket types and design corresponding AWS Lambda functions,
**SO THAT** we can automate the resolution of common issues and improve the overall efficiency of our ticket handling process.

## Additional Context
[//]:# ()

The investigation will focus on the ticket types listed in previous discussions, grouped based on similarities in the type of issue they represent. This process includes defining the automation requirements and the conditions under which these Lambda functions can be initiated within the AutoSIM system.

This ticket is to be used as a blueprint for the development and deployment of AWS Lambda functions that will automate the resolution of the most common ticket types, thereby enhancing the operational efficiency of the team.

Some ticket types can be resolved automatically by the AutoSIM, and a comment added to the ticket explaining the actions taken. Other tickets will only be able to query the database for relevant information and attach it to the ticket (for instance, query based on DSN to acquire additional information approximating state).

Initially identified ticket types:

*  needs to be out of Priority in pedigree
* Warranty Service Cancel Request
* Defect code(s) not mapped for device
* Peak Scaling Estimated Throughput Requests
* Create Flags
* Cancel Flags

Existing AutoSIM Rules that may be automatable:

* ConflictingDomainExistsException
* Request FATS setup
* Permissions Request KRL Portal
* QueueSize (Re-run queues)
* Workflow Guidance Data Insert

## Acceptance Criteria
[//]:# (These criteria define the specific outcomes needed to ensure the successful completion of this story, focusing on the identification and automation design of the top ticket types.)

- Should have conducted a comprehensive analysis of the top ticket types to understand the common factors and triggers.
- Should have identified specific actions that can be automated for each top ticket type, based on the common issues and required responses.
- Should have designed AWS Lambda functions for each group of ticket types, detailing the necessary triggers, actions, and configurations.
- Should have created a preliminary test plan to validate the effectiveness and coverage of the designed Lambda functions.
- Should have documented the design for each Lambda function, including its integration with the AutoSIM system and any dependencies on other AWS services.
- Should have developed a deployment strategy for the Lambda functions, ensuring minimal disruption to existing processes and easy rollback capabilities.
- Should have identified and created designs/ticket for top 5 most impactful lambdas to implement.

### Detailed Explanation of Ticket Types and Grouping:

- **DNS Configuration Errors**: Multiple tickets related to DNS issues, such as failed creation or dangling DNS entries, suggest a common automation area.
- **Service Request Management**: Includes tickets for warranty cancellations, device replacements, and flag management, which regularly require standardized data updates and status changes.
- **Fault Management**: Tickets reporting high fault counts and operation alarms indicate a need for automated diagnostics and corrective actions.
- **Software and System Updates**: Involves tickets prompting software or operating system updates, which can be automated to check for and apply necessary patches or configuration changes.
- **Resource Scaling Requests**: Peak scaling and throughput issues demand dynamic adjustments to resource allocations, suitable for Lambda automation.

1. **Allegiance Failed to Create Custom DNS Record...** (Various Subtypes)
   - **Occurrences**: Varies (124, 61, 59, 50, 45, 34, 26, 20)
   - **Explanation**: Alerts indicating failure in DNS record creation processes. The typical response involves reviewing settings and ensuring compliance with provisioning standards.

2. **US: Error Cancelling Warranty Service Request**
   - **Occurrences**: 107
   - **Explanation**: Issues related to the cancellation of warranty services, where manual intervention is required to resolve discrepancies in service status or data.

3. **US:  Replacement Error**
   - **Occurrences**: 50
   - **Explanation**: Problems encountered during the device replacement process, usually requiring a review of transaction records or system updates to correct errors.

4. **[Shepherd] Update operating system/software - 1 Issue detected**
   - **Occurrences**: 44 (operating system), 18 (software)
   - **Explanation**: Notifications from the Shepherd monitoring system about required updates or issues detected with software or operating systems that need to be addressed promptly.

5. **[Action Required] AAA-Symmetric Deprecation in...**
   - **Occurrences**: 27
   - **Explanation**: Action required for deprecation processes related to AAA-Symmetric configurations, often requiring updates or configuration changes.

6. **[Shepherd] Dangling DNS Not Allowed For Other...**
   - **Occurrences**: 26
   - **Explanation**: Issues related to DNS configurations that are non-compliant with network policies, specifically unmanaged or 'dangling' DNS entries.

7. **KRDS.NA.deprioritizeReturnEvent.HighFaultCount**
   - **Occurrences**: 19
   - **Explanation**: High fault counts in return event processing within the KRDS system, indicating potential issues in processing logic or data integrity.

8. **KRSS.NA.Receive
   - **Occurrences**: 17
   - **Explanation**: Alerts regarding high fault counts during device reception processes, suggesting errors in input data or system handling.

9. **
   - **Occurrences**: 16
   - **Explanation**: Issues with cancellation processes within the   Management Service, typically involving faults or errors requiring immediate resolution.

10. **Pedigree Flagging: Request to Unflag DSNs**
    - **Occurrences**: 15
    - **Explanation**: Requests to remove flags from device serial numbers in the Pedigree system, usually for devices incorrectly flagged or after resolving the underlying issues.

11. **
    - **Occurrences**: 15
    - **Explanation**: Severe level 3 faults reported in the  Lambda function, necessitating immediate attention to maintain service integrity.

12. **[ALARM] [us-east-1] [
    - **Occurrences**: 14
    - **Explanation**: Alarms triggered by operational issues within the  production environment, often indicating critical errors that affect service performance.

13. **Network Configuration Errors**
   - **Explanation**: Tickets related to misconfigurations or failures in network settings that impact service delivery or system performance.

14. **Software Licensing Issues**
   - **Explanation**: Problems associated with software licensing, including renewals, compliance, or activation issues that need resolution to maintain software functionality.

15. **Data Integrity Checks**
   - **Explanation**: Tickets triggered by system checks that find inconsistencies or errors in data, requiring verification and corrections to ensure accuracy and reliability.

16. **Security Alert Responses**
   - **Explanation**: Alerts related to security issues such as breaches, vulnerabilities, or unauthorized access attempts that require immediate action to safeguard systems.

17. **Hardware Malfunction Reports**
   - **Explanation**: Tickets reporting hardware failures or malfunctions that affect device operations or system performance, necessitating repair or replacement.

18. **User Access Issues**
   - **Explanation**: Requests from users experiencing difficulties accessing systems or services, often involving permissions, authentication, or connectivity problems.

19. **Compliance Audit Queries**
   - **Explanation**: Tickets raised as part of compliance audits that require documentation, evidence, or actions to demonstrate compliance with relevant standards and regulations.

20. **Performance Degradation Notifications**
   - **Explanation**: Alerts related to the degradation of system performance, identifying slow response times or other indicators of reduced efficiency.
