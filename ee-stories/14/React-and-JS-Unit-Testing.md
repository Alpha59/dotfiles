
# React/JS Unit Testing
## Summary:
As a developer I want some mild assurance that my changes have not broken any other areas so that I am able to confidently push out my UI changes, or even open a CR for them.

## Motivation:
As the React Portal moves into being a functioning production site, replacing all existing Portal UI pages, it becomes very important that it function at full capacity all the time. As such, we need to create unit tests around the JS and React components, to ensure that functions are not broken.

## Acceptance Criteria:
This story is completed when:

**Given** that a user has made a change to the React Portal
**When** That user runs `bb`
**Then** Unit tests are run for the React Components/JS functions

**When** Tests fail
**Then** Build needs to fail as well/build is blocked

**When** Test coverage is below 95%
**Then** Code coverage results should fail as well.

## Details:

JS unit tests are simmiliar to Java unit tests, and can use the Mocha framework below. All JS functions found in utils/index.js should have tests created for them.

React Components can be Unit tested using the methodology in the React Unit Testing wiki below. Primary components do not need tests, but all components that are listed under `static/components/*` will need to have tests added.

## Testing
Testing should be through the tests that you are writing....

## External Links:
Link any external tickets/files which may be helpful in this story:
https://w.amazon.com/bin/view/Samus/Tech/LIT/Dev_Resources/React_Unit_Testing/
https://w.amazon.com/bin/view/MYI/Internal/Javascript_Unit_Testing/
