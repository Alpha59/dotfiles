
# Create Custom Resource for RDS Schema Management
## Summary
[//]:# (This should be descriptive enough to frame the Story, at a high level, as well as include any additional resources needed to complete the Story.)

**AS a** service customer
**I WANT** the RDS tables to be consistent across deployments
**SO** that there is not a mismatch in schema when calling the service

## Additional Context
[//]:# (This should be descriptive enough to frame the story as well as include any additional resources needed to accomplish the Story.)

Using a pattern like:

```
CREATE TABLE IF NOT EXISTS TABLE_NAME (column_name datatype, column_name datatype);
IF COL_LENGTH('table_name', 'column_name') IS NULL
BEGIN
   ALTER TABLE table_name ADD [column_name] INT
END
IF COLUMNPROPERTY(OBJECT_ID('dbo.Person'), 'ColumnName', 'ColumnId') IS NULL
```

We would like to execute an `AwsCustomResource` during the CDK deployment, which executes against the SQL database. This can be used for implementing and migrating the Schema.

This pattern can also be used for creating/update data elements in multiple environments.

An Example of this RDS Custom Resource can be found here: https://code.amazon.com/packages/

This Custom Resource Construct will:

* Create a SG
* Add a New Role for the Lambda
    * Attach a Policy to the Role
* Create a lambda
* Create an AWS SDK Call to invoke the lambda
* Attach the SDK call to the on-update for the AWS Custom Resource.

And the Node.js code for executing the SQL statement here: https://code.amazon.com/packages/


* This script accesses Secrets Manager to get the RDS Credentials
* Connects to the Database using the Secrets Value
* Executes the SQL statement from a file.

The SQL file needs to be specific to the CDK package that is being modified, but the Custom Resource should be attached at the  RDS level.

Note:
* We have a Custom Resource already evaluating for RDS: https://code.amazon.com/packages/
* This [existing DRC custom Resource](https://code.amazon.com/packages/ is being used to manage Load Balancer endpoints

## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the story. Each line starts with 'should have'.)
[//]:# (Refer to https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats for more information on Acceptance Criteria formats)

- Should have Moved custom Resource into DRC CDK
- Should have configured all RDS deployments to run custom Resource
- Should have validated that the custom Resource Lambda can connect to the RDS at deploy time
- Should have exported the  table Schema and tested running it against Beta without dropping/modifying any existing tables.

