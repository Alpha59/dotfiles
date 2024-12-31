## Workshop: **AWS SAM Local Development and Testing Practices**

### Overview
This workshop aims to introduce developers and DevOps engineers to **AWS Serverless Application Model (SAM)** for local development and testing of serverless applications. Participants will learn best practices for developing, testing, and debugging AWS Lambda functions and serverless applications locally using AWS SAM, gaining hands-on experience with tools, workflows, and testing strategies.

### Objectives
By the end of this workshop, participants will:
- Understand AWS SAM and its role in serverless development.
- Be able to set up a local development environment for AWS Lambda using AWS SAM CLI.
- Know how to locally test and debug Lambda functions and APIs.
- Learn best practices for developing serverless applications with AWS SAM.
- Understand the importance of unit testing, integration testing, and performance testing for serverless applications.

---

### Agenda
1. **Introduction to AWS SAM**
   - What is AWS SAM?
   - Key Features: Simplified serverless application deployment, infrastructure as code, support for AWS Lambda, API Gateway, DynamoDB, etc.
   - Why use SAM for local development?
   - SAM vs. CloudFormation

2. **Setting Up AWS SAM Local Development Environment**
   - **Prerequisites**:
     - Install AWS SAM CLI
     - Install Docker (for local Lambda invocation)
     - AWS account setup and AWS CLI
   - Creating a basic AWS SAM project structure
   - Overview of `template.yaml` for defining serverless resources (Lambda, API Gateway, DynamoDB)

   **Hands-on**: Initialize a SAM project using:
   ```bash
   sam init
   ```

3. **Developing and Testing Lambda Functions Locally**
   - Overview of the Lambda function handler and testing locally with **`sam local invoke`**
   - Using **Docker** to simulate the Lambda runtime for local testing
   - Setting up environment variables for local testing
   - Simulating API Gateway requests with **`sam local start-api`**

   **Hands-on**:
   - Test a Lambda function locally with:
     ```bash
     sam local invoke "FunctionName" --event events/event.json
     ```
   - Start a local API for Lambda testing:
     ```bash
     sam local start-api
     ```

4. **Debugging Lambda Functions Locally**
   - Integrating with IDEs (VS Code, IntelliJ) for step-through debugging.
   - Using breakpoints and inspecting variables.

   **Hands-on**: Debug a Lambda function locally using:
   ```bash
   sam local invoke "FunctionName" --event events/event.json --debug
   ```

5. **Unit Testing for AWS Lambda Functions**
   - Writing unit tests using frameworks like **Jest**, **Mocha**, or **Pytest**.
   - Mocking AWS services using libraries like **AWS SDK Mock**.

   **Best Practice**:
   - Ensure that all business logic in Lambda is testable with unit tests.
   - Keep your Lambda functions slim, and test core logic outside of the Lambda handler.

   **Hands-on**: Write unit tests for a Lambda function, mocking DynamoDB or S3 calls.

6. **Integration Testing with SAM**
   - Testing Lambda functions integrated with other AWS services like DynamoDB, S3, and API Gateway.
   - Using **`sam local start-lambda`** to simulate function-to-function calls.
   - End-to-end testing with **`sam local start-api`** to verify API Gateway-Lambda interactions.

   **Hands-on**: Simulate an end-to-end API request and test the function with a DynamoDB backend.

7. **Performance and Load Testing**
   - Load testing your Lambda function locally using **artillery** or **locust**.
   - Setting up performance metrics and alerts to track Lambda performance.

   **Best Practice**: Monitor cold starts, memory usage, and execution time under different loads.

8. **Deploying Serverless Applications with SAM**
   - Deploying your application using `sam deploy`.
   - SAM’s deployment options: guided vs. automated.
   - Rollback strategies and versioning with AWS Lambda.

   **Hands-on**: Deploy a sample Lambda function to AWS using:
   ```bash
   sam deploy --guided
   ```

9. **CI/CD with AWS SAM**
   - Integrating AWS SAM into CI/CD pipelines (Jenkins, GitLab, or GitHub Actions).
   - Using SAM for automated testing, linting, and deployment in the CI pipeline.

   **Best Practice**: Automate unit tests, integration tests, and security scans within the CI/CD pipeline.

---

### Workshop Format
- **Duration**: 3 hours
- **Format**: Lecture, followed by hands-on labs
- **Tools**:
  - SAM CLI, AWS CLI, Docker
  - IDE for Lambda development (e.g., VS Code)
  - Testing frameworks (Jest, Mocha, Pytest)

---

### Pre-Workshop Requirements
1. Install the following on your machine:
   - **AWS SAM CLI**: [Install Guide](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html)
   - **Docker**: [Docker Installation Guide](https://docs.docker.com/get-docker/)
   - **AWS CLI**: [AWS CLI Install Guide](https://aws.amazon.com/cli/)

2. Sign up for an AWS account and configure AWS credentials:
   ```bash
   aws configure
   ```

---

### Takeaways
- **Code Repo**: A repository with all workshop materials and sample projects.
- **Resources**:
  - AWS SAM [Documentation](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html)
  - AWS Lambda [Best Practices](https://docs.aws.amazon.com/lambda/latest/dg/best-practices.html)

Participants will leave the workshop with a strong understanding of local development workflows using AWS SAM, including best practices for testing, debugging, and deploying serverless applications.
