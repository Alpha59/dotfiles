
# Create water rules and add links in run books for providing access or permissions to end users and teams needing to consume the service or UI.
### Summary
**As a** DevOps Engineer, **I want** to create and document water rules for providing access or permissions to end users and teams who need to consume the service or UI, **So That** we can ensure proper governance, security, and access management while streamlining the process for granting access.

This story focuses on defining the water rules (guidelines or policies for granting access), creating clear documentation, and providing links in the runbooks to guide team members through the process of providing appropriate permissions for users and teams who need access to the service or UI.

### Vision
By documenting water rules and embedding them in the runbooks, we ensure that access is granted in a secure, consistent, and auditable manner. These rules help ensure that only authorized users and teams can access the services or UIs, improving security while maintaining ease of access for appropriate stakeholders.

### Background
Access control and permission management are critical components of security and compliance. Water rules are sets of guidelines or policies that define the criteria for granting access to services or UIs, ensuring that access is managed in a way that balances security with user needs. These rules typically include user roles, required permissions, and the process for requesting and approving access.

### Purpose
The purpose of this story is to define water rules for providing access to services and UIs, document these rules in the runbook, and include links to relevant documentation or procedures for granting access or permissions. This will standardize the access management process, enhance security, and provide teams with a clear path for requesting and receiving access.

## Water Rules Definition
The following water rules will be used to govern access to services and UIs:

### 1. Access Requests and Approval Process
#### 1.1 Access Request Procedure
- **End Users**: End users must submit an access request through the organization's **Access Request System** (e.g., Jira, ServiceNow, or a custom request form).
- **Teams**: Team managers must submit a request for team-based access, including a list of team members requiring access.
- **Required Information**: Access requests must include the following details:
  - User's name and email.
  - Role or team name.
  - Level of access required (e.g., read-only, admin).
  - Purpose or justification for access (why the access is needed).
  - Approval from the user’s manager or team lead.

#### 1.2 Access Approval Process
- **Initial Review**: Access requests are reviewed by the service or UI owner to verify that the request is valid and appropriate.
- **Security Review**: A security review is conducted for any requests that involve elevated permissions (e.g., admin or write access).
- **Approval**: Once verified, the service owner approves the request and proceeds to grant the appropriate permissions.

### 2. Access Levels
Define access levels that users and teams can be granted based on their role or need for access.

#### 2.1 Common Access Levels
- **Read-Only Access**: Allows users to view data and use the service/UI but does not allow them to make changes.
- **Contributor Access**: Allows users to view and edit data but not perform administrative functions.
- **Admin Access**: Allows users to perform all actions, including configuration changes, user management, and data modification.

#### 2.2 Access Based on Role
- **End Users**: Typically require **Read-Only Access** to the service or UI for monitoring or information gathering.
- **Developers/Engineers**: Often require **Contributor Access** to modify or interact with the service or UI.
- **Admin/Team Leads**: May require **Admin Access** to manage configurations, user access, and settings within the service or UI.

### 3. Security and Compliance
All access requests and granted permissions must adhere to the organization’s security and compliance policies.

#### 3.1 Least Privilege Principle
- Access should be granted according to the **Least Privilege Principle**, where users are granted the minimum permissions necessary to perform their job functions.

#### 3.2 Role-Based Access Control (RBAC)
- Access should be provided through **Role-Based Access Control (RBAC)** wherever possible. Assign roles to users based on their job function, and map these roles to predefined permission sets (e.g., “Viewer,” “Editor,” “Admin”).

#### 3.3 Compliance Audits
- Periodically review and audit user permissions to ensure that access is still appropriate and complies with internal policies and any regulatory requirements.

### 4. Automated Provisioning
Where possible, access should be provisioned automatically using Identity and Access Management (IAM) solutions integrated with the service or UI.

#### 4.1 AWS IAM Access Management
- For AWS-hosted services, leverage **AWS IAM** to control access to AWS resources. Use **IAM Policies** to define access levels and assign these policies to users or groups.

#### 4.2 Active Directory or SSO Integration
- For internal systems, integrate access control with **Active Directory (AD)** or **Single Sign-On (SSO)** solutions to automate provisioning and de-provisioning of users based on their role.

## Runbook Documentation
The following steps should be documented in the runbook, along with links to relevant access request forms, IAM policies, or procedures:

### 1. Documenting Access Rules in the Runbook
Include a section in the runbook that outlines the water rules for granting access, detailing the process and approval workflow for end users and teams.

