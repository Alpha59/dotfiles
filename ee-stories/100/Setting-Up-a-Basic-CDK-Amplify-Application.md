
# Setting Up a Basic CDK Amplify Application
*Repeated for each of the 4 applications*


### **Summary:**

**As a** developer, **I want** to set up a basic CDK Amplify application that consumes an existing React application using AWS Amplify and AWS CDK **so that** I can streamline the development and deployment of a full-stack application.

### Prerequisites

Before starting the implementation, ensure that the following prerequisites are met:


* AWS account with necessary permissions.
* AWS CDK is installed and properly configured.
* Familiarity with AWS Amplify and AWS CDK.
* Relevant constants are defined in the `Constants` file.


This story aims to set up a basic CDK Amplify application. Further customizations and enhancements can be made as needed for your specific project requirements.

### Description

Our goal is to set up a basic CDK Amplify application that consumes an existing React application. This involves using AWS Amplify to streamline the development and deployment of a full-stack application and leveraging AWS CDK to define the infrastructure as code.

### Background

AWS Amplify provides a set of tools, frameworks, and services designed to accelerate the development, deployment, and testing of cloud web applications and services. AWS CDK allows developers to write infrastructure as code in a developer-friendly language.

### Create the AWS Amplify Application

To create an AWS Amplify website deployment using AWS CDK, we'll use the `@aws-cdk/aws-amplify` package.

```
import { App } from 'aws-cdk-lib';
import {
    StandardPipeline,
    StandardPipelineConfig,
} from '@amzn/device-returns-constructs';
import { Constants } from './constants';
import {  } from './stack';

const app: App = new App();

new StandardPipeline(
    app,
    Constants.PACKAGE_BASE_NAME,
    new StandardPipelineConfig({
        serviceName: Constants.SERVICE_NAME,
        groupPrefix: Constants.PACKAGE_GROUP_PREFIX,
        posixApprovalGroup: Constants.POSIX_GROUP,
        bindleGuid: Constants.BINDLE_ID,
        pipelineId: Constants.PIPELINE_ID,
        account: Constants.PIPELINE_ACCOUNT,
    })
).addStack(Constants.DEPLOYMENT_STAGES, (depEnv) => [
    new
        app,
        `$\{depEnv.disambiguator}-$\{Constants.PACKAGE_BASE_NAME}`,
        {
            env: depEnv,
            packageBaseName: Constants.PACKAGE_BASE_NAME,
            midwayBindle: Constants.BINDLE_ID
        }
    ),
]);
```


This code defines the pipeline for creating the Amplify application, setting up a CDK stack for the deployment stages.

Constants can be imported from the  as:

```
import { DerivedConstants } from '@amzn/device-returns-constructs';
// eslint-disable-next-line @typescript-eslint/no-namespace
export namespace Constants {

    // Full Package Name
    export const PACKAGE_BASE_NAME = '
    export const BINDLE_ID = 'amzn1.bindle.resource.gwbimchocnblyccbj67q';
    export const PIPELINE_ID = '4152725';

    export const {
        SERVICE_NAME,
        DEPLOYMENT_STAGES,
        POSIX_GROUP,
        PACKAGE_GROUP_PREFIX,
        PIPELINE_ACCOUNT
    } = DerivedConstants(Constants);
}
```


Where only the “unique” constants need to be defined in this package. The full list of Constants is available in [

### Step 2: Define the Application Stack

The website stack (` should contain the necessary logic and constructs to create an Amplify Application.

```
import { DeploymentStack, SoftwareType } from '@amzn/pipelines';

export interface  {
    readonly env: DeploymentEnvironment;
    readonly packageBaseName: string;
    readonly midwayBindle: string;
}

export class  extends DeploymentStack {
    constructor(
        app,
        id: string,
        config:
    ) {
        super(app, id, {
            ...config,
            softwareType: SoftwareType.LONG_RUNNING_SERVICE,
        });
        new StaticPortal(this, id, { ...config.env, ...config });
    }
}
```


This code defines the stack for the Amplify application. The `StaticPortal` is where all the required logic for creating an Amplify application should reside.

### Step 3: Finalize the Amplify Application

In the `StaticPortal` construct, we will eventually have configured the following components:


* Amplify App
* AWS Secrets Manager for storing credentials, keys, hashes, etc.
* Lambda functions for API request handlers, business logic, and data access code
* AWS API Gateways for hosting API endpoints
* S3 storage for static web-site content
* ReactJS frontend
*  Cognito for user management, authentication, and authorization

[Image: image.png]
This story only requires a successful deployment of the stack through the pipeline and into the account.


### **Acceptance Criteria:**

* **Given** the provided code for creating the AWS Amplify application,
    * **when** I execute CDK Deploy the code,
    * **then** the Amplify application should be created successfully in my Personal Acccount
* **Given** the code for defining the application stack (
    * **when** I execute the code,
    * **then** the stack should be defined successfully.
* **Given** the Amplify application is fully configured,
    * **when** I deploy the stack through the pipeline and into the **Beta** account,
    * **then** the deployment should be successful.
* **Should have:** defined Relevant constants in the `Constants` file.
* **Should have:** defined Application stack successfully.
* **Should have:** successfully created A AWS Amplify application using AWS CDK.
* **Should have:** Successfully deployment of the stack through the pipeline into the **Beta** account.
