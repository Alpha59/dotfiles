
# Update Inbound to Intake Required Fields and Slim Down Inbound Return Event Database
## Summary

**As a** user of the Inbound service
**I Want** the service to intake only the necessary fields for Carrier Scan lookup
**So that** its responsibilities and database entries are streamlined.


## Additional Context

This story involves updating the Inbound service to intake only the required fields for Carrier Scan lookup, which include RML, RMA, DSN, Return Event ID, and Promise Date. By slimming down the required fields, the service's responsibilities and database entries are simplified and streamlined.


## Acceptance Criteria

* **Should have** updated the Inbound service to intake the following required fields:
    * RML
    * RMA
    * DSN
    * Return Event ID
    * Promise Date
* **Should have** removed any unnecessary fields from the Inbound service's intake.
* **Should have** ensured that the Inbound service functions correctly with the updated field requirements.
* **Should have** updated the documentation to reflect the changes in required fields for Carrier Scan lookup.
