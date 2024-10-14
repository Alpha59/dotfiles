
# Shared MicroService (ECS/Docker) L3 Construct
## Summary:
**As an** RL Developer **I want** A common Stack to create an opinionated MicroService infrastructure **so that** I can utilize a standard construct to define all ECS/Fargate MicroServices in my application.

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
**Then** They should be able to import a standard MicroService L3 Construct

**Given** A microservice is running on the standard stack

**When** The number of users suddenly increases
**Then** The number of instances should scale horizontally.

**When** The number of users decreases
**Then** The number of instances should scale down horizontally.

**When** Attempting to call the stack via PostMan/Curl/Similar
**Then** The stack should be available through any authorized AWS Account

**When** Attempting to call the stack via PostMan/Curl/Similar
**Then** The stack should reject calls from any non-VPN account

**When** API Requests come through the stack
**Then** They should be passed through API Gateway first to handle authorization

**When** Attempting to call the ECS Cluster directly
**Then** No connections should be available not through API Gateway

## Details:

The microservice architecture should be set-up as an ECS/Fargate autoscaling instance behind an Elastic Load Balancer.

The service should not be available directly, only through API Gateway. This means that an API Gateway Stack should be a required input for the construct, or the required inputs to build an API Gateway stack.

The package will need to be transformed into a DockerImage and passed into a custom DRC in order to be created.

ECS/ECR/API-Gateway/etc should all be broken into separate stacks and composed into the  construct

The basic config should be passable as:

```
        new PipelineStack({
            builder: (new MicroService),
            config: new MicroServiceConfig({
                apiGatewayConfig: new StandardApiGatewayConfig({
                    apiDefinitionPackage: `$\{packageBaseName}Model`,
                }),
                packageBaseName: `$\{packageBaseName}` // ECS Package
            })
        })

or

        new PipelineStack({
            builder: (new MicroService),
            config: new MicroServiceConfig({
                apiDefinitionPackage: `$\{packageBaseName}Model`,
                packageBaseName: `$\{packageBaseName}` // ECS Package
            })
        })
```

*All of the 'opinionated' configurations should be over-rideable, but should have default values that do not need to be specified unless passed in. Any values passed in should be validated against best practices. **e.g: Throw an error when specifying too little memory allocation.***

This story should be completable by a single developer, in a single sprint.

## Testing
Testing will need to happen via `bb build` and deploying the stack to your personal account. Once deployed to your personal AWS account, you will be able to use to console to verify existence of expected items. For some Stacks/Constructs, integrating into an existing service in order to deploy may be easier.

## External Links:
Link any external tickets/files which may be helpful in this story:
https://medium.com/swlh/microservices-with-aws-ecs-58dd5006ab2e
https://aws.amazon.com/blogs/containers/building-http-api-based-services-using-aws-fargate/
https://medium.com/adobetech/deploy-microservices-using-aws-ecs-fargate-and-api-gateway-1b5e71129338
