## Summary
**As a** DevOps engineer or backend developer, **I want** to create a vanity URL for the Central API Gateway, **so that** users can access the API via a custom, user-friendly URL instead of the default, system-generated URL. This improves user experience and simplifies the process of accessing and interacting with the API.

A vanity URL is a custom, readable URL (e.g., `https://api.mycompany.com`) that provides a more user-friendly way to access services. In this case, creating a vanity URL for the Central API Gateway will make it easier for developers, clients, and third-party services to interact with the API, improving branding and usability.

### Vision
By creating a vanity URL for the Central API Gateway, we provide a cleaner, branded endpoint for developers and clients. This improves usability, trust, and ease of integration with external systems. The vanity URL will map to the underlying API Gateway but will be easier to use and remember.

### Background
API gateways often generate system-based URLs (e.g., `https://1234.execute-api.aws-region.amazonaws.com/prod`), which are not ideal for public-facing services or for ease of use. A vanity URL allows us to map a custom domain to this gateway, improving readability and creating a seamless brand experience. Setting up a vanity URL involves configuring a custom domain, generating an SSL/TLS certificate, and associating the custom domain with the API Gateway.

### Purpose
The purpose of this story is to create and configure a vanity URL for the Central API Gateway, ensuring that users can access the API via a custom domain name and that the connection is secured with HTTPS/TLS.

## Details

### 1. **Purchase or Set Up a Custom Domain**

   - **Purchase a Custom Domain**:
     - If a custom domain is not already available, purchase one through a domain registrar (e.g., **Route 53**, **GoDaddy**, **Namecheap**). This domain will be used for the vanity URL.

   - **Existing Domain**:
     - If a domain already exists, ensure it can be used for the vanity URL by verifying ownership and DNS management access.

   **Example Domain**:
   - Custom domain: `api.mycompany.com`

### 2. **Generate an SSL/TLS Certificate**

   - **Request a Certificate**:
     - Use **AWS Certificate Manager (ACM)** or another trusted Certificate Authority (CA) to create an SSL/TLS certificate for your custom domain. This ensures that the API can be accessed securely over HTTPS.
     - Example with ACM:
       - Go to AWS Certificate Manager (ACM) in the AWS Console.
       - Request a certificate for the custom domain (e.g., `api.mycompany.com`).
       - Validate domain ownership through DNS or email validation.

   - **WildCard Certificate** (Optional):
     - If you want to use the same certificate for subdomains (e.g., `*.mycompany.com`), you can request a wildcard certificate.
     ```bash
     aws acm request-certificate --domain-name "api.mycompany.com" --validation-method DNS
     ```

### 3. **Create a Custom Domain in API Gateway**

   - **Navigate to API Gateway**:
     - Open **AWS API Gateway** or the API gateway management platform being used.

   - **Set Up a Custom Domain**:
     - Create a new custom domain mapping in the API Gateway console and associate it with your custom domain.
     - Example steps for AWS API Gateway:
       1. Open **API Gateway** in the AWS Console.
       2. Navigate to **Custom Domain Names**.
       3. Choose **Create Custom Domain Name**.
       4. Enter the custom domain name (`api.mycompany.com`).
       5. Select the certificate created in ACM for the custom domain.
       6. Set the **API Gateway Endpoint Type** (Regional, Edge-Optimized, or Private).

   - **Associate API with the Custom Domain**:
     - Once the custom domain is created, associate your Central API Gateway with this custom domain.
     - In the API Gateway console, configure a base path mapping to map the custom domain to the specific API stage (e.g., `prod`).
     ```bash
     aws apigateway create-domain-name --domain-name "api.mycompany.com" \
     --regional-certificate-arn arn:aws:acm:region:account-id:certificate/certificate-id
     ```

### 4. **Update DNS Records**

   - **Create DNS Records**:
     - In your domain's DNS settings (e.g., using **Route 53** or another DNS provider), create a **CNAME** or **A Record** to map the custom domain (`api.mycompany.com`) to the API Gateway endpoint. This ensures that the custom domain resolves to the underlying API Gateway.
     - For AWS **Route 53**, you can create an alias record that points directly to the API Gateway.
     - Example Route 53 configuration:
       1. Open **Route 53** in AWS.
       2. Choose the hosted zone for your domain.
       3. Create a new **A Record** or **CNAME**.
       4. Set the alias target to the API Gateway endpoint.

   - **Verify DNS Propagation**:
     - Once the DNS records are updated, verify that the custom domain resolves correctly. You can use tools like **dig** or **nslookup** to check if the DNS changes have propagated.

   **Example CNAME Record**:
   - Name: `api.mycompany.com`
   - Type: CNAME
   - Value: `d1234567890.execute-api.region.amazonaws.com`

### 5. **Test and Validate the Vanity URL**

   - **Access the API via the Vanity URL**:
     - Test accessing the API via the vanity URL (e.g., `https://api.mycompany.com`) to ensure it is correctly mapped and working.

   - **Validate SSL/TLS**:
     - Ensure that the connection is encrypted and secured via HTTPS. The browser should not show any certificate warnings or errors.
     - Test the SSL certificate using tools like **Qualys SSL Labs** to ensure that the certificate is properly configured and that the site is secure.

   - **Test API Functionality**:
     - Make test requests to the API endpoints via the vanity URL to confirm that the API behaves as expected.

### Testing

- **DNS Propagation Testing**:
   - Verify that the custom domain (`api.mycompany.com`) correctly resolves to the API Gateway endpoint.

- **SSL/TLS Testing**:
   - Ensure that the SSL certificate is correctly configured and that the connection is encrypted using HTTPS.

- **API Testing**:
   - Test all API endpoints via the vanity URL to confirm that they function as expected and that no errors are introduced during the domain mapping.

### External Dependencies
- **Domain registrar** for purchasing and managing the custom domain.
- **Certificate Authority (ACM or third-party CA)** for generating and validating the SSL/TLS certificate.
- **DNS provider** (e.g., AWS Route 53) for managing DNS records and ensuring the domain resolves correctly.

## Acceptance Criteria
- Should successfully create a vanity URL that maps to the Central API Gateway.
- Should ensure that the vanity URL is secured with a valid SSL/TLS certificate.
- Should confirm that the DNS records correctly point the custom domain to the API Gateway.
- Should validate that the vanity URL works for all API endpoints, and the connection is encrypted via HTTPS.

### Gherkin
```gherkin
Given a user accesses the Central API Gateway
When they use the vanity URL
Then the URL should redirect to the correct API endpoint and be accessible over HTTPS.

Given the custom domain is set up
When a DNS lookup is performed
Then the vanity URL should resolve to the Central API Gateway endpoint.
```
