
# Set Up Rest API Gateway
## Summary
[//]:# (This should be descriptive enough to frame the Story, at a high level, as well as include any additional resources needed to complete the Story.)

As a developer, I want to configure a REST API Gateway to expose endpoints for the service.

## Additional Context
[//]:# (This should be descriptive enough to frame the story as well as include any additional resources needed to accomplish the Story.)

This story involves setting up an API Gateway with the necessary routes, methods, and integrations with The AWS ECS Fargate Instance

1. Configure API Gateway routes and methods.
2. Integrate API Gateway with Fargate Cluster.
3. Set up request and response mappings.

OpenAPI definition is stored in the CDK Package, and imported by the CDK to the API Gateway. API Gateway must point at a load balancer that fronts the service.

More can be learned about OpenAPI here: https://www.openapis.org/

JSON or Yaml are acceptable for OpenAPI definitions

## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the story. Each line starts with 'should have'.)
[//]:# (Refer to https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats for more information on Acceptance Criteria formats)

- Should have API Gateway configured with endpoints reflecting the service's functionality.
- Should have Endpoints correctly integrated with ECS Service
- Should have configured API Gateway to create

