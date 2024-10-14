
# Shared API Gateway construct  - Opinionated L2
## Summary:
**As an** RL Developer **I want** A common construct covering *API Gateway* **so that** I can utilize a standard method for implementing API Gateway on all of my callers.

## Motivation:
As part of the N-AWS migration, we are targeting a series of standard structures:

- Portal/Website
- Lambda (Sync or Async) Micro/Nano-Service
- ECS Micro-Service
- Step Function executor
- ECS Task process runner

Each of these standard types will have additional functionality (Databases, data sources, etc) added to them. These repeatable patterns should be pulled into a standard working library for both   and any other team who wishes to re-use our CDK construct pattern. Constructs should work with the standard pipeline already created, and should take opinionated defaults - which can be overridden by individual configurations where required.

Constructs should be designed to build out appropriate stacks, tying them together.

## Acceptance Criteria:
This story is completed when:

**Given** A developer is creating a new service
**When** They are setting up their pipeline
**Then** They should be able to import a standard API Gateway Stack.

**Given** Any API Gateway enabled Synchronous service

**When** Attempting to call the stack via PostMan/Curl/Similar
**Then** The stack should be available through any authorized AWS Account

**When** Attempting to call the stack via PostMan/Curl/Similar
**Then** The stack should reject calls from any non-VPN account

**When** API Requests come through the stack
**Then** They should be passed through API Gateway first to handle authorization

## Details:

The standard [API Gateway module](https://docs.aws.amazon.com/cdk/api/latest/docs/aws-apigateway-readme.html) should be sufficient. The Stack should take an OpenAPI (Brazil) Package, that points to either an ECS LoadBalancer implementing a router - or a series of Lambda ARNs.

In order to change routes to point specifically to ARNs - the API Gateway Stack will need to have a feedback mechanism that allows path->ARN routes to be passed in.

Notes:

* API Gateway OpenAPI Specs should be stored in the CDK S3 bucket.
* This stack will be used in the creation of `ECS MicroService` and `Sync Lambda NanoService` Services.
    * Integration with those services is not required for this story.
* We should be  able to indicate some APIs for Caching, and others not to cache for pulling of relatively static data
    * Cache should always be invalidated during a deployment via Custom Lambda execution (regardless of API Gateway changes).
* All CORS requests should be rejected. Authorized calls should only come from Portal Website Services or other Services.

A fully functional stack should be initiated by passing only the Brazil Package File Name:

```
new StandardApiGateway(
    new StandardApiGatewayConfig({
        apiDefinitionPackage: `$\{packageBaseName}Model`
    })
);
```

*All of the 'opinionated' configurations should be over-rideable, but should have default values that do not need to be specified unless passed in. Any values passed in should be validated against best practices. **e.g: Throw an error when specifying too little memory allocation.***

This story should be completable by a single developer, in a single sprint.

## Testing
Testing will need to happen via `bb build` and deploying the stack to your personal account. Once deployed to your personal AWS account, you will be able to use to console to verify existence of expected items. For some Stacks/Constructs, integrating into an existing service in order to deploy may be easier.

## External Links:
Link any external tickets/files which may be helpful in this story:

https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-control-access-to-api.html
https://tutorialsdojo.com/how-to-invalidate-api-gateway-cache/
