
# Create  Documentation for
## Summary
[//]:# (This should be descriptive enough to frame the Story, at a high level, as well as include any additional resources needed to complete the Story.)

**AS a** 3P developer working on integrating with the
**I WANT** to convert the Smithy API Models for  into OpenAPI documents for Documentation,
**SO** that I can easily understand and interact with the  API through a web interface, facilitating testing and integration.

## Additional Context
[//]:# (This should be descriptive enough to frame the story as well as include any additional resources needed to accomplish the Story.)

 API is currently described using Smithy, a framework for defining web services and SDKs. Converting these models into OpenAPI documents will allow for broader compatibility with tools that support OpenAPI specifications, such as Swagger UI. The Swagger Documentation will provide a web interface where developers can see the available endpoints, models, and can directly test API calls against the  service. This documentation should be containerized using Docker to ensure a consistent environment for all users, and should be configured to allow calls to the actual  API Gateway.

OpenAPI Specs can then be turned into a PDF from something like https://mrin9.github.io/RapiPdf/ so that they can be shared with CTDI/Arvatto or anyone else trying to on-board to  Making this scriptable would be ideal, so that we can quickly export documentation for consumption by 3P sites. The same tool can be used for  Internal teams to call us through a centeralized API Gateway.

## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the story. Each line starts with 'should have'.)
[//]:# (Refer to https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats for more information on Acceptance Criteria formats)

- ~~Should have converted the Smithy API Models for  into OpenAPI 3.0 documents.~~
- ~~Should have created Swagger Documentation from the OpenAPI documents.~~
- ~~Should have containerized the Swagger Documentation using Docker, ensuring it can be run in an isolated environment.~~
- Should have configured the Dockerized Swagger UI to allow for API calls to be made directly to the  API Gateway.
- ~~Should have verified that all endpoints described in the Smithy models are accurately represented in the Swagger UI.~~
- Should have tested that API calls can be successfully made from the Swagger UI to the  API Gateway, demonstrating end-to-end functionality.
- ~~Should have provided a README file with instructions on how to run the Docker container and use the Swagger UI to interact with the  API.~~

