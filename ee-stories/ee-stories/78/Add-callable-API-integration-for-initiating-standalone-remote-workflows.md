## Summary
**As a** cloud architect or DevOps engineer, **I want** to add a **callable API integration** for initiating standalone **remote workflows**, **so that** external services or applications can trigger workflows independently without direct user intervention, allowing for seamless automation and task execution across different systems.

A callable API integration enables remote services or applications to initiate workflows programmatically, providing a flexible, scalable way to automate complex operations or tasks. This integration would allow workflows to be triggered externally, making the system more adaptable and reducing the need for manual intervention.

### Vision
By adding callable API integration for remote workflow initiation, the team will enable external systems to trigger workflows automatically, improving automation, scalability, and integration between services. This allows for better orchestration of tasks across different environments, enhancing the overall efficiency of operations.

### Background
In many distributed systems, workflows need to be triggered from external services or applications without direct human involvement. This could include starting a data processing job, running a report, or performing some other predefined workflow. A callable API simplifies this process by providing a standardized interface for initiating such workflows remotely, improving automation and cross-system collaboration.

### Purpose
The purpose of this story is to develop and expose an API endpoint that external services can call to trigger standalone workflows. This callable API will provide a secure and scalable way to initiate workflows programmatically.

## Details

### 1. **Define the Workflow API Requirements**
   - Determine the workflows that need to be triggered remotely and the necessary inputs for each workflow.
   - Specify the type of HTTP methods to be supported (e.g., POST for initiating workflows).
   - Define the authentication and authorization mechanisms for the API to ensure only trusted services can trigger workflows (e.g., using OAuth 2.0, API keys, or IAM roles).

   **Example API Contract**:
   - **Endpoint**: `/api/v1/workflows/initiate`
   - **Method**: `POST`
   - **Request Body**:
     ```json
     {
       "workflowId": "dataProcessing",
       "parameters": {
         "inputFile": "s3://bucket/input.csv",
         "notificationEmail": "user@example.com"
       }
     }
     ```
   - **Response**:
     ```json
     {
       "status": "success",
       "workflowInstanceId": "1234",
       "message": "Workflow initiated successfully."
     }
     ```

### 2. **Create the API Endpoint**
   - Use a cloud service like **AWS API Gateway**, **AWS Lambda**, or **Express.js** on Node.js to create a REST API endpoint that external services can call.
   - Implement logic to validate the incoming request, initiate the appropriate workflow, and return a response to the caller.

   **AWS API Gateway + Lambda Example**:
   - Create a new API using **AWS API Gateway**.
   - Define the **POST** method and link it to a **Lambda function** that handles workflow initiation.

   **Lambda Handler Example**:
   ```javascript
   const AWS = require('aws-sdk');
   const stepFunctions = new AWS.StepFunctions();

   exports.handler = async (event) => {
       const { workflowId, parameters } = JSON.parse(event.body);

       const params = {
           stateMachineArn: 'arn:aws:states:region:account-id:stateMachine:' + workflowId,
           input: JSON.stringify(parameters)
       };

       try {
           const result = await stepFunctions.startExecution(params).promise();
           return {
               statusCode: 200,
               body: JSON.stringify({
                   status: 'success',
                   workflowInstanceId: result.executionArn,
                   message: 'Workflow initiated successfully.'
               })
           };
       } catch (error) {
           return {
               statusCode: 500,
               body: JSON.stringify({
                   status: 'error',
                   message: error.message
               })
           };
       }
   };
   ```

### 3. **Triggering Workflows**
   - Integrate the callable API with the backend services or orchestrators that run the workflows, such as AWS **Step Functions**, **Lambda functions**, or custom workflow engines.
   - Ensure that the API is capable of passing the necessary parameters to the workflow and initiating it successfully.

   **Example AWS Step Functions Integration**:
   - Define the workflows in **AWS Step Functions** and expose the `startExecution` API to trigger them.
   - The API will receive the workflow ID and parameters, start the corresponding workflow, and return a confirmation to the client.

