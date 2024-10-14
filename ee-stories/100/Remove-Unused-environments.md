
# Remove Unused environments
## Summary
[//]:# (This should be descriptive enough to frame the Story, at a high level, as well as include any additional resources needed to complete the Story.)

**AS a**  Developer
**I WANT** the remaining unused environments removed from apollo
**SO** that we can focus our efforts on the outstanding migrations

## Additional Context
[//]:# (This should be descriptive enough to frame the story as well as include any additional resources needed to accomplish the Story.)

This team provides some documentation for removing an environmnet: https://w.amazon.com/bin/view/Community/Moderation/Technology/Berlin/DeprecateApolloService/

### Should Remove
* ETL Pipelines


## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the story. Each line starts with 'should have'.)
[//]:# (Refer to https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats for more information on Acceptance Criteria formats)

This story is completed when:

* All associated Codebases/Clients/Models should be deprecated
* Delete Any Apollo Envs
* Delete Any links back to Deprecated UI/CodeBase
* Delete Any Pipelines
* Back-up the database and store in S3 or glacier. (Using a generic kindle-rl-dev account)
* Delete Any VIPs/Hostclasses
* Delete Any Herd clients (not 100% sure this can be done)
* Delete Any Related AWS accounts
* Delete Any Related related ANT/POSIX groups if they exist. (usually website permissions stuff)
* Update Any Related related wikis to show the service has been deprecated, but do not delete
* Document the steps in our Team Library for deprecating a service (hopefully we have to do it a lot for the NAWS migration)

