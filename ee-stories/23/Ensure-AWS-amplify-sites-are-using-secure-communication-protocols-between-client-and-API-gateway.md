
# Ensure AWS amplify sites are using secure communication protocols between client and API gateway
### Summary
**As a** DevOps Engineer, **I want** to ensure that AWS Amplify sites are using secure communication protocols between the client and API Gateway, **So That** data transmitted between the frontend and backend services is protected, ensuring secure and encrypted communication.

This story focuses on implementing and enforcing secure communication protocols, such as HTTPS, TLS, and the appropriate configuration of CORS (Cross-Origin Resource Sharing) policies, between AWS Amplify-hosted sites and API Gateway to ensure that all communications are encrypted and secure.

### Vision
By ensuring that secure communication protocols are enforced between AWS Amplify and API Gateway, we protect the integrity and confidentiality of data, prevent man-in-the-middle (MITM) attacks, and ensure compliance with security best practices.

### Background
Insecure communication between the frontend and backend can expose sensitive data to interception or unauthorized access. To prevent these security vulnerabilities, it’s essential to configure AWS Amplify sites and API Gateway to communicate over encrypted channels (HTTPS/TLS) and ensure that security headers, CORS policies, and other security mechanisms are in place.

### Purpose
The purpose of this story is to configure secure communication protocols between AWS Amplify sites and API Gateway to ensure that data is encrypted during transmission and that all security best practices are followed.

## Details
### 1. Enforce HTTPS Communication in AWS Amplify
AWS Amplify should always serve the frontend application over HTTPS to ensure encrypted communication between the client and the server.

#### Steps to Enforce HTTPS:
- **Custom Domain with SSL/TLS**: If you're using a custom domain for your Amplify-hosted site, ensure that an SSL/TLS certificate is provisioned via **AWS Certificate Manager (ACM)**.
- **Automatic Redirection**: Amplify automatically provides HTTPS for your site if you're using the default domain or a custom domain configured with ACM. Make sure that automatic redirection from HTTP to HTTPS is enabled.

#### Steps to Enable HTTPS Redirection in AWS Amplify:
1. In the **AWS Amplify Console**, navigate to your app.
2. Under the **Domain Management** section, configure your custom domain.
3. Ensure that an **SSL/TLS Certificate** is set up via ACM for the domain.
4. Enable **Redirect HTTP to HTTPS** to force all traffic over HTTPS.

### 2. Configure API Gateway to Use TLS/HTTPS
Ensure that your API Gateway endpoints are configured to only accept requests over HTTPS. API Gateway provides built-in support for HTTPS/TLS, and this must be enforced for all API Gateway interactions.

#### Steps to Enforce HTTPS on API Gateway:
1. **Custom Domain for API Gateway**: If using a custom domain, ensure you have provisioned an SSL/TLS certificate for your domain via AWS ACM.
2. **Use HTTPS Protocol**: API Gateway automatically uses HTTPS for all API requests when integrated with a custom domain that uses a TLS certificate.
3. **Restrict HTTP Requests**: Ensure that the API does not accept any unencrypted HTTP requests. You can enforce this by setting up a request validator or using an AWS Web Application Firewall (WAF) rule to block non-HTTPS traffic.

#### Example of Enforcing HTTPS with API Gateway:
- In API Gateway, configure a **Custom Domain** with an ACM certificate.
- Set up a **Usage Plan** that enforces HTTPS by allowing only requests to the HTTPS endpoint of the API.

### 3. Configure CORS Policies in API Gateway
Ensure that proper CORS policies are configured in API Gateway to allow cross-origin requests only from trusted origins. This prevents unauthorized domains from accessing your API resources.

#### Steps to Configure CORS in API Gateway:
1. In the **AWS API Gateway Console**, open your API.
2. Navigate to the **Resources** tab and select the method (GET, POST, etc.) for which you want to enable CORS.
3. Select **Enable CORS** from the **Actions** drop-down menu.
4. Set the allowed origins to your Amplify site's domain (e.g., `https://your-amplify-app.com`).
5. Configure allowed methods, headers, and credentials according to your security policy.

#### Example CORS Policy:
```yaml
Access-Control-Allow-Origin: https://your-amplify-app.com
Access-Control-Allow-Methods: GET, POST, PUT, DELETE
Access-Control-Allow-Headers: Content-Type, Authorization
Access-Control-Allow-Credentials: true
```

### 4. Enable TLS 1.2/1.3 for API Gateway
Ensure that API Gateway only accepts traffic using secure TLS versions (1.2 or higher). Older versions of SSL/TLS are considered insecure and should be disabled.

