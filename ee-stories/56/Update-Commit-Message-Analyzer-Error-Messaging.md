
# Update Commit Message Analyzer Error Messaging
## Summary
**AS a** developer
**I WANT** to update the Commit Message Analyzer to include the role access tool
**SO** we can resolve the issue of not being able to assume the CRUXAnalyze role in account 856042963385 to read the repository.

## Additional Context
The current error message indicates that there is an issue with assuming the CRUXAnalyze role in account 856042963385 to read the repository. This issue is impacting the functionality of CMA and needs to be addressed. By updating CMA to include the role access tool, we can diagnose and resolve the access issue, ensuring that the CRUXAnalyze role can be assumed and the repository can be read as required.

Error message should read like:

>'Cannot assume CRUXAnalyze role in account 856042963385 to read ' repository. See https://builderhub.corp.amazon.com/docs/crux/user-guide/create-analyzer-onboarding.html#cannot-assume-cruxanalyze-role-in-account-x-to-read-yourpackage-repository for details and resolution.'

## Acceptance Criteria
- Should have updated CMA to include the role access tool for diagnosing access issues.
- Should have implemented the necessary changes to allow for assuming the CRUXAnalyze role in account 856042963385.
- Should have ensured that the role access tool is properly integrated into the CMA workflow.
- Should have conducted testing to verify that the updated CMA works correctly for diagnosing role access issues.
- Should have addressed any bugs or issues identified during testing.
- Should have documented the changes made to CMA for integrating the role access tool.
