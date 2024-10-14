
# Document means and purpose of making changes to services outside of automated code deployments
### Summary
**As a** DevOps Engineer, **I want** to document the means and purpose of making changes to services outside of automated code deployments, **So That** teams understand when and how to make manual changes to services, ensuring that such changes are controlled, documented, and justified.

This story focuses on defining situations where manual changes to services (outside of the automated Continuous Integration/Continuous Deployment (CI/CD) pipeline) are necessary, what tools are used to implement those changes, and how to track and document them to maintain service integrity and compliance with operational standards.

### Vision
By documenting and controlling manual changes to services outside of automated deployments, we maintain system stability, traceability, and compliance with internal processes. This ensures that any changes made outside the normal pipeline are well-justified, logged, and monitored to prevent unintended consequences.

### Background
Automated code deployments are the standard practice for updating and managing services in production, reducing human error and ensuring consistency. However, there are certain scenarios where manual changes are necessary. These could include urgent fixes, configuration adjustments, or specific maintenance tasks that cannot wait for a full deployment cycle. While such changes are sometimes unavoidable, they should be carefully controlled, documented, and logged to ensure accountability and minimize risk.

---

### Means and Purpose of Making Changes Outside of Automated Deployments

#### 1. **Purpose of Manual Changes**

Manual changes to services are necessary in specific cases where automated deployments may not be appropriate or timely. Some scenarios where manual changes may be required include:

- **Urgent Hotfixes**: In cases where a critical bug or service outage occurs and waiting for a full CI/CD pipeline deployment would take too long, a manual fix or adjustment might be needed.
- **Configuration Changes**: Some services, particularly those hosted on cloud platforms like AWS, may require runtime configuration changes that are not part of the regular deployment process (e.g., adjusting IAM roles, modifying autoscaling settings).
- **Security Patches**: In cases where a critical security vulnerability must be patched immediately and cannot wait for a full deployment cycle.
- **Maintenance and Operational Adjustments**: Changes needed for performance tuning, scaling adjustments, or infrastructure modifications, such as increasing EC2 instance sizes or adjusting network settings.

While these changes are valid in certain cases, they need to be closely monitored and controlled.

---

#### 2. **Tools and Methods for Manual Changes**

Various tools can be used to implement manual changes outside of automated deployments, depending on the type of change required. Below are the primary methods and tools used for making manual changes.

##### 2.1 **AWS Management Console**

For cloud-based services hosted in AWS, the AWS Management Console provides a graphical interface to manually modify services.

- **Purpose**: Use for configuration changes (e.g., scaling adjustments, changing IAM roles, updating security groups) or infrastructure updates (e.g., modifying EC2 instances, updating S3 bucket policies).
- **Example**: Manually scaling an ECS service by increasing the number of tasks or modifying autoscaling rules.

##### 2.2 **AWS CLI (Command Line Interface)**

For users comfortable with the command line, the AWS CLI provides the means to interact with and modify AWS services programmatically without using the AWS Console.

- **Purpose**: Use for making controlled changes to AWS resources (e.g., modifying Lambda function configurations, updating RDS instances, adjusting CloudWatch alarms).
- **Example**: Using the AWS CLI to increase the desired count for an ECS service or to update environment variables for a Lambda function.

```bash
aws ecs update-service --cluster <cluster-name> --service <service-name> --desired-count <new-count>
```

##### 2.3 **Infrastructure as Code (IaC) Tools**

While changes outside of automated deployments usually bypass the main pipeline, using **Infrastructure as Code (IaC)** tools like **Terraform** or **AWS CloudFormation** can ensure that manual infrastructure changes are still tracked and managed as code.

- **Purpose**: Use IaC tools to implement infrastructure changes in a controlled way while maintaining traceability. These changes can later be incorporated into the main CI/CD pipeline.
- **Example**: Updating a CloudFormation stack to apply urgent infrastructure changes or running Terraform commands to adjust network settings.

##### 2.4 **Kubernetes kubectl**

For services running on **Kubernetes**, the **kubectl** tool allows for manual intervention when necessary, such as scaling pods, modifying configurations, or updating deployments outside of automated processes.

