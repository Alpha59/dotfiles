
# EPIC: CDK Constructs
## Summary:
As a DSCOT Developer I want a single, simplified CDK module that allows me to set-up all the required security so that I am able to focus on the portions of my work unique to me, and not boilerplate.

## Motivation:
While working to migrate the RL, it was discovered that there are a number of re-used CDK concepts (primarily around networking and security) that did not need to be repeated, but are used by all developer under DSCOT.

## Acceptance Criteria:
This story is completed when:

**Given** That a M-AWS service is being migrated
**When** The CDK developer imports the built construct
**Then** They are able to quickly deploy an application

**Given** That a new N-AWS service is being implemented/updated
**When** The CDK developer imports the built construct
**Then** They are able to quickly deploy an application

## Details:
https://docs.aws.amazon.com/cdk/latest/guide/constructs.html
https://w.amazon.com/bin/view/Baldr/Learning/CDK/
https://w.amazon.com/bin/view/EC2/Thinkbox/CdkSetup/
https://w.amazon.com/bin/view/Operations_Management_System/Development/Allegiance_Setup/
https://w.amazon.com/bin/view/Users/schaenb/CDK_Lessons_Learned/
https://highcastle.a2z.com/#/blueprints/metadata/c805cf65-0ed2-4213-8d26-a973ccb078ae
https://w.amazon.com/bin/view/WikiPageCDKCustomConstruct/

## Testing
Story will need to be tested by verifying that the Construct works with our existing services

## External Links:
Link any external tickets/files which may be helpful in this story:

## Quip Folder
https://quip-amazon.com/ThRbOksA0ZIi/CDK-Constructs
