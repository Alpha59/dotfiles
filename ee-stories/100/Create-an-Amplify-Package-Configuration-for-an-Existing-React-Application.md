
# Create an Amplify Package Configuration for an Existing React Application
*Only completed once, code should be re-usable for each of the 4 Web Applications*

### **Summary**:

**As a** developer, **I want** to create an Amplify Package Configuration **so that** the React app to work with AWS Amplify for deploying and managing cloud resources.

### **Background:**

We have an existing React application that you want to configure to work with AWS Amplify for deploying and managing cloud resources. This story guides you through the process of setting up an Amplify package configuration for your React app.

### **Description:**

1. **Configure App:**
    1. Amplify CLI generates configuration files in the React app to connect it to the added cloud resources.
        1. As long as “push” is not used, the CLI can be used to generate the YAML file
        2. An Example YAML file should look like this:

```
version: 0.2
frontend:
  phases:
    preBuild:
      commands:
        - npm ci
    build:
      commands:
        - npm run build
  artifacts:
    baseDirectory: build
    files:
      - '**/*'
  cache:
    paths:
      - node_modules/**/*
  S3Storage:
    service: S3
    providerPlugin: awscloudformation
    bucketName: your-unique-s3-bucket-name
    acl: public
```

1. **Test App:**
    1. Test the app to ensure it's functioning correctly with the integrated AWS resources.
        1. Push the stack and update in your Personal AWS account to test

**Acceptance Criteria:**

* The AWS Amplify CLI is installed and configured globally.
* Your React application is initialized with AWS Amplify.
* An Amplify environment is created for your project.
* AWS cloud resources are added and configured using the Amplify CLI.
* Your React app is configured to integrate with the added cloud resources.
* Changes are pushed to the cloud and resources are provisioned.
* Your React app functions correctly with the integrated AWS resources.

This user story guides you through the process of configuring your existing React application to work with AWS Amplify. It involves setting up an Amplify environment, adding and configuring cloud resources, and integrating Amplify into your React app, allowing you to leverage AWS services seamlessly.

The build spec can also be added directly to the CDK.

### **Acceptance Criteria**:

* **Should have**: Amplify CLI globally installed and configured.
* **Should have**: Initialized React application with AWS Amplify.
* **Should have**: Amplify environment created for the project.
* **Should have**: AWS cloud resources added and configured using the Amplify CLI.
* **Should have**: React app configured to integrate with cloud resources.
* **Should have**: Changes pushed to the cloud and resources provisioned.
* **Should have**: **** React app functioning correctly with integrated AWS resources.