### 4. **Implement Authentication and Authorization**
   - Secure the API by requiring **API keys**, **OAuth tokens**, or **IAM roles** to prevent unauthorized access.
   - Implement role-based access control (RBAC) to restrict which workflows certain services can initiate.

   **Example API Gateway with IAM Role Authorization**:
   - Attach an IAM policy to the Lambda function that only allows specific users or services to invoke the workflow API.

   **Example IAM Policy for API Gateway**:
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": "execute-api:Invoke",
         "Resource": "arn:aws:execute-api:region:account-id:api-id/*"
       }
     ]
   }
   ```

### 5. **Logging and Monitoring**
   - Set up logging and monitoring to track API usage and workflow executions.
   - Use **AWS CloudWatch Logs** or another logging tool to record details of each API call, including the workflow initiated, input parameters, and any errors.

   **CloudWatch Logs Example**:
   - Enable CloudWatch logging for the API Gateway and Lambda to capture execution details and monitor for errors or unauthorized access attempts.

   **CloudWatch Logs Integration**:
   ```bash
   aws logs create-log-group --log-group-name /aws/lambda/workflow-api-logs
   ```

### 6. **Testing the API Integration**
   - Test the API by calling it with valid and invalid input to ensure that it correctly initiates workflows and returns appropriate error messages when necessary.
   - Use **Postman** or **curl** to simulate API calls and verify that the correct workflows are triggered and run as expected.

   **Example curl Command**:
   ```bash
   curl -X POST https://api.example.com/api/v1/workflows/initiate \
   -H "Content-Type: application/json" \
   -d '{"workflowId": "dataProcessing", "parameters": {"inputFile": "s3://bucket/input.csv"}}'
   ```

### 7. **Implement Rate Limiting and Throttling**
   - Implement rate limiting and throttling to protect the API from abuse or excessive calls. This can be done through **API Gateway** or using middleware in custom-built APIs.

   **Example AWS API Gateway Throttling Configuration**:
   - Configure throttling rules to limit the number of requests per second.
   - Apply rate-limiting policies to ensure that only a certain number of workflows can be triggered within a specific time period.

   **Example Throttling Settings in AWS API Gateway**:
   ```bash
   aws apigateway create-usage-plan \
     --name "WorkflowAPIUsagePlan" \
     --throttle burstLimit=100,rateLimit=50
   ```

### 8. **Documentation**
   - Document the API, including endpoint information, request/response formats, authentication details, and usage limits.
   - Provide a **Swagger/OpenAPI** specification that developers can use to integrate the API into their systems easily.

   **Example Swagger Documentation**:
   ```yaml
   openapi: 3.0.0
   info:
     title: Workflow API
     description: API for initiating remote workflows
     version: 1.0.0
   paths:
     /workflows/initiate:
       post:
         summary: Initiate a workflow
         requestBody:
           content:
             application/json:
               schema:
                 type: object
                 properties:
                   workflowId:
                     type: string
                     example: dataProcessing
                   parameters:
                     type: object
                     example: { "inputFile": "s3://bucket/input.csv" }
         responses:
           200:
             description: Workflow successfully initiated
           500:
             description: Error initiating workflow
   ```

### Testing
- Verify that the API correctly triggers the remote workflow with valid inputs.
- Test the API with invalid inputs to ensure that proper error handling is in place.
- Monitor logs to ensure that the workflow starts and executes as expected.
- Ensure that authentication and authorization mechanisms work as intended.

### Acceptance Criteria
- Should create an API endpoint that allows external services to initiate workflows.
- Should integrate the API with a backend workflow engine (e.g., AWS Step Functions, Lambda).
- Should implement authentication and authorization to secure the API.
- Should log API requests and monitor workflow execution.
- Should provide documentation for the API with examples of usage.

### External Links
- [AWS API Gateway Documentation](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)
- [AWS Step Functions Documentation](https://docs.aws.amazon.com/step-functions/latest/dg/welcome.html)
- [OAuth 2.0 Authentication](https://oauth.net/2/)