#### Example Runbook Section:
```markdown
## Access and Permissions for [Service/UI Name]

### Access Request Process:
1. Submit an access request via [Access Request System] (e.g., Jira, ServiceNow).
   - Include user details, role, and access level required.
   - Ensure manager approval is attached for elevated access.

2. The service owner will review and approve the request.

### Access Levels:
- **Read-Only Access**: View-only access to the service/UI.
- **Contributor Access**: Ability to modify data or settings.
- **Admin Access**: Full control over the service/UI, including user management.

### Security Guidelines:
- Access is granted based on the Least Privilege Principle.
- Access is reviewed periodically for security and compliance.

For more details on the access request process and required information, see [Access Request Documentation Link].
```

### 2. Adding Links to Access Request Forms and IAM Policies
Include links in the runbook that direct users to:
- **Access Request Forms**: Provide a direct link to the form or tool used for requesting access (e.g., Jira, ServiceNow).
- **IAM Policies**: Provide links to predefined **IAM policies** or access configurations for each access level (e.g., AWS IAM Policies for Read-Only, Contributor, Admin).
- **Documentation on Access Reviews**: Include a link to any internal documentation on how periodic access reviews or compliance checks are conducted.

#### Example Links in Runbook:
```markdown
### Relevant Links:
- [Access Request Form](https://yourcompany.servicenow.com/request-access)
- [AWS IAM Policies](https://aws.amazon.com/documentation/iam/)
- [Compliance Review Documentation](https://internaldocs.yourcompany.com/compliance/access-reviews)
```

### 3. Automating Permissions in IAM/Active Directory
For services integrated with IAM or Active Directory (AD), provide links to the relevant roles, policies, and user groups in the runbook. Include instructions for adding users to these roles or groups.

#### Example IAM/AD Permissions Documentation:
```markdown
### AWS IAM Role Assignments:
To grant access to [Service Name] via AWS IAM, follow these steps:
1. Open the [AWS IAM Console](https://console.aws.amazon.com/iam).
2. Navigate to **Roles** and search for the following predefined roles:
   - **Service_ReadOnly**: Provides read-only access to the service.
   - **Service_Contributor**: Provides edit-level access to the service.
   - **Service_Admin**: Provides full administrative access.

3. Assign the appropriate role to the user by following [AWS IAM Role Assignment Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html).

For more details on role assignments and permissions, see [IAM Policies Documentation](https://aws.amazon.com/documentation/iam/).
```

### 4. Monitoring and Auditing Access
Document procedures for periodic auditing of user access to ensure compliance with security policies. Include details on how to monitor access logs, revoke permissions, or adjust access levels as needed.

#### Example Monitoring and Auditing Section:
```markdown
### Monitoring and Auditing Access:
To ensure compliance with internal policies, user access is reviewed every 6 months. The following steps outline the review process:

1. Run a report on active users and their access levels from the [Access Management System].
2. Verify that all users have the appropriate level of access based on their role.
3. If access needs to be revoked or modified, submit a request via [Access Management System].

For auditing logs and reports, see [Audit Log Documentation](https://yourcompany.com/audit-logs).
```

### Testing
- **Access Request Test**: Test that users can request access using the defined process and that requests are routed to the appropriate approvers.
- **Permission Test**: Verify that the correct permissions are granted based on user roles and access levels.
- **Documentation Test**: Ensure that all runbook links are functional and lead to the correct documentation or access forms.

### External Dependencies
- **Access Management System (Jira, ServiceNow)**: For managing access requests.
- **AWS IAM**: For managing access to AWS-hosted services.
- **Active Directory/SSO**: For automating access to internal services.
- **Compliance Review Tools**: For auditing and reviewing access permissions.

## Acceptance Criteria
- Should have defined water rules for access and permissions, based on role and security requirements.
- Should have documented the access request and approval process in the runbook.
- Should have provided links to access request forms, IAM policies, and relevant documentation.
- Should have verified that the access request process is functional and users receive the correct permissions.
- Should have documented the periodic access review and audit process.

### Gherkin
#### Scenario: Submitting Access Requests
Given a user requires access to the service,
When they submit an access request via the access request system,
Then the request should be routed to the appropriate approver,
And the user should be granted the correct level of access based on the approval.

#### Scenario: Documenting Access and Permissions in the Runbook
Given the water rules are defined,
When I update the runbook,
Then the access request process and approval workflow should be clearly documented,
And links to relevant forms and policies should be included.

#### Scenario: Auditing User Access
Given access has been granted to users,
When an access review is conducted,
Then all access should be verified and adjusted if necessary based on the user's role.

## External Links
- [AWS IAM Documentation](https://aws.amazon.com/documentation/iam/)
- [ServiceNow Access Request Documentation](https://www.servicenow.com/)
- [Compliance Review Documentation](https://internaldocs.yourcompany.com/compliance/access-reviews)
