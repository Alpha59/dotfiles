
# Request Interceptor Mocks L3 Construct
## Summary:
**As an** RL Developer **I want** A common Stack to intercept integration test calls **so that** I can mock responses to my integration test calls when they are made.

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
**Then** They should be able to import a standard Integration Test Call Interception Stack

**Given** That integration tests are being run
**When** any service ECS/Lambda calls via HTTP
**Then** Calls are intercepted before being passed to called service.

## Details:
As part of the Functional/integration testing suite, we want to be able to configure which service calls are passed through to additional downstream services, and which ones are intercepted.


For Asynchronous functionality, this means preventing items from being posted to a queue, or topic if the queue/topic can not be used in the functional test (but verifying that the message was in fact posted).

For Synchronous functionality, this means preventing HTTP calls from being executed outside of the account, and either returning an expected value (200/500), or proxying to the actual caller.

The Tests themselves should define what the functionality will be depending on the input passed to the call.

https://github.com/nock/nock at the AWS - so that when the container is created, it can only call the mocking container/library that is configured (which in turn can make real calls when required)

Usage of traffic mirroring may enable this functionality across the account. Additional research would be required to determine the specific mechanisms.

*All of the 'opinionated' configurations should be over-rideable, but should have default values that do not need to be specified unless passed in. Any values passed in should be validated against best practices. **e.g: Throw an error when specifying too little memory allocation.***

This story should be completable by a single developer, in a single sprint.

## Testing
Testing will need to happen via `bb build` and deploying the stack to your personal account. Once deployed to your personal AWS account, you will be able to use to console to verify existence of expected items. For some Stacks/Constructs, integrating into an existing service in order to deploy may be easier.

## External Links:
Link any external tickets/files which may be helpful in this story:
https://docs.aws.amazon.com/vpc/latest/mirroring/traffic-mirroring-filter.html
