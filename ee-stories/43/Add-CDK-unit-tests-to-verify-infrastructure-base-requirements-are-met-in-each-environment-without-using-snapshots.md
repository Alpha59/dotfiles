
# Add CDK unit tests to verify infrastructure base requirements are met in each environment without using snapshots
### Summary
**As a** DevOps Engineer, **I want** to add CDK unit tests to verify that infrastructure base requirements are met in each environment without using snapshots, **So That** we can ensure that the infrastructure complies with the required configurations, resources, and policies for each environment (development, staging, production) in a maintainable and scalable way.

This story focuses on writing unit tests for AWS CDK (Cloud Development Kit) to verify infrastructure configurations, such as resource definitions (e.g., S3 buckets, Lambda functions), permissions, and environment-specific configurations, without relying on snapshot testing. Snapshot testing can be brittle and difficult to maintain, so we will focus on testing the exact attributes and properties of the resources defined in the CDK stack.

### Vision
By implementing unit tests for AWS CDK infrastructure, we verify that the resources deployed meet the base requirements and configurations, ensuring that each environment is correctly configured and aligned with security and performance best practices.

### Background
AWS CDK allows you to define your infrastructure as code using high-level languages like TypeScript, Python, and JavaScript. Testing your infrastructure code helps ensure that changes to the code do not accidentally remove or misconfigure important resources. Instead of using snapshots, we will test specific properties of the resources, such as instance sizes, security groups, bucket policies, and more.

---

### Steps to Add CDK Unit Tests

#### 1. **Set Up Testing Framework for CDK**

AWS CDK supports testing using the **assertions** library from AWS CDK. You will need to install the testing dependencies if you haven't already.

```bash
# Install dependencies for testing CDK
npm install --save-dev aws-cdk-lib @aws-cdk/assertions jest
```

#### 2. **Configure Jest for CDK Testing**

Ensure that Jest is set up to run the tests for your CDK project. The `jest.config.js` file should be configured to run the CDK tests.

Example `jest.config.js`:

```javascript
module.exports = {
  testEnvironment: 'node',
  testMatch: ['**/__tests__/**/*.test.js'],
};
```

In your `tsconfig.json` file (if using TypeScript), make sure `jest` is included in the type definitions:

```json
{
  'compilerOptions': {
    'types': ['jest', 'node']
  }
}
```

---

#### 3. **Write Unit Tests for Specific Infrastructure Resources**

Here, we'll use the **assertions** library to test specific properties of the resources being created in our CDK stack.

##### Example 1: Test for an S3 Bucket with Encryption

First, create a simple CDK stack that includes an encrypted S3 bucket.

```typescript
import * as cdk from 'aws-cdk-lib';
import { Bucket, BucketEncryption } from 'aws-cdk-lib/aws-s3';
import { Construct } from 'constructs';

export class MyS3Stack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // Define an S3 bucket with encryption
    new Bucket(this, 'MyEncryptedBucket', {
      encryption: BucketEncryption.S3_MANAGED,
    });
  }
}
```

Now, write a test to check that the S3 bucket is encrypted:

```typescript
import * as cdk from 'aws-cdk-lib';
import { Template } from 'aws-cdk-lib/assertions';
import { MyS3Stack } from '../lib/my-s3-stack';

test('S3 Bucket is encrypted', () => {
  const app = new cdk.App();

  // Create the stack
  const stack = new MyS3Stack(app, 'TestStack');

  // Generate the CloudFormation template
  const template = Template.fromStack(stack);

  // Assert that the S3 bucket has server-side encryption enabled
  template.hasResourceProperties('AWS::S3::Bucket', {
    BucketEncryption: {
      ServerSideEncryptionConfiguration: [{
        ServerSideEncryptionByDefault: {
          SSEAlgorithm: 'AES256',
        },
      }],
    },
  });
});
```

##### Example 2: Test for an IAM Role with Specific Permissions

Here is an example where we create an IAM role with permissions, and then verify that those permissions are applied correctly.

```typescript
import * as cdk from 'aws-cdk-lib';
import { Role, ServicePrincipal, ManagedPolicy } from 'aws-cdk-lib/aws-iam';
import { Construct } from 'constructs';

export class MyIAMStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // Define an IAM role
    new Role(this, 'MyLambdaRole', {
      assumedBy: new ServicePrincipal('lambda.amazonaws.com'),
      managedPolicies: [
        ManagedPolicy.fromAwsManagedPolicyName('service-role/AWSLambdaBasicExecutionRole')
      ],
    });
  }
}
```

