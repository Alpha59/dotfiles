# Code Review Guidelines

## **Description:**

The Code Review Guidelines mechanism establishes a structured and comprehensive approach to conducting code reviews within the development workflow. It aims to ensure that all code changes are thoroughly examined and meet the required quality standards before being merged into the codebase. The mechanism provides specific actions, criteria, and guidelines to follow during the code review process, enhancing the overall code quality and collaboration among team members.


## **Test Plan/Test Cases Executed:**

To validate the effectiveness of the Code Review Guidelines mechanism, the following test plan and test cases should be executed:


1. **Local Testing:** Run a local bb server and thoroughly test the API/UI with valid inputs to ensure functionality and correctness.
2. **Beta Host Override:** Override the beta host with code changes and test the changes using Coral Explorer to verify compatibility and performance.
3. **AWS Deployment Testing:** Deploy the code changes to a personal/beta stack and conduct testing within the AWS console environment to confirm proper integration and functionality.

## **Test Results:**

Test results should be documented, including any relevant screenshots, response outputs, or other evidence that demonstrates the successful implementation of the Code Review Guidelines. These results should showcase that the code changes have been thoroughly reviewed and tested.


## CR Template:

```
## Description
[//]:# (Describe the goal of this task and how does this change accomplish the goal)


## Test Plan/Test Cases Executed
[//]:# (A passing build and unit tests is not sufficient)



Some recommended actions:
- Run a local bb server and test API/UI with valid inputs
- Override beta host with changes and test with coral explorer
- Deploy changes to personal/beta stack and test in AWS console



## Test Results
[//]:# (Paste screenshots, response outputs or anything else that shows your change works)

**Make sure you read and respond to ALL comments before merging**
```

## **Implementation Guide:**


To implement the Code Review Guidelines mechanism, follow these steps:


### **As an Alias (Fully):**

1. Copy the provided template into your home folder.
2. If using zsh, add the following line to your "~/.zshrc" file:

```
   alias cr='cr —description ~/crTemplate.md'
```

The alias "cr" is now configured to include the provided template automatically in code review descriptions.

### **As an Alias (Renamed):**

1. Copy the provided template into your home folder.
2. If using zsh, add the following line to your "~/.zshrc" file:



```
   alias crd='cr —description ~/crTemplate.md'
```


Use the "crd" alias for the first revision and "cr" for subsequent revisions, providing flexibility while maintaining the template.

The Code Review Guidelines include the following key components:

1. **All Analyzers Must Pass:** Ensures that all code analyzers must pass without violations. Overrides are allowed with proper explanations.
    1. **ACodeReviewADay:** Limits code reviews to a reasonable size (300 lines of new source code). Encourages splitting larger changes into multiple code reviews when necessary.
    2. **Code Complexity and LoC:** Identifies poorly written code and suggests fixes. Requires action based on analyzer feedback.
    3. **Commit Message Analysis:** Ensures that commit messages adhere to established guidelines. Requires adjustments or revisions to align with guidelines.
    4. **Coverlay:** Validates that code reviews include adequate test coverage. Requires additional unit tests if coverage is insufficient, with exceptions for specific cases.
    5. **GK-CRUX-Analyzer:** Enforces high severity violation checks by the Gordion Knot analyzer. Requires updating the configuration file as recommended.
2. **Negative Guidance Must Be Addressed:** Holds authors accountable for addressing negative guidance comments related to dependency versions or providing explanations for not addressing them.
3. **Test Results Must Be Included:** Mandates that code changes are tested, and results are documented. This includes UI changes, API responses, and deployments.

The Code Review Guidelines mechanism aims to establish a structured and efficient code review process, enhancing code quality, collaboration, and adherence to best practices within the development team.


### Negative Guidance must be addressed

After committing a Config change, there may be automated comments that recommend switching a dependency version, which looks like this:
The author of the CR is accountable for fixing the negative guidance or replying to the comment about why it is not being fixed

### Test results must be included in CR description

The change must be tested with results. This can include UI changes, successful responses from apis, deployments.

