# Change Management Template

## Title

### [Release Type] - [ReleaseName]

<1 line change summary>


## CM Lifecycle

### Original Description

<fill out>


### Outage / Activity Details

<fill out>


## Pipeline

### What is the purpose of this activity or change?

<fill out>


### SIM

<list changes/CRs to be deployed>
Changes List: <link to pipeline track changes>


### What will be required to execute this change?

<fill out>


### What is the expected end state of the system after this change?

<fill out>


### What assumptions, if any, are being made about the state of the system at the time of this change?

N/A


## Impact / Risk Assessment

### Why is it necessary? What is the impact of not making this change?

<fill out>


### Why does this activity or change need to be done under MCM? Can it be safely automated?

<fill out>


### Why is this the correct time/day to complete the CM?

<fill out>


### Are there any related, prerequisite changes upon which this CM hinges?

<fill out>


### Will this CM be in any way intrusive, and if so, how will you know? What teams, services, or functionality will be impacted?

<fill out>


### Is this change modifying a tier-1 service or website? Which one?

N/A


### How has this change been tested to verify it’s safe for production?

<fill out>


## Affected Services

### Does this change involve other dependencies? Are they aware of this CM and on the cc-list or approvals for it?

<fill out>


### Dependencies Dashboard

Provide links to your dependencies dashboard(s)
<fill out>


## Worst Case Scenario

### What could happen if everything goes wrong with this change?

<fill out>


### How does this CM attempt to mitigate this risk?

<fill out>


### Is this change following [Two Person Rule](https://w.amazon.com/bin/view/AWS/2-person_Rule/)? If no, what are the reasons to not follow "Two Person Rule"?

N/A


## Rollback Procedure

### Detailed rollback procedures can be added at the step level - just provide a general overview here.

<fill out>


### What conditions would indicate a need to rollback? Provide graphs with rollback thresholds marked, or other clear indicators to the technicians when a rollback is required.

<fill out>


### In the event of problems, what will you do to return your system to a known good state?

<fill out>


### If this is a software or infrastructure change, has the rollback procedure been verified in a development environment?

<fill out>


## Specific Sections for Each Category

### Website Deployment

How will the deployment be monitored in real-time?
What are the expected traffic changes post-deployment?
Are there any SEO implications? How are they being addressed?


### Website Feature Deployment

How will the feature impact user experience?
What metrics will be used to measure the success of the feature?
How will users be informed of the new feature?


### Website Migration

What are the key milestones in the migration process?
How will data integrity be ensured during migration?
What is the rollback plan if the migration fails?


### Service Deprecation

What services are being deprecated and why?
How will affected users be notified?
What alternatives are being provided to users?


### Website Deprecation

What is the timeline for deprecating the website?
How will users transition to the new platform, if any?
What are the plans for archiving the deprecated website?


### Service Migration

What is the migration strategy for the service?
How will dependencies be managed during migration?
What testing has been done to ensure migration success?


### Service Deployment

How will the new service integrate with existing systems?
What are the performance benchmarks for the new service?
How will the deployment be validated?


### Service Feature Deployment

How will the new feature enhance the service?
What are the key performance indicators for the feature?
How will the feature be rolled back if necessary?


## Additional Questions for All Categories

### What is your foundationalness? Do you expect other services to build on top of you? If so, which ones?

<fill out>


### If your service was temporarily deactivated or shut down, what is your RTO (Recovery Time Objective) for restarting your service?

<fill out>


### How do you recover your data in the event of logical or physical corruption?

<fill out>


### Does the service have on-call rotation setup for operationally supporting the same?

<fill out>


### Do all engineers have their page-* alias configured properly and have received a test page?

<fill out>


### What is the business requested RTO (Recovery Time Objective)?

<fill out>


### Does your application have a Disaster Recovery (DR) plan?

<fill out>


### What is your application's actual RTO and RPO (Recovery Point Objective)?

<fill out>


### List all the upstream and downstream applications with Anvil ID

<fill out>


### What is your recovery strategy for data storage, application, and infrastructure? Please provide technical details of recovery steps or supporting document links.

<fill out>


### Have you tested recovering data from your backups and confirmed that you can meet your RPO and RTO objectives?

<fill out>


### Are Code Reviews Spread Across Developers?

<fill out>

This comprehensive template covers all necessary aspects of change management for various types of releases, ensuring all relevant questions and considerations are addressed.