Test to verify that the IAM role has the correct managed policy attached:

```typescript
import * as cdk from 'aws-cdk-lib';
import { Template } from 'aws-cdk-lib/assertions';
import { MyIAMStack } from '../lib/my-iam-stack';

test('IAM Role has AWSLambdaBasicExecutionRole policy', () => {
  const app = new cdk.App();

  // Create the stack
  const stack = new MyIAMStack(app, 'TestIAMStack');

  // Generate the CloudFormation template
  const template = Template.fromStack(stack);

  // Assert that the IAM role has the AWSLambdaBasicExecutionRole policy attached
  template.hasResourceProperties('AWS::IAM::Role', {
    ManagedPolicyArns: [
      {
        'Fn::Join': [
          '',
          [
            'arn:',
            { Ref: 'AWS::Partition' },
            ':iam::aws:policy/service-role/AWSLambdaBasicExecutionRole'
          ]
        ]
      }
    ]
  });
});
```

##### Example 3: Test for a Lambda Function with Environment Variables

If your Lambda function has specific environment variables, you can write a test to check whether those environment variables are set correctly.

```typescript
import * as cdk from 'aws-cdk-lib';
import { Function, Runtime, Code } from 'aws-cdk-lib/aws-lambda';
import { Construct } from 'constructs';

export class MyLambdaStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // Define a Lambda function with environment variables
    new Function(this, 'MyLambdaFunction', {
      runtime: Runtime.NODEJS_14_X,
      handler: 'index.handler',
      code: Code.fromInline('exports.handler = async () => {};'),
      environment: {
        STAGE: 'dev',
        API_KEY: '12345',
      },
    });
  }
}
```

Test to verify that the environment variables are present in the Lambda function:

```typescript
import * as cdk from 'aws-cdk-lib';
import { Template } from 'aws-cdk-lib/assertions';
import { MyLambdaStack } from '../lib/my-lambda-stack';

test('Lambda function has environment variables set', () => {
  const app = new cdk.App();

  // Create the stack
  const stack = new MyLambdaStack(app, 'TestLambdaStack');

  // Generate the CloudFormation template
  const template = Template.fromStack(stack);

  // Assert that the Lambda function has the correct environment variables
  template.hasResourceProperties('AWS::Lambda::Function', {
    Environment: {
      Variables: {
        STAGE: 'dev',
        API_KEY: '12345',
      },
    },
  });
});
```

---

### 4. **Run the CDK Unit Tests**

To run the unit tests, you can use Jest as your test runner.

```bash
npm run test
```

This will run all the unit tests in your project and verify that the specified resource properties and configurations meet the expected requirements.

---

### 5. **Test Multiple Environments**

If you have multiple environments (e.g., dev, staging, prod), you can write tests to verify that environment-specific configurations are applied correctly.

For example, you can conditionally check that certain resources are only created in production:

```typescript
if (process.env.ENVIRONMENT === 'production') {
  new Bucket(this, 'ProdBucket', {
    encryption: BucketEncryption.KMS_MANAGED,
  });
}
```

Write tests to ensure that the `ProdBucket` is only created in the production environment:

```typescript
test('Production environment creates encrypted S3 bucket', () => {
  process.env.ENVIRONMENT = 'production';

  const app = new cdk.App();
  const stack = new MyS3Stack(app, 'TestStack');
  const template = Template.fromStack(stack);

  template.hasResourceProperties('AWS::S3::Bucket', {
    BucketEncryption: {
      ServerSideEncryptionConfiguration: [{
        ServerSideEncryptionByDefault: {
          SSEAlgorithm: 'aws:kms',
        },
      }],
    },
  });
});
```

---

### Acceptance Criteria
- Should have unit tests that verify key infrastructure requirements, such as encryption, permissions, and environment variables.
- Should avoid using snapshot tests and instead focus on verifying specific properties of resources.
- Should include tests for environment-specific configurations.
- Should have all tests pass when infrastructure is configured correctly.
- Should have integrated tests into the project with Jest for continuous testing.
