
# Onboard to  Federate
*Repeated for each of the 4 applications*

### **Summary:**

**As an** operational user, **I want** to onboard for secure user authentication and authorization through service profiles, **so that** new hires and transfers can be easily added to the application.

**As a** developer, **I want** to onboard to  Federate for the CDK Amplify application **so that** it authenticates and authorizes users securely using  Federate's service profiles.

This story involves creating a new Service Profile, updating the OIDC provider in the User Pool, and securely managing sensitive information like the Client Secret.

### **Background:**

This step involves configuring  Federate, which may require manual configuration or automation using AWS Lambda functions to create Service Profiles and update OIDC providers. Follow  guidelines for this step.

### **Description:**

In this story, we will guide you through the process of onboarding to  Federate. This process involves creating a new Service Profile and updating the OIDC provider in the User Pool.

The official steps can be found on the [ Federate](https://w.amazon.com/bin/view/ Wiki.

### **Steps:**

1. **Open the Federate Enrollment Portal:**
    1. For Testing (Integ): [Federate Enrollment Portal for Testing](https://integ.ep.federate.a2z.com/draft)
    2. For Production (Prod): [Federate Enrollment Portal for Production](https://ep.federate.a2z.com/draft)
2. **Create a new Service Profile:**
    1. Configure the new Service Profile with the following details:
        1. Protocol: OIDC
        2. Service Name: '
        3. Owner group: 'kindle-rl'
        4. CTI: **Digital Media Technology /   /  Reverse Logistics Technology**
        5. Client ID: Use the client ID from the Identity Provider section of the Cognito User Pool.
        6. Redirect URI: Add the user pool domain's OAuth2 response endpoint, which should be generated as a CloudFormation (CNF) Output from the steps above.
            1. (e.g., https://your-user-pool-domain/oauth2/idpresponse).
        7. Check the 'Client Secret' option.
            1. Discovery: MIDWAY
3. **Add allowed/restricted groups for access control:**
    1. Define the groups that are allowed or restricted for access to the website.
    2. Add claims as needed, such as FAMILY_NAME, GIVEN_NAME, EMAIL.
4. **Submit the Service Profile.**
5. **Store the Client Secret in SecretsManager created above**
    1.     // Store your OIDC credentials in the secret
            // This is done via CLI:
            aws secretsmanager put-secret-value                --secret-id                 --secret-string '{\'user\':\'ailor\',\'password\':\'EXAMPLE-PASSWORD\'}'
6. **Update the OIDC provider in the User Pool:**
    1. Locate the Active OIDC Provider section in CDK and edit your provider.
    2. Paste the Client Secret Name you stored in SecretsManager.

### **Acceptance Criteria:**

* **Given** the requirement to define allowed/restricted groups for access control,
    * **when** I define the groups that are allowed or restricted for access to the website,
    * **then** the groups should be correctly defined and configured in the Service Profile.
* **Given** the need to store the Client Secret,
    * **when** I store it in SecretsManager as specified,
    * **then** the Client Secret should be accessible by Cognito Applications
* **Given** that I need to update the OIDC provider in the User Pool,
    * **when** I locate the Active OIDC Provider section in CDK and edit the provider,
    * **then** the OIDC provider should be successfully updated with the Client Secret Name from SecretsManager.



* **Should have:** Access to Federate Enrollment Portal for Testing and Production.
* **Should have:** Service Profile created with Protocol (OIDC), Service Name (' Owner group ('kindle-rl'), CTI, Client ID, Redirect URI, and 'Client Secret' option checked.
* **Should have:** Groups correctly defined for access control, and claims (FAMILY_NAME, GIVEN_NAME, EMAIL) added as needed.
* **Should have:** Client Secret securely stored in SecretsManager.
