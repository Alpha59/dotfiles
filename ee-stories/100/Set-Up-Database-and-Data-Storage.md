
# Set Up Database and Data Storage
## Summary
[//]:# (This should be descriptive enough to frame the Story, at a high level, as well as include any additional resources needed to complete the Story.)

As a developer, I want to set up the database and configure data storage for the new service.

## Additional Context
[//]:# (This should be descriptive enough to frame the story as well as include any additional resources needed to accomplish the Story.)

This story involves research dynamo and setting up basic structure, creating the necessary tables or collections, and configuring the service to interact with the chosen database.

Example features to utilize during set-up and ensure proper configuration include:

* Serverless
* ACID Transactions
* Active Global Replication Tables
* Access Control and VPC configuration
* Encryption at Rest
* Point-in-Time recovery and S3 data Backup
*  DynamoDB Accelerator (Caching for recently accessed items)
* Change Tracking Triggers
* Monitoring
* Versioning and history:
    * https://dynobase.dev/dynamodb-versioning/
    * https://www.harsharya.me/blog/versioning-in-dynamodb/

## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the story. Each line starts with 'should have'.)
[//]:# (Refer to https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats for more information on Acceptance Criteria formats)

* Should have created the database as configurable and accessible.
* Should have ensured the service reads from and writes to the database.
