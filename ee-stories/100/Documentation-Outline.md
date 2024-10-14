
# Documentation Outline
## Summary
[//]:# (This should be descriptive enough to frame the Story, at a high level, as well as include any additional resources needed to complete the Story.)

As a developer, I want to create comprehensive documentation for the new service to aid in onboarding and maintenance.

## Additional Context
[//]:# (This should be descriptive enough to frame the story as well as include any additional resources needed to accomplish the Story.)

1. Create API documentation for service endpoints.
2. Write developer documentation for code structure and conventions.
3. Document deployment procedures and configurations.

We want to Programmatically build an Open API (Swagger 2.0) document as an endpoint in the service, so that the documentation and source can live together in one place.

https://swagger.io/

Users should be able to run:

```
docker pull swaggerapi/swagger-ui
docker run -p 80:8080 -e SWAGGER_JSON=../<package>CDK/api/openapi.json swaggerapi/swagger-ui
```
To host the documentation and interact with it

Documentation can then be viewed and interacted with at `localhost`. From this UI, users can query the API that is running locally - or point to a different instance and query the remote endpoint.

This is similar to Coral Explorer.

https://swagger.io/docs/open-source-tools/swagger-ui/usage/installation/

The Same OpenAPI documentation should be used for the API Gateway.

## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the story. Each line starts with 'should have'.)
[//]:# (Refer to https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats for more information on Acceptance Criteria formats)

- Should have API documentation in OpenAPI format available for service endpoints.
- Should have Developer documentation cover code structure and best practices.
- Should have Deployment documentation guides stakeholders through the deployment process.
- Should have configured Swagger UI to work with Midway Authentication
    - https://swagger.io/docs/open-source-tools/swagger-ui/usage/oauth2/

https://spec.openapis.org/oas/v3.1.0
https://swagger.io/specification/
