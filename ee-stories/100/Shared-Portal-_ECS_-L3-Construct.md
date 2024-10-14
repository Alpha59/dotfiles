
# Shared Portal (ECS) L3 Construct
## Summary:
**As an** RL Developer **I want** A common Stack to create an opinionated Internal Portal Website infrastructure **so that** I can utilize a standard construct to define all Internal Portal Websites in my application.

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
**Then** They should be able to import a standard Internal Portal Website L3 Construct

## Details:

* Only accessible via Midway
    * API Gateway can be used with a single passthrough endpoint to enable midway
* Elastic Load Balancer, ECS/Fargate/API-Gatway should be utilized to control scale
* Developer can assume React Docker Application will be base package
* Package will need to be transformed into Docker Image and uploaded to ECR for deployment

The Package name alone should be enough to create the stack.

```
        new PipelineStack({
            builder: (new Portal),
            config: new PortalConfig({
                packageBaseName: `$\{packageBaseName}` // React Portal in ECS
            })
        })
```

*All of the 'opinionated' configurations should be over-rideable, but should have default values that do not need to be specified unless passed in. Any values passed in should be validated against best practices. **e.g: Throw an error when specifying too little memory allocation.***


This story should be completable by a single developer, in a single sprint.

## Testing
Testing will need to happen via `bb build` and deploying the stack to your personal account. Once deployed to your personal AWS account, you will be able to use to console to verify existence of expected items. For some Stacks/Constructs, integrating into an existing service in order to deploy may be easier.

## External Links:
Link any external tickets/files which may be helpful in this story:
