
# Create Abstract Endpoints
## Summary:
*As a* Developer working on creating the new DROPS service, *I want* all of my endpoints to behave in the same way, and not duplicate code, *So that* I can easily create new endpoints based on an abstract endpoint.

## Motivation:
This will greatly simplify the process of adding new types - as well as force the Type naming convention to be universal.

## Acceptance Criteria:
This story is completed when:

* Should create new endpoints for Create/Read/Update/Delete
* Endpoints should accept a validation Class/Mixin to be called for the value
* Endpoints should follow REST naming conventions
* Read should allow filtering and Pagination natively
* Create/Update/Delete should all allow bulk actions
* Bulk Download should be enabled for all values
* Bulk Upload should not be enabled by default.

## Details:
Each of these endpoints is designed to allow users to either modify, or view data, either as a single unit, a list of identifiers and modifiers, or as an uploaded/downloaded cvs file. Opening up all of these APIs, will allow any data stored in DROPS to be open for configuration, with no additional work - apart from the UI. This is a critical piece of the Ticket Request process, allowing for rapid deployment of new configuration pages to our business users.

Each of these endpoints should operate as an abstract class, receiving a document, passing that document to a validation class, and then saving the object. For viewing APIs, the validation can be skipped. These should only need to include validation and model mixins in order to provide the full functionality of the endpoint. These stories should include adding Abstract functional test helpers that can be used to modify data in the functional tests.
