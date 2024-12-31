## Summary
**As a** DevOps engineer or infrastructure owner, **I want** to add a **CDK change set approval workflow step** before each **production stage** in infrastructure pipelines, **so that** I can review and approve infrastructure changes before they are applied to production environments, ensuring controlled and deliberate deployments.

Adding a CDK (AWS Cloud Development Kit) change set approval step allows for a human-in-the-loop verification of infrastructure changes. This prevents unintended changes from being applied to production by providing a manual checkpoint to review the proposed modifications, increasing the safety of production deployments.

### Vision
By integrating a change set approval workflow, teams will be able to review infrastructure modifications before they are applied to production. This will ensure that infrastructure changes are fully understood and vetted, reducing the risk of accidental misconfigurations or unintended changes that could affect production environments.

### Background
In infrastructure-as-code (IaC) workflows, changes are often deployed automatically through CI/CD pipelines. However, some environments—especially production—require additional scrutiny before applying changes. A change set approval workflow allows for a manual review of the AWS CDK-generated change sets before they are executed in production, providing an extra layer of control and ensuring that only approved changes are deployed.

### Purpose
The purpose of this story is to introduce a manual **change set approval step** in the CDK pipeline for production stages. This will allow authorized personnel to review the change set for any infrastructure modifications and approve or reject the changes before they are deployed to production.

## Details

### 1. **Configure CDK to Generate Change Sets**
   - Ensure that the CDK pipeline is configured to generate and use **change sets** in AWS CloudFormation. A change set is a preview of the infrastructure changes that will be applied if the deployment proceeds.

   **Example Command to Synthesize a CDK Change Set**:
   ```bash
   cdk deploy --no-execute
   ```
   This command generates a change set but does not execute it, allowing a manual review before applying changes.

### 2. **Integrate Approval Workflow in CI/CD Pipeline**
   - Modify the CI/CD pipeline (e.g., **AWS CodePipeline**, **GitLab CI**, **Jenkins**) to add a manual approval step before executing the change set in the production stage.
   - The workflow should include:
     - **Generating the Change Set**: The pipeline should first generate the CloudFormation change set without applying it.
     - **Approval Step**: Before proceeding to the "Apply" step, add a manual approval step that requires an authorized person to review and approve the change set.
     - **Execution of the Change Set**: Upon approval, the change set will be applied to the production environment.

   **Example (AWS CodePipeline with Manual Approval)**:
   ```json
   {
     "Name": "CDKChangeSetApproval",
     "ActionTypeId": {
       "Category": "Approval",
       "Owner": "AWS",
       "Provider": "Manual",
       "Version": "1"
     },
     "RunOrder": 1
   }
   ```

   **Pipeline Stage Workflow**:
   - **Change Set Creation**: CDK generates the change set for review.
   - **Manual Approval**: The change set is reviewed by an approver, who either approves or rejects it.
   - **Execution of Change Set**: Upon approval, the pipeline applies the change set to production.

### 3. **Define and Configure Approval Permissions**
   - Ensure that only authorized users have the permissions required to approve or reject change sets in the pipeline. Use **AWS IAM roles** to enforce these permissions.
   - Configure notifications to the appropriate stakeholders when a change set is ready for review and approval. Notifications can be sent via **SNS**, **Slack**, or **email**.

   **Example of Approval Role Configuration**:
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": [
           "cloudformation:DescribeChangeSet",
           "cloudformation:ExecuteChangeSet"
         ],
         "Resource": "*"
       }
     ]
   }
   ```

### 4. **Automate Change Set Review**
   - In addition to manual review, automate certain checks on the change set:
     - Verify that resource deletions are intentional.
     - Check for configuration drift or major changes in resource costs.
     - Ensure that security groups and IAM policies meet security standards.

   Automated checks can trigger alerts or additional approval steps if significant changes (e.g., resource deletions, cost impacts) are detected.

### 5. **Integrate Notifications and Alerts**
   - Set up notifications to alert the team when a change set is awaiting approval. Integrate these notifications with tools like **Slack**, **PagerDuty**, or **SNS** to inform the appropriate stakeholders.
   - Notify the team of the result of the approval, whether the change set was approved, rejected, or requires further action.

   **Example Notification (SNS)**:
   ```bash
   aws sns publish --topic-arn arn:aws:sns:region:account-id:MyTopic --message "Change set ready for approval in production"
   ```

### 6. **Testing and Validation**
   - Test the workflow by deploying a simple infrastructure change to a non-production environment. Ensure that the change set is generated, and the approval step is triggered correctly.
   - Verify that the approvers are notified, and the change set is only applied after approval.
   - Validate that rejected change sets halt the deployment process and do not proceed to production.

### Testing
- Trigger a test deployment and verify that the change set is created and ready for review.
- Approve or reject the change set in a non-production environment to verify that the approval workflow functions as expected.
- Ensure that the pipeline proceeds to the execution stage only after the change set has been approved.
- Validate that notifications are sent to the appropriate stakeholders when a change set requires approval.

## Acceptance Criteria
- Should integrate a change set approval step into the CDK pipeline before applying changes to the production environment.
- Should ensure that the pipeline generates and holds the change set for manual review and approval.
- Should ensure that only authorized personnel can approve or reject change sets.
- Should send notifications to the relevant stakeholders when a change set is ready for review and when it has been approved or rejected.
- Should test the approval workflow to ensure proper functionality and verify that deployments only proceed after approval.

### External Links
- **AWS CDK Documentation**: [AWS CDK CLI](https://docs.aws.amazon.com/cdk/latest/guide/cli.html)
- **AWS CodePipeline Manual Approval**: [AWS Manual Approval Action](https://docs.aws.amazon.com/codepipeline/latest/userguide/approvals-action-add.html)
- **CloudFormation Change Sets**: [CloudFormation Change Set Documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/change-sets.html)
