
# Create a Custom Subdomain
*Repeated for each of the 4 applications*


### **Summary:**

**As an** operational user, **I want** a custom subdomain for our application **so that** I have a dedicated and easily accessible URL, enhancing user experience.

**As a** developer, **I want** to create a custom subdomain for our application, inheriting the base domain from a separate AWS Account so that this subdomain provides a dedicated and easy-to-access URL for our application.

I want to use the CDK to perform this task without relying on the Amplify CLI.

### Background:

The Applications require a custom subdomain while inheriting the base domain from a separate AWS Account. We have already written the necessary code using the CDK to create the delegation record. This subdomain will be used to access our application.

### Description:

The subdomain will inherit the base domain from a separate AWS Account. This operation should be performed using CDK, without relying on the Amplify CLI.


* **Step 1: CDK Stack Setup**
    * Ensure that you have the CDK app and the necessary code ready for deployment. Verify that you have the required permissions to deploy CDK stacks in your AWS environment.
* **Step 2: Create a Custom Subdomain**
    * Use the CDK code snippet provided to create a custom subdomain. The code snippet should be similar to the following:

```
const dns = new Dns(scope, `$\{name}-Dns`, {
    stage: props.stage.name,
    region: props.region,
    shortName: acronize(props.serviceName),
    hostedZoneId: hostedZoneId,
    hostedZoneName: hostedZoneName,
    vpc: this.vpc,
});
```


Ensure that you customize the `shortName`, `hostedZoneId`, and other parameters as required for your project.


* **Step 3: Deployment**
    * Execute the CDK deployment to your Personal AWS Account
    * The deployment process will create the custom subdomain and configure it to inherit the base domain from the separate AWS Account.
        * Access your application using the custom subdomain: `drop.your-alias.reverse-logistics.devices.amazon.dev`). Perform thorough testing to ensure that your application functions correctly under the new DNS configuration.
* **Step 4: Verification**
    * Deploy CDK changes through the pipeline
    * Once the deployment is complete, verify that the custom subdomain has been created successfully. You can do this by checking the DNS records and ensuring that the delegation record is correctly set up.
* **Step 5: Application Configuration**
    * In the Amplify CDK, update the DNS configuration to use the newly created custom subdomain. Ensure that your Amplify app is configured to use this subdomain for hosting.
* **Step 6: Testing**
    * Access your application using the custom subdomain: `drop.beta.reverse-logistics.devices.amazon.dev`). Perform thorough testing to ensure that your application functions correctly under the new DNS configuration.

### **Acceptance Criteria:**

* ***Given*** I have the CDK app and code ready for deployment,
    * ***When*** I execute the CDK code snippet to create the custom subdomain, providing the necessary parameters (shortName, hostedZoneId, etc.),
    * ***Then*** the CDK deployment process should complete successfully without errors, and the custom subdomain should be created and configured to inherit the base domain from the separate AWS Account.
* ***Given*** I have the CDK app and code ready for deployment,
    * ***When*** I deploy CDK changes through the pipeline,
    * ***Then*** the custom subdomain's creation should be part of the deployment, and I should verify that it is successfully created by checking the DNS records and delegation record.
* ***When*** I access the application using the custom subdomain,
    * ***Then*** I should be able to find the Application at that domain



* **Should have:** Thorough testing of the application to verify that all features and functionalities work as expected.
* **Should have:** Validation that the custom subdomain functions as intended and provides access to the application.
* **Should have:** No deployment errors or failures.
* **Should have:** The custom subdomain should be correctly set up and configured.
* **Should have:** Verification that the custom subdomain is correctly set up.
* **Should have:** Confirmation that the delegation record is accurate.
* **Should have:** Amplify app configuration should be updated to use the custom subdomain.
* **Should have:** The application's hosting should now be accessible through the custom subdomain.
