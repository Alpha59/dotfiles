# Design Template - Extended

# Overview

 Provide a brief description of the project, where it fits in context, what problem it solves, etc. Focus on the problem being solved rather than the specifics of the proposed design

### Related/Supporting Docs

Add links to other pages or items that will be helpful to people reading this & provide context

# Terminology

DMS - Device Master Service - a list of terms that might need explanation. e.g. acronyms, service name, process, technology...etc.)

# Business Process

Not required if this is not additive design that is changing an existing business

## Current State

## Proposed State

## Gap Analysis

# Use Cases & Scope

Examples/'stories' of what you're trying to solve, whose going to use or benefit from this

## Requirements

From the above, provide specific requirements the design needs to meet to be successful. Be sure to include functional, performance and scalability. Testing req's are later in the doc.

### Functional

### Non-Functional

The “-abilities”, code adjacent requirements that meet maintainability, security, scalablity, extensibility, etc. requirements

## In Scope

Clarify what is included in the project (often this is a list)

## Not in Scope

Clarify what is NOT included in the project (often this is a list)


# Epics

# Stakeholders

The following are APS stakeholders for the deliverable of the YYY release.

* Master Planner

# Architecture

Not required if this is a component level design or an is an additive change to existing service.

## Overview

## Architecture Diagram


## Description of Architectural Components

|Component Name	|Purpose/Description	|
|---	|---	|
|	|	|
|---	|---	|
|	|	|
|	|	|
|	|	|
|	|	|
|	|	|

## Design Details

### **List Upstream Services**

|Service/Application	|Class of data	|SLA	|
|---	|---	|---	|
|	|	|	|
|---	|---	|---	|
|	|	|	|
|	|	|	|
|	|	|	|
|	|	|	|
|	|	|	|

### **List Downstream Services**

|Service/Application	|Class of data	|SLA	|
|---	|---	|---	|
|	|	|	|
|---	|---	|---	|
|	|	|	|
|	|	|	|
|	|	|	|
|	|	|	|
|	|	|	|

### **Major Design Choices and Technologies Used**

|Technology	|Purpose	|
|---	|---	|
|	|	|
|---	|---	|
|	|	|
|	|	|
|	|	|
|	|	|
|	|	|

### **Types of Data Handled and Security** (https://policy.amazon.com/policy/97)

|Data Classification	|List of Data Elements	|Storage Location	|Storage Protection	|Transport Protection	|
|---	|---	|---	|---	|---	|
|Critical	|	|	|	|	|
|---	|---	|---	|---	|---	|
|Restricted	|	|	|	|	|
|Highly Confidential	|	|	|	|	|
|Confidential	|	|	|	|	|
|Public	|	|	|	|	|

### **Major actors and services interacting with the application**

|Actor/Service	|Action/Permission	|
|---	|---	|
|	|	|
|---	|---	|
|	|	|
|	|	|
|	|	|
|	|	|
|	|	|

## **Security Components**

### **Authentication**

|Entity	|Mechanism	|
|---	|---	|
|	|	|
|---	|---	|
|	|	|
|	|	|
|	|	|
|	|	|
|	|	|

###  **Authorization**

|Entity	|Mechanism	|
|---	|---	|
|	|	|
|---	|---	|
|	|	|
|	|	|
|	|	|
|	|	|
|	|	|

### **Audit/Logging**

* What data is being logged?
* Where are the logs stored?
* How long do you keep the logs?
* How can the logs be accessed?
* What is the highest classification of data present in the logs?
* Are the logs encrypted?
* Who has access to your logs?
* What is your process for ‘scrubbing’ the logs, if critical data is discovered to have been written there?

# Design

## **Context/Interaction Diagram**

*If necessary*

## **Data Model**

*If necessary*

### Logical Model

### Data Dictionary

## **Data Flow Diagrams**

*If necessary*

## **Sequence Diagrams**

*If necessary*

## **Service/Component APIs**

*If necessary*
Add/remove as necessary to fit your design. Be explicit about APIs and components of the design.

## Design Alternatives

Did you consider and reject alternative approaches? If so, describe them here...otherwise people will just keep asking you about them.

## Assumptions, Questions and Dependencies

The more care you take in listing your dependencies the less likely you are to be surprised when they disappoint you.

## Failure Modes

## Testing

Debuggability of Component
Functional Tests
Performance Tests
Stress Tests
Scalability Tests

## Risks

Think through the risks of the proposal. What can break? What could go wrong?

## Operational Impact

How will you act as operators? What hooks/metrics/options do you need to be able to detect and help customers in trouble? What can you do to reduce the likelihood of this?

## Roadmap

If this is a multi-part project that will be released in stages, break them down here

## References

# Appendix

## API Definitions

## Database Table Definitions


