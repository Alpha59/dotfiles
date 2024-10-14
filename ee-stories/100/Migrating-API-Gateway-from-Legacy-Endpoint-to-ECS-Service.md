
# Migrating API Gateway from Legacy Endpoint to ECS Service
*Repeated for each of the 4 applications*


### **Summary:**


**As a** developer, **I want** to migrate the existing API Gateway from a legacy endpoint to a new  Elastic Container Service (ECS) endpoint **so that** I can deprecate the Old service.


### **Background:**

We have an existing API Gateway that connects to a legacy endpoint. To modernize our infrastructure, we need to replace this legacy endpoint with a new one hosted on  Elastic Container Service (ECS). This migration involves updating API Gateway, establishing IAM permissions between ECS and API Gateway, and removing any outdated CDK Constructs used for the old endpoint (Private Link).

### **Description:**

This story outlines the steps for migrating API Gateway from a legacy endpoint to a new ECS service.

1. **Assessment:**
    1. Conduct a thorough review of the existing API Gateway configuration to identify the legacy endpoint being used.
2. **Update API Gateway Configuration:**
    1. Modify the API Gateway configuration to point to the new ECS service endpoint.
    2. Update the route definitions and integration settings accordingly.
3. **IAM Permissions:**
    1. Establish the necessary IAM permissions to allow API Gateway to communicate with the ECS service.
    2. Ensure the IAM roles and policies are correctly configured to enable this interaction.
4. **Testing:**
    1. Conduct thorough testing to verify that API Gateway now correctly communicates with the new ECS service.
    2. Test various endpoints and verify that the expected responses are received.
5. **Error Handling:**
    1. Ensure that error handling is updated to work with the ECS service responses.
    2. Test different error scenarios and verify that the application handles them gracefully.
6. **Cleanup Old Endpoint:**
    1. Remove any legacy configurations and constructs that were specific to the old endpoint.
    2. This may include deleting Private Link configurations or any CDK Constructs related to the legacy service.
7. **Quality Assurance:**
    1. Conduct code reviews to ensure code quality and adherence to best practices.
    2. Validate that all legacy components and configurations are removed.
8. **User Acceptance Testing (UAT):**
    1. Deploy the updated API Gateway to a staging environment for UAT.
9. **Deployment:**
    1. Deploy the updated API Gateway to the production environment.
    2. Monitor for any issues post-deployment and be ready to roll back if necessary.
10. **Documentation Update:**
    1. Update the documentation to reflect the changes and new integration with the ECS service.
    2. Provide guidelines for future development and maintenance.
11. **Completion:**
    1. Confirm with stakeholders that the migration is successful.
    2. Close the ticket once the updated API Gateway is in production and running smoothly.

**Acceptance Criteria:**


* **Should have:** Updated API Gateway configuration.
* **Should have:** Correct route definitions and integration settings.
* **Should have:** Established IAM permissions.
* **Should have:** Thoroughly tested endpoints.
* **Should have:** Validated error handling.
* **Should have:** Cleaned up old configurations.
* **Should have:** Deployed to the production environment.
* **Should have:** Updated documentation.