#### Steps to Enforce TLS 1.2 or 1.3:
1. In the **API Gateway Console**, navigate to your API settings.
2. Configure the custom domain to use an **ACM certificate** with TLS 1.2 or 1.3.
3. Ensure that the API only responds to HTTPS requests using the secure TLS protocols.

### 5. Use Cognito or IAM for API Authentication
Ensure that all requests between the AWS Amplify frontend and API Gateway are authenticated using **AWS Cognito** or **IAM roles**. This ensures that only authorized users can access the backend APIs.

#### Steps to Implement AWS Cognito Authentication:
1. Set up an ** Cognito User Pool** to manage user authentication for your Amplify app.
2. In the API Gateway Console, go to the **Authorizers** section.
3. Create a new **Cognito User Pool Authorizer**.
4. Attach the authorizer to your API methods, ensuring that only authenticated users can access the API.

#### Example Cognito Authentication Flow:
- The frontend (Amplify) authenticates the user with Cognito and retrieves an **ID Token**.
- The ID Token is included in the request header as `Authorization` when calling the API Gateway.
- API Gateway validates the token using the Cognito authorizer before allowing access to the backend.

### 6. Implement Content Security Policy (CSP) Headers in Amplify
Configure **Content Security Policy (CSP)** headers for the Amplify site to prevent unauthorized script execution or data injection attacks, especially when making requests to API Gateway.

#### Example CSP Header:
```bash
Content-Security-Policy: default-src 'self'; script-src 'self' https://your-amplify-app.com; connect-src 'self' https://api.your-backend.com;
```
This CSP header ensures that only scripts from the Amplify app and API Gateway can be executed or accessed.

### 7. Monitor Traffic and Security with CloudWatch and WAF
Set up monitoring to ensure that secure communication protocols are being used and no unauthorized access is attempted.

- **CloudWatch Metrics and Logs**: Monitor CloudWatch logs for your API Gateway to detect any HTTP traffic, misconfigurations, or potential vulnerabilities.
- **AWS WAF**: Use AWS WAF to create rules that enforce HTTPS traffic, prevent SQL injection attacks, and throttle requests if needed.

### 8. Test Secure Communication
- **HTTP/HTTPS Test**: Ensure that all traffic between AWS Amplify and API Gateway is conducted over HTTPS by testing the connection in a browser or with cURL.
  - Example cURL command:
    ```bash
    curl -I https://api.your-backend.com/endpoint
    ```
    This should return a response over HTTPS.
- **CORS Test**: Test cross-origin requests to ensure that only requests from trusted domains are allowed.
- **TLS Test**: Use tools like **SSL Labs** to ensure that API Gateway and Amplify are using secure TLS protocols.

### Testing
- **HTTPS Enforcement Test**: Ensure that all traffic is redirected to HTTPS and that no HTTP requests are allowed.
- **CORS Test**: Test that cross-origin requests are only allowed from the Amplify site and not from unauthorized origins.
- **TLS Protocol Test**: Verify that API Gateway only accepts TLS 1.2 or higher connections.
- **Authentication Test**: Ensure that only authenticated users (via Cognito or IAM) can access API Gateway.

### External Dependencies
- **AWS Amplify**: For hosting the frontend application.
- **API Gateway**: For creating and managing the backend API.
- **AWS Certificate Manager (ACM)**: For managing SSL/TLS certificates.
- ** Cognito**: For user authentication.

## Acceptance Criteria
- Should have enforced HTTPS communication between the AWS Amplify site and API Gateway.
- Should have configured API Gateway to only accept HTTPS requests using secure TLS protocols (1.2 or 1.3).
- Should have configured proper CORS policies to allow only trusted origins.
- Should have set up authentication for API Gateway using Cognito or IAM roles.
- Should have tested the secure communication between AWS Amplify and API Gateway using TLS and HTTPS.

### Gherkin
#### Scenario: Enforcing HTTPS Between Amplify and API Gateway
Given the AWS Amplify site is configured,
When the client requests data from API Gateway,
Then the communication should be over HTTPS with TLS 1.2 or higher.

#### Scenario: Validating CORS Policies
Given the AWS Amplify site is configured,
When a request is made to the API Gateway from an unauthorized origin,
Then the system should reject the request due to CORS policy.

#### Scenario: Using Cognito for API Authentication
Given a user is authenticated with AWS Cognito,
When they attempt to call the API Gateway,
Then the request should only be allowed if the user provides a valid authorization token.

## External Links
- [AWS Amplify Documentation](https://docs.aws.amazon.com/amplify/)
- [API Gateway HTTPS Documentation](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-create-https-ssl-tls.html)
- [AWS Certificate Manager Documentation](https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html)
