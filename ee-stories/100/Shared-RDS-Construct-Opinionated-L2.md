
# Shared RDS Construct - Opinionated L2
## Summary:
**As an** RL Developer **I want** A common Stack to create an opinionated RDS Instance **so that** I can utilize a standard construct to define all RDS tables in my application.

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
**Then** They should be able to import a standard RDS Stack

**Given** An RDS instance exists and is available across multiple regions
**When** A schema change is made in a single region
**Then** That same schema change should be reflected in every env/region

**Given** An RDS instance exists and is available across multiple regions
**When** A developer wishes to make a schema change for testing
**Then** They can make that schema change in a personal account using a replicated schema created for this purpose.

## Details:

Some Aurora Best practices can be found here:
* https://docs.aws.amazon.com/
* https://docs.aws.amazon.com/cdk/api/latest/docs/aws-rds-readme.html

This should include:

* AutoScaling w/ settings
* Data API
* Back-up Tables (including Glacier long term snapshots)
* A VPC
* Request Logging

We are currently using FlyWay in some way to replicate schema data. I would like to take this a step further by utilizing FlyWay to:

* Replicate schema across all instances/environments
* Create Read only tables with data replication from a single 'Primary' table
* Load Enum values from a model into table on creation/modification of Enums/Tables

*All of the 'opinionated' configurations should be over-rideable, but should have default values that do not need to be specified unless passed in. Any values passed in should be validated against best practices. **e.g: Throw an error when specifying too little memory allocation.***

A complete stack should be built by passing only the Schema Package information to the stack
```
new RDS(
    new RdsConfig({
        schemaDefinitionPackage: `$\{packageBaseName}Schema`
    })
);
```


This story should be completable by a single developer, in a single sprint.

## Testing
Testing will need to happen via `bb build` and deploying the stack to your personal account. Once deployed to your personal AWS account, you will be able to use to console to verify existence of expected items. For some Stacks/Constructs, integrating into an existing service in order to deploy may be easier.

## External Links:
Link any external tickets/files which may be helpful in this story:
https://blog.codecentric.de/en/2019/11/aws-cdk-part-3-how-to-create-an-rds-instance/
https://pages.awscloud.com/EMEA-Data-Flywheel.html?nc1=f_ls
