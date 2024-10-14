
# Shared DynamoDB Stack  - Opinionated L2
## Summary:
**As an** RL Developer **I want** A common Stack to create an opinionated DynamoDB Instance **so that** I can utilize a standard construct to define all RDS tables in my application.

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
**Then** They should be able to import a standard DynamoDB Stack

## Details:

Some DynamoDB Best practices can be found here:
* https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/best-practices.html
* https://docs.aws.amazon.com/cdk/api/latest/docs/aws-dynamodb-readme.html

This should include:

* AutoScaling w/ settings
    * It should use On-Demand instances
* Indexes/Partition Keys/Sort Keys
* A VPC
* Logging/Metrics
* Multiple Tables
* [DynamoDB-Lambda Stream](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Streams.Lambda.Tutorial.html)
    * Custom lambda function should be configurable to process data
    * Examples of this might include uploading a label file to sentinel, or registering a sentinel printer.

A complete stack should be built by passing only table names parameters

```
new DynamoDB(
    new DynamoDBConfig({
        tableName: ['Labels', 'BoxLabels']
    })
);
```


*All of the 'opinionated' configurations should be over-rideable, but should have default values that do not need to be specified unless passed in. Any values passed in should be validated against best practices. **e.g: Throw an error when specifying too little memory allocation.***


This story should be completable by a single developer, in a single sprint.

## Testing
Testing will need to happen via `bb build` and deploying the stack to your personal account. Once deployed to your personal AWS account, you will be able to use to console to verify existence of expected items. For some Stacks/Constructs, integrating into an existing service in order to deploy may be easier.

## External Links:
Link any external tickets/files which may be helpful in this story:
https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Streams.Lambda.Tutorial.html
