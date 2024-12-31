
# Mini-Design: Functional Test Cases
## Summary:
As a developer I want my functional tests to follow best practices so that they are both useful, and pass on a consistent basis.

As a Business Operations User, I want the KRL Functional Tests to reflect real workflows, so that I am aware of broken workflows before they become an issue.

## Purpose:
Functional tests serve several purposes, but can be boiled down to a few key points. Functional tests can be used to isolate issues between multiple interacting services. Although unit tests can be used to detect bugs in individual classes or services, functional tests serve the purpose of detecting inter-module dependencies. Functional tests primarily serve the purpose of replacing manual testing of the entire system. Manual testing can become increasingly slow, and thus slow down the release cycle, in a larger system. The goal of Functional tests should be to eliminate the manual step of the process - and instead of re-testing existing architecture, fall back to automated testing.

## Details:
The goal of this task is not to write new functional tests, but to define the workflows which should be end-to-end tested using the functional tests. These tests/test cases should be broken into 3 categories:

* Smoke tests
    * Basic tests to ensure that minimal viable functionality is available
* Regression Tests
    * Should test as many possible workflows and variations on device processing as possible
* Test Metrics
    * An example of this is measuring latencies and having a threshold

This story requires working with business, team leadership, and FC leadership to ensure that their requirements are being properly tested, and creating a living document of Test cases in Given/When/Then format. This document should live in the  as a `.md` file.

Tests should be listed out, and numbered - allowing business users to reference test cases by number when requesting changes. Functional Tests are not the same as unit tests. These test cases should be written as if Pedigree is a Black Box, and not define the interactions inside of the system.

Functional tests should be grouped by their business partners, or customer cohorts. This will help to ensure that the representative from that customer group is able to monitor the functional tests designed specifically to cover their use cases, and not need to worry about other business teams.

### Notes
Functional tests should not live in the same framework as Unit Tests, since they should not be focused on “Code-Coverage”, although using them to identify “Code-Coverage” may help to eliminate unnecessary or dead code. At the same time though, users should be able to view the output of functional tests, so that they are aware of the changes - in a business focused report. This report should be generated in a way that allows business users to view all of the new tests, removed tests, and modified tests, as well as see the results of failed tests.

The primary focuses of Functional Tests should still be on the business logic. This means that functional tests should not be added, modified, or removed for OE related work. This should allow tests to be much more robust, since they should only break or change when the business logic associated with the workflow is changed. The functional testing report can also have specific business value in helping to determine which bugs are of highest priority. By viewing which business processes are broken, management can target the most business critical bugs first.

## Acceptance Criteria:
Please answer the following questions:

This story is not to define how to run the tests, or decide about persistence layer implementation.
This story should define workflows and metrics for test cases. Business and Leadership should be involved in approving these workflows.
This story should examine past BRDs, and ensure that all defined (and valid) business cases are being accounted for.

* Does this story require any code changes? No
* Does this design require a design doc? Yes
* Does this design include creating new stories? Yes

## External Links:
Link any external tickets/files which may be helpful in this story:

## External Contacts:
The following people can be contacted in regards to greater information on this topic:
