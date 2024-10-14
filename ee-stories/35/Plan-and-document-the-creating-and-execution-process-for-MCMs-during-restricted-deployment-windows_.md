
# Plan and document the creating and execution process for MCMs during restricted deployment windows.
### Summary
**As a** DevOps Engineer, **I want** to plan and document the process for creating and executing Major Change Management (MCM) requests during restricted deployment windows, **So That** we ensure smooth and compliant deployments during limited timeframes, minimizing disruption and adhering to regulatory or operational constraints.

This story focuses on establishing a clear and repeatable process for preparing and executing MCMs within restricted deployment windows. It covers how to schedule, prepare, execute, and review MCMs, ensuring minimal risk and maximum coordination during high-risk or time-sensitive changes.

### Vision
By having a well-documented process for creating and executing MCMs during restricted deployment windows, we ensure that all changes are carefully planned, risks are mitigated, and necessary approvals are obtained. This reduces the chance of deployment errors and ensures compliance with operational and regulatory requirements, particularly in time-constrained environments.

### Background
Restricted deployment windows are often necessary due to operational, regulatory, or business constraints, particularly in industries where uptime is critical, or there are periods where deployments must be carefully managed (e.g., retail holiday seasons, financial reporting periods). Major changes during these windows must be executed carefully, with proper planning and coordination, to avoid service disruptions or security issues.

## Details

1. **Define MCM Criteria for Restricted Deployment Windows**
   - Identify and define what constitutes a Major Change Management (MCM) request. Typical criteria include:
     - Changes that involve significant infrastructure, codebase, or system modifications.
     - High-risk changes (e.g., changes to critical systems, database migrations, security updates).
     - Changes that require downtime or impact multiple services.
   - Define restricted deployment windows where special approval or processes are required (e.g., end-of-quarter, holidays, or peak operational periods).

2. **MCM Request Preparation Process**
   - **Pre-Approval and Scheduling**:
     - Begin the MCM planning process well in advance of the restricted window.
     - Submit an MCM request outlining the details of the change, including the following information:
       - Description of the change.
       - Scope and affected services.
       - Justification for why the change is needed during the restricted window.
       - Risk assessment, including potential impacts and mitigations.
       - Rollback plan and contingency strategies in case of failure.
     - Get approval from stakeholders (e.g., leadership, risk management teams, business owners) well in advance of the deployment window.

   - **Risk and Impact Assessment**:
     - Conduct a formal risk assessment, identifying critical risks that need to be managed during deployment.
     - Ensure that all dependencies are mapped, including upstream and downstream services.
     - Review previous similar MCMs to identify any common pitfalls or risks encountered during execution.
     - Define a rollback strategy that can be executed quickly if the change fails.

   - **Change Freeze**:
     - Implement a change freeze period prior to the restricted window, allowing only pre-approved MCMs to proceed.
     - Ensure all other non-critical deployments are postponed until after the window.

3. **Create and Test Execution Plan**
   - **Pre-Execution Testing**:
     - Thoroughly test the change in a staging environment that mirrors production as closely as possible.
     - Simulate potential failure scenarios and practice rollbacks to ensure preparedness.
     - Ensure all necessary monitoring and logging tools are set up to track the deployment in real time.

   - **Runbook Creation**:
     - Create a detailed runbook for the MCM execution. The runbook should include:
       - Step-by-step execution process, including validation checkpoints.
       - Roles and responsibilities of each team member involved.
       - Time estimates for each step, including a go/no-go decision point.
       - Communication plan (who needs to be informed and when).
       - Clear rollback instructions with designated triggers for invoking the rollback.
     - Ensure that the runbook is reviewed and signed off by all stakeholders before execution.

   - **Contingency Planning**:
     - Identify potential points of failure and ensure contingency plans are in place.
     - Assign dedicated team members responsible for monitoring system health and initiating rollback if necessary.

4. **Execution Process During Restricted Window**
   - **Pre-Execution Checklist**:
     - Ensure that all pre-execution checks are completed (e.g., backups taken, notifications sent, approval given).
     - Confirm the availability of all necessary resources (e.g., on-call engineers, monitoring tools).
     - Conduct a final review of the execution plan, confirming readiness for go-live.

   - **Execution**:
     - Execute the MCM within the predefined deployment window according to the runbook.
     - Monitor the system in real time during the execution, ensuring that any issues are immediately identified and mitigated.
     - Pause at pre-determined checkpoints to confirm that everything is proceeding as planned.

   - **Go/No-Go Decision**:
     - At the designated go/no-go point, assess the state of the system and decide whether to proceed with the rest of the deployment or invoke the rollback plan.

   - **Post-Execution Verification**:
     - Once the change is deployed, run a full set of tests to verify the health and performance of the system.
     - Ensure that all affected services are functioning correctly and that there are no unexpected side effects.
     - Continue monitoring for any delayed issues that may arise.

5. **Post-Execution Review and Documentation**
   - **Post-Mortem Review**:
     - Conduct a post-mortem review of the MCM, regardless of whether it was successful or required a rollback.
     - Document any lessons learned or issues encountered during the deployment.
     - Use these insights to improve future MCM processes, particularly during restricted windows.

   - **Documentation**:
     - Archive the MCM request, runbook, and post-mortem report in a centralized location for future reference.
     - Ensure all logs, monitoring data, and rollback actions are documented for audit and compliance purposes.

6. **Communication Plan**
   - **Internal Communication**:
     - Ensure that all relevant stakeholders, including engineering, operations, and business teams, are informed about the MCM and any potential impacts.
     - Set up communication channels (e.g., Slack, email) for real-time updates during the deployment.

   - **Customer Communication**:
     - If the MCM has customer-facing impacts (e.g., brief downtime), ensure that communication is sent to affected users or clients in advance.
     - Provide regular updates on the status of the deployment and confirm when the changes are complete.

### Testing
- Test the full MCM process in a staging environment, simulating the conditions of the restricted deployment window.
- Validate that the rollback plan can be executed smoothly and within the time constraints if necessary.
- Confirm that the monitoring tools are correctly tracking system health and that alerts are properly configured.

### Acceptance Criteria
- Should have documented a detailed process for creating and executing MCMs during restricted deployment windows.
- Should have completed and tested a runbook for executing MCMs, including rollback and contingency plans.
- Should have communicated the process and execution plan to all relevant stakeholders.
- Should have executed a successful test deployment and documented the results.
