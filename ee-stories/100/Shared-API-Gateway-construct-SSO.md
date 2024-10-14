
# Shared API Gateway construct - SSO
## Summary:
**As an** RL Developer **I want** A common construct covering *API Gateway* that is midway authenticated **so that** I can utilize a standard method for implementing API Gateway on all of my callers

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
**Then** They should be able to import a standard API Gateway Stack with (optional) Midway authentication

## Details:

In order to set-up midway, you will need to create an authorizer on the API gateway, so that all endpoints are re-directed to midway when attempting to access the Lambda or ECS service behind the API Gateway. This should be configured in CDK - without the need to specify it as part of the OpenAPI specs for this service.

* midway authentication should be an optional parameter.
* Including midway will require a route53 handler through SuperNova.

https://w.amazon.com/bin/view/MidwayLambdaInterceptor/Onboarding

This story should be completable by a single developer, in a single sprint.

## Testing
Testing will need to happen via `bb build` and deploying the stack to your personal account. Once deployed to your personal AWS account, you will be able to use to console to verify existence of expected items. For some Stacks/Constructs, integrating into an existing service in order to deploy may be easier.

## External Links:
Link any external tickets/files which may be helpful in this story:
