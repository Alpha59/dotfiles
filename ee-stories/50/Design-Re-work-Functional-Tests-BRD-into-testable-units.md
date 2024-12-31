
# Design: Re-work Functional Tests BRD into testable units
## Summary:
As a reverse logistics Business Partner I want assurance that every change going out is regression tested against all of the BRD requirements that have previously been asserted so that I am not concerned about unknown - breaking effects downstream of any new changes.

## Motivation:
This story is working towards several goals:
* Earning more trust from our customers by giving transparent assurance that we are not breaking functionality
* Improving our OE Deployment and Pipeline Goals
* Improving developer life by reducing the number of broken tests.

## Details:
As a previously story, we combined together all BRD line items into a single document. This document was then migrated to a Quip Spreadsheet.

The goal of this story is to map and reduce the acceptance criteria into repeatable items that fit standard testing areas. For instance, a single:

>Given that an SUS  that has not yet been returned to the RC

This would be a good example of a single test set-up that can be extracted out. The minimal set items that can be used to fully describe our system.

For these purposes:

`Given` Should be considered as the set-up for a test (Setting up the device, the parameters, the situation)
`When` Can be considered as the service call (When a device is inbounded: ` then ` is called)
`Then` Can be considered as the verification for a devices state.

This task is only to break the Given/When/Then into better consumable formats - and fix any summaries that are incorrect/wrong. A follow-up story will be created to map the statements to actual actions in the system in code.

## Acceptance Criteria:
Please answer the following questions:

* Does this story require any code changes? N
* Does this design require a design doc? Kinda, only the BRD Doc.
* Does this design include creating new stories? Y

## External Links:
Link any external tickets/files which may be helpful in this story:

[New BRD Doc](https://quip-amazon.com/3YH7AJhAvzkG/Functional-Test-BRD-Spreadsheet)
[Original BRD Doc](https://quip-amazon.com/pWmAApsaFDwe/Functional-Test-BRD) (Comments may hold relevance to this task)

## External Contacts:
The following people can be contacted in regards to greater information on this topic:
Kimberly Daniels
Paul Kim
Jason Rothacker
Jake Ailor
