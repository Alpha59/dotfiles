
# Create a common wiki to link all dashboards for each service and stage
### Summary
**As a** DevOps Engineer, **I want** to create a common wiki to link all dashboards for each service and stage, **So That** team members have a centralized location to access monitoring and performance dashboards for every service and environment, improving visibility and efficiency when managing system health.

This story focuses on consolidating all dashboard links into a single wiki that serves as a central repository, making it easy for team members to navigate to the appropriate dashboard for any service or stage (development, staging, production). This will improve operational efficiency by providing quick access to critical performance metrics and logs.

### Vision
By creating a centralized wiki, we streamline the process of accessing dashboards, ensuring that developers, operators, and stakeholders can quickly monitor the health of services across various environments. This reduces time spent searching for specific dashboards and improves response times when investigating issues.

### Background
As systems grow in complexity, it becomes increasingly difficult to manage the various dashboards that track performance, metrics, and logs for different services and environments. A centralized wiki that links to all dashboards provides a single point of reference, improving operational efficiency and reducing confusion when trying to locate the appropriate monitoring tools.

## Details

1. **Gather Dashboard Information**
   - Collect links to all dashboards across various monitoring tools (e.g., **CloudWatch**, **Grafana**, **Datadog**, **Prometheus**), including:
     - **Service-Specific Dashboards**: Dashboards for individual services such as API servers, databases, and background jobs.
     - **Stage-Specific Dashboards**: Separate dashboards for each environment (e.g., development, staging, production).
   - Organize the links by service and environment for easy navigation.

2. **Create a Wiki Structure**
   - Design a clear and intuitive structure for the wiki that includes:
     - **Service Pages**: A dedicated page or section for each service, listing relevant dashboard links for all stages (e.g., development, staging, production).
     - **Stage Pages**: A separate page or section that organizes services by stage, making it easy to see all services and dashboards for a specific environment.
     - **Global Dashboards**: Links to cross-service dashboards or overarching system monitoring tools.

3. **Add Descriptions and Context**
   - For each dashboard link, provide a brief description explaining:
     - What the dashboard monitors (e.g., API performance, database metrics, error rates).
     - What service or component the dashboard is associated with.
     - Key metrics to watch on the dashboard (e.g., latency, CPU utilization, error rates).
     - Any alerts or notifications associated with that dashboard.

4. **Provide Access Control Information**
   - If certain dashboards require specific permissions or roles to access, note this in the wiki entry, along with steps for requesting access if needed (e.g., links to ServiceNow or internal access request processes).
   - Ensure that sensitive information related to access is properly secured and documented for authorized users.

5. **Embed Dashboard Previews (Optional)**
   - Where possible, embed live previews or snapshots of the dashboards directly in the wiki using available plugins or integrations (e.g., Grafana panels).
   - This gives users a quick overview of the current status without needing to navigate away from the wiki.

6. **Organize for Future Expansion**
   - Create a structure that allows for future growth as new services are added or existing ones evolve.
   - Ensure that adding new dashboards or modifying existing entries is straightforward and can be done with minimal effort.

7. **Testing and Feedback**
   - Share the wiki with the team and collect feedback on usability and organization.
   - Validate that all dashboard links are correct, accessible, and lead to the right environments.
   - Ensure the wiki is easy to navigate and that users can quickly locate the dashboards they need.

8. **Maintenance and Updates**
   - Assign a team or individual to maintain the wiki, ensuring that links are updated if dashboards are moved or changed.
   - Regularly review the wiki to ensure it stays current with changes in service architecture or environment configurations.
   - Provide a method for team members to request updates or additions to the wiki.

### Testing
- Verify that all dashboard links are correct and lead to the appropriate services and environments.
- Ensure that the wiki structure is intuitive and that users can easily find the dashboards they need.
- Test any embedded previews to ensure they display the correct metrics and update in real time.
- Collect feedback from the team to ensure the wiki meets their needs for monitoring and troubleshooting.

### Acceptance Criteria
- Should have a centralized wiki that links all dashboards for each service and stage.
- Should include clear descriptions for each dashboard, explaining its purpose and key metrics.
- Should provide access control information for dashboards requiring specific permissions.
- Should have tested and validated that all dashboard links are functional and accurate.
- Should have a clear process for maintaining and updating the wiki as services and dashboards evolve.
