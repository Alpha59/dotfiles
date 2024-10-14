
# Validate OIDC Authentication for Static Website
*Repeated for each of the 4 applications*


### Summary

**As an** operational user, **I want** websites that seamlessly integrate with services, **so that** there is simplified communication with backend services.

### **Description:**

We need to ensure that OIDC (OpenID Connect) authentication is correctly implemented and working as expected for our static portal website. OIDC is crucial for user authentication and access control. This ticket outlines the tasks required to validate the functionality.

### **Tasks:**

1. **Review OIDC Configuration:**
    1. Review the OIDC configuration settings in the web application, including the client ID, client secret, and OIDC provider details.
2. **Environment Setup:**
    1. Ensure that the Beta environment is properly set up with the OIDC provider and the static portal website.
3. **Test OIDC Authentication:**
    1. Access the static portal website.
    2. Attempt to log in using OIDC authentication.
    3. Verify that the OIDC login process works correctly and redirects users to the OIDC provider's login page.
4. **User Authentication:**
    1. Log in using OIDC with a test user account.
    2. Ensure that the authentication process successfully authenticates the user.
5. **Access Control:**
    1. Test the access control mechanism to ensure that users are granted or denied access to specific resources based on their authentication status.
6. **Error Handling:**
    1. Verify that error handling is in place for scenarios where OIDC authentication fails or encounters issues.
7. **Single Sign-On (SSO):**
    1. Test Single Sign-On (SSO) functionality if applicable.
    2. Ensure that SSO works seamlessly after the initial OIDC login.
8. **Session Handling:**
    1. Verify that user sessions are managed correctly and that users are not logged out prematurely.

### **Additional Notes:**

* If any issues are identified during testing, they should be reported and addressed promptly.
* Ensure that the OIDC authentication process adheres to security best practices and complies with any relevant standards.



### **Acceptance Criteria:**

* **Given** the need to validate MIDWAY authentication,
    * **when** reviewing the OIDC configuration settings in the web application, including the client ID, client secret, and OIDC provider details,
    * **then** the OIDC configuration settings should match the configured settings
* **Given** that a user has MIDWAY authentication,
    * **when** accessing the Beta environment
    * **then** the Beta environment should require authentication promps
* **Given** a user has proper MIDWAY authentication,
    * **when** accessing the static portal website,
    * **then** the static portal website should be accessible.
* **Given** a user DOES NOT have proper MIDWAY authentication,
    * **when** accessing the static portal website,
    * **then** the static portal website should NOT be accessible.
* **Given** that a user is attempting to access the page without MIDWAY Authentication,
    * **when** attempting to log in using OIDC authentication,
    * **then** the OIDC login process should work correctly and redirect users to the Midway login page.
* **Given** that a user is attempting to access the page
    * **when** logging in using OIDC with a test user account,
    * **then** the authentication process should successfully authenticate the user.
* **Given** that a user is attempting to access the page
    * **when** testing the access control mechanism,
    * **then** users should be granted based on their authentication status.
* **Given** that a user is attempting to access the page
    * **when** verifying that error handling is in place for scenarios where OIDC authentication fails or encounters issues,
    * **then** user should be redirect to an error page
* **Given** that a user is attempting to access the page
    * **when** testing Single Sign-On (SSO) functionality,
    * **then** SSO should work seamlessly after the initial OIDC login.
* **Given** that a user is attempting to access the page ,
    * **when** Accessing the page after MIDWAY authentication
    * **then** the user should not need to re-authenticate with MIDWAY