- **Purpose**: Use kubectl for real-time changes to Kubernetes resources like deployments, services, or config maps.
- **Example**: Scaling a Kubernetes deployment manually to handle traffic surges or applying a quick patch to a service before a full redeployment.

```bash
kubectl scale deployment <deployment-name> --replicas=3
```

##### 2.5 **Direct Database Access (With Caution)**

Direct changes to databases (e.g., via SQL queries or database management tools) should be avoided whenever possible, as they bypass the usual application logic and can introduce inconsistency. However, in emergency situations, direct access may be necessary.

- **Purpose**: Use direct database access for emergency fixes or updates, but ensure these changes are logged, and if possible, made part of the automated process later.
- **Example**: Running an urgent SQL query to remove incorrect data from a critical table or updating a record to restore service availability.

---

#### 3. **Best Practices for Making Manual Changes**

While manual changes may be necessary, they introduce potential risks, such as human error, configuration drift, and lack of traceability. To mitigate these risks, follow these best practices:

##### 3.1 **Document All Changes Thoroughly**

Ensure that every manual change is documented. This includes the rationale for the change, the expected outcome, the commands or actions taken, and any potential risks or side effects. This documentation should be included in:

- **Runbooks**: If the change is part of standard operational procedures, update the runbook with detailed steps for future reference.
- **Change Logs**: Maintain a change log that tracks all manual changes, including the author, time, and description of the change.
- **Incident Reports**: If the manual change is in response to an incident, ensure that it is documented as part of the incident report.

##### 3.2 **Implement a Rollback Plan**

Every manual change should have a rollback plan in case the change introduces new issues. This may include:

- Reverting configuration changes or infrastructure modifications.
- Deploying a known good version of the service.
- Rolling back database updates or patches.

Before making a manual change, ensure that you know how to revert it if needed.

##### 3.3 **Ensure Visibility and Approvals**

Manual changes should not be made in isolation. Ensure that all stakeholders are aware of the change and that necessary approvals are obtained before proceeding. This could involve:

- **Approvals**: Obtain approval from the team lead, manager, or incident commander (for critical changes).
- **Notifications**: Notify the broader team, including operations and development teams, of the intended change and its expected impact.

##### 3.4 **Track Changes in Version Control**

Even if changes are made manually, the corresponding changes (e.g., configuration updates, environment changes) should be committed to version control to prevent configuration drift and ensure the change is reflected in the main codebase. This helps ensure that future automated deployments do not overwrite the manual change.

##### 3.5 **Monitor After Making the Change**

After making a manual change, monitor the service to ensure that the change has the desired effect and does not introduce any new issues. This includes:

- Checking service health and performance metrics (e.g., through CloudWatch, Datadog).
- Reviewing logs for any unexpected errors or issues.
- Monitoring user impact (if applicable).

---

#### 4. **When to Avoid Manual Changes**

In most cases, manual changes should be avoided in favor of automated deployments. Scenarios where manual changes are discouraged include:

- **Routine Updates**: For regular updates and feature deployments, always use the automated CI/CD pipeline to ensure consistency and reduce risk.
- **Complex Changes**: Complex changes involving multiple components or systems should go through proper planning, testing, and deployment processes.
- **Unvetted Changes**: Avoid making manual changes that have not been vetted or tested in a staging environment, as this increases the risk of introducing new issues.

---

### Documentation Process for Manual Changes

To ensure transparency and traceability, follow the documentation process for manual changes:

##### Step 1: Create a Change Request

Before making a manual change, create a formal **change request** detailing:

- The reason for the change (e.g., incident resolution, urgent patch).
- The expected outcome.
- The steps involved in the manual change.
- The rollback plan.

##### Step 2: Log the Change

After the change is made, log it in the appropriate system (e.g., Jira, Confluence, or a dedicated change log). Include:

- The change date and time.
- The person responsible for making the change.
- The specific commands or steps taken.
- The outcome of the change (successful or not).
- Any follow-up actions or monitoring results.

##### Step 3: Update Documentation and Version Control

- **Update Runbooks**: If the manual change is part of a standard operational procedure, update the relevant runbook with detailed steps.
- **Commit to Version Control**: Ensure that any code or configuration changes are committed to version control to
