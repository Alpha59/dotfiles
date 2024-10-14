
# Implement function versioning for AWS lambdas via CDK
### Summary
**As a** DevOps Engineer, **I want** to implement function versioning for AWS Lambda functions using AWS Cloud Development Kit (CDK), **So That** each deployment of a Lambda function is versioned, allowing for rollback to previous versions and better tracking of changes over time.

This story focuses on using AWS CDK to automatically create and manage versions for Lambda functions during each deployment. Versioning Lambda functions allows you to deploy new versions without impacting the current version in production, and easily roll back to a previous version if an issue arises.

### Vision
By implementing function versioning in AWS Lambda via CDK, we ensure that every change to a Lambda function is tracked, and we gain the ability to manage multiple versions. This enables safe deployments, faster rollbacks, and improved overall management of Lambda function lifecycles.

### Background
AWS Lambda function versioning allows you to manage the deployment of your functions by creating immutable versions. Each time you publish a version, Lambda saves a snapshot of the function code and configuration. This ensures that even after deploying a new version, the previous versions can be used or rolled back without disruption. You can also create aliases that point to specific versions to manage production deployments effectively.

## Details

### 1. **Lambda Versioning Concepts**
   - **Version**: A Lambda function version is an immutable snapshot of your function code and configuration. Each version has a unique version number, starting from ``, which represents the unpublished latest version.
   - **Alias**: An alias is a named pointer to a specific Lambda function version, which allows for routing traffic to different versions (e.g., `production`, `staging`).

---

### 2. **Create Lambda Function with Versioning in CDK**

#### 2.1 **Install AWS CDK and Lambda Module**
   - Make sure you have AWS CDK installed:
     ```bash
     npm install -g aws-cdk
     ```
   - Install the necessary CDK module for Lambda:
     ```bash
     npm install @aws-cdk/aws-lambda
     ```

#### 2.2 **Define the Lambda Function in CDK**
   - In your CDK stack, define the Lambda function and enable versioning. Here’s an example:

   Example TypeScript code for defining a Lambda function with versioning:
   ```typescript
   import * as cdk from '@aws-cdk/core';
   import * as lambda from '@aws-cdk/aws-lambda';
   import * as path from 'path';

   export class LambdaVersioningStack extends cdk.Stack {
     constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
       super(scope, id, props);

       // Define the Lambda function
       const myLambda = new lambda.Function(this, 'MyVersionedLambda', {
         runtime: lambda.Runtime.NODEJS_14_X,
         handler: 'index.handler',
         code: lambda.Code.fromAsset(path.join(__dirname, '../lambda')),
       });

       // Automatically create a new version each time the code is updated
       const version = new lambda.Version(this, 'MyLambdaVersion', {
         lambda: myLambda,
       });

       // Optionally, create an alias pointing to the latest version
       const alias = new lambda.Alias(this, 'MyLambdaAlias', {
         aliasName: 'prod',
         version: version,
       });
     }
   }
   ```

   - **Explanation**:
     - The Lambda function is defined using the `lambda.Function` construct.
     - A version of the Lambda function is created using the `lambda.Version` construct.
     - An alias (`prod`) is created to point to the newly created version, allowing traffic to be routed to a specific version of the Lambda function.

#### 2.3 **Deploy the Stack**
   - Synthesize the CloudFormation template and deploy the stack:
     ```bash
     cdk synth
     cdk deploy
     ```

   - Each deployment will now create a new version of the Lambda function, and the alias (`prod`) can be updated to point to the new version.

---

### 3. **Enable Manual or Automatic Versioning**

#### 3.1 **Manual Version Creation**
   - In cases where you need more control, you can manually create new versions only when you’re ready to release. Use the `lambda.Version` construct to create a new version only after testing the changes.

   Example of manual versioning:
   ```typescript
   const myLambda = new lambda.Function(this, 'MyManualVersionedLambda', {
     runtime: lambda.Runtime.PYTHON_3_8,
     handler: 'app.handler',
     code: lambda.Code.fromAsset(path.join(__dirname, '../lambda')),
   });

   // Manually create a version only when needed
   const version = myLambda.currentVersion;
   ```

#### 3.2 **Automatically Incrementing Versions on Deployment**
   - AWS CDK can automatically publish a new version of the Lambda function each time the function's code is updated. The `currentVersion` method allows you to track the latest version.

   Example of automatic version creation:
   ```typescript
   const version = myLambda.currentVersion;
   ```

   With this setup, each time the Lambda code changes, CDK will create a new version and increment the version number.

---

### 4. **Alias Management for Traffic Shifting**

#### 4.1 **Using Aliases for Traffic Management**
   - You can use **Lambda Aliases** to create pointers to different versions of the Lambda function. This is useful for routing traffic between production and canary versions during deployments.

   Example of defining multiple aliases:
   ```typescript
   const aliasProd = new lambda.Alias(this, 'ProdAlias', {
     aliasName: 'prod',
     version: version,
   });

   const aliasStaging = new lambda.Alias(this, 'StagingAlias', {
     aliasName: 'staging',
     version: version,
   });
   ```

#### 4.2 **Traffic Shifting with Aliases**
   - AWS Lambda allows you to shift a percentage of traffic between two versions using aliases. This is useful for blue/green or canary deployments.

   Example of weighted alias configuration (e.g., sending 10% of traffic to a new version):
   ```typescript
   const aliasProd = new lambda.Alias(this, 'ProdAlias', {
     aliasName: 'prod',
     version: version,
     additionalVersions: [{
       version: newVersion,  // The new version you're testing
       weight: 0.1           // 10% of traffic will go to the new version
     }]
   });
   ```

---

### 5. **Rollback Strategy Using Versioning**

#### 5.1 **Rollback to a Previous Version**
   - In case of a failure with the latest Lambda deployment, you can easily roll back by updating the alias to point to the previous version.

   Example:
   ```typescript
   aliasProd.addVersion(previousVersion);
   ```

   You can also manage rollback directly via the AWS Lambda console or through the AWS CLI by updating the alias to point to an earlier version.

---

### 6. **Testing and Validation**

- Deploy the Lambda function multiple times, verifying that each deployment creates a new version.
- Test the alias to ensure it correctly routes traffic to the intended Lambda version.
- Perform a canary release by routing a small percentage of traffic to a new version and validate that it behaves as expected.
- Simulate a rollback by changing the alias back to a previous version and verify the application continues to function correctly.

---

### Supporting Documentation

#### 6.1 **Runbooks**
   - Create a runbook detailing how to deploy new versions, shift traffic, and roll back to previous versions using CDK and the Lambda console.

#### 6.2 **Monitoring and Alerts**
   - Set up monitoring using **AWS CloudWatch** to track the performance of different Lambda versions and trigger alerts if there are any anomalies during version updates or rollbacks.

---

### Acceptance Criteria
- Should have Lambda function versioning enabled in CDK, with each deployment creating a new immutable version.
- Should have aliases configured to point to specific versions (e.g., `prod`, `staging`).
- Should be able to manage traffic shifts using aliases to perform blue/green or canary deployments.
- Should have the ability to roll back to a previous version in the event of a failure.
- Should have tested the full deployment and rollback cycle in a real environment.
- Should have documented the entire versioning and rollback process in supporting runbooks.
