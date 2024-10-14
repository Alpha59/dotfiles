
# Deploy and Test within new domain
*Repeated for each of the 4 applications*


### **Summary:**

**As an** operational user, **I want** the new infrastructure with a custom DNS name deployed and tested **so that** I can validate that the entire setup works correctly.

**As a** developer, **I want** to deploy and test the new infrastructure with a custom DNS name **so that** I can validate that the entire setup works correctly.

### **Description:**

The CDK Amplify package has now been pointed at the new DNS name, and now we need to validate that the entire infrastructure works as expected when deployed.

* **Step 1: Prerequisites**
    * Ensure that you have set up and configured the AWS CDK environment and Amplify for your project.
* **Step 2: Deploy CDK Stack to your Personal Account and validate**
    * Use the AWS CDK to deploy the Amplify package, which includes the necessary infrastructure components like AWS Amplify,  S3,  Cognito, and more.
    * cdk deploy YourAmplifyStack
    * Monitor the deployment process and address any errors or issues that may arise.
* **Step 4: Deploy the React Application to Prod**
* **Step 5: Test End-to-End Functionality**
    * Thoroughly test the deployed application to ensure that all components are working as expected.
    * This includes testing features that rely on the CDK-created infrastructure, such as authentication, storage, and API interactions.
    * Verify that user authentication and authorization work correctly, and users can access the protected resources.
    * Test the integration with  S3, AWS AppSync, or other AWS services included in the infrastructure.
    * Perform end-to-end testing of any serverless functions or Lambda functions if they are part of your application.
* **Step 6: Bug Fixes and Refinement**
    * Address and fix any bugs or issues that are discovered during testing. This may involve making adjustments to your React application code, Amplify configuration, or CDK infrastructure.
    * This may also include creating Backlog tickets or stories to address existing bugs

### **Acceptance Criteria:**

* **Should have:** Successful deployment of the Amplify package with the new DNS configuration.
* **Should have:** Successful testing of all components and features, including authentication, storage, API interactions, and authorization.
* **Should have:** Verification of user authentication and authorization functionality.
* **Should have:** Successful testing of serverless functions and Lambda functions.
* **Should have:** Bugs and issues addressed and resolved in a timely manner.
* **Should have:** Documentation of any fixes or changes made during testing.
* **Should have:** The CDK code and infrastructure configuration should be reusable for other applications.
