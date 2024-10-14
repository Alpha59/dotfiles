
# Add API Gateway Midway Authentication and Validate Permissions Requirements
*Only completed once, code should be re-usable for each of the 4 Web Applications*

### **Summary**:

**As an** operational user, **I want** midway authentication to ensure security and access control, **so tha**t I have improved application security.

**As a** developer, **I want** to add API Gateway Midway Authentication using Cognito User Pools and validate permission requirements for our existing React application **so that** I havee security and access control for our API Gateway.

### **Background:**

We have an existing React application that interacts with various AWS services through API Gateway. To enhance security and access control, we want to implement Midway Authentication with Cognito User Pools in our API Gateway.

### **Description:**

This story outlines the steps to add API Gateway Midway Authentication using Cognito User Pools and validate permission requirements for our existing React application.

### **Step 1: Define the API Gateway Authorizer**

Create an API Gateway Authorizer for Cognito User Pools to authenticate and authorize users.

```
// Define the API Gateway Authorizer for Cognito User Pools
const cognitoUserPoolAuthorizer = new apigateway.CfnAuthorizer(this, 'CognitoUserPoolAuthorizer', {
  name: 'CognitoUserPool',
  type: apigateway.AuthorizerType.COGNITO_USER_POOLS,
  identitySource: 'method.request.header.Authorization',
  restApiId: api.restApiId,
  providerArns: [cdk.Fn.sub(`arn:aws:cognito-idp:\$\{AWS::Region}:\$\{AWS::AccountId}:userpool/$\{props.userPoolId}`)],
});
```

### **Step 2: Configure API Gateway Permissions**

Make sure that the permissions for API Gateway and Cognito User Pools are correctly set up in the AWS Console to enable communication between the services.

### **Step 3: Testing and Validation**

Test the API Gateway application to ensure that it correctly includes the Midway Authentication headers when making requests

Validate that the API Gateway Authorizer is successfully authenticating and authorizing users based on the Cognito User Pools.

### **Acceptance Criteria**:

**Given** I am calling with API Gateway Midway Authentication,

**When** I call the API Gateway application to ensure it includes Midway Authentication headers when making requests,

**Then** I should verify that the headers are correctly included in the requests.



**Given** I am calling with API Gateway Midway Authentication,

**When** I validate that the API Gateway Authorizer is successfully authenticating and authorizing users based on the Cognito User Pools,

**Then** I should confirm that users are being authenticated and authorized correctly.
