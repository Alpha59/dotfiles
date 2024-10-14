
# Set Up Functional Tests in Pipeline
## Summary
[//]:# (This should be descriptive enough to frame the Story, at a high level, as well as include any additional resources needed to complete the Story.)

As a developer, I want to configure functional tests to run automatically in the CI/CD pipeline to ensure that changes don't break the service's functionality.

## Additional Context
[//]:# (This should be descriptive enough to frame the story as well as include any additional resources needed to accomplish the Story.)

This story involves integrating functional tests into the CI/CD pipeline to automatically test the service with each code change.

1. Write functional tests to cover critical service functionality.
2. Configure CI/CD pipeline to run functional tests on code changes.
3. Tests should utilize Hydra to run the tests.
4. Tests should be written in the same language as the Service.

## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the story. Each line starts with 'should have'.)
[//]:# (Refer to https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats for more information on Acceptance Criteria formats)

- Should have Functional tests written to cover key service functionality like pinging the ECS
- Should have Functional tests integrated into the CI/CD pipeline and run automatically on code changes.
