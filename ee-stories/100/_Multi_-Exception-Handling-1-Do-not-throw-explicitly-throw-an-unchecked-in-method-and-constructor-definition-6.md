
# [Multi] Exception Handling 1 - Do not throw explicitly throw an unchecked in method/constructor definition: 6
## Summary:
As a developer I want my exceptions to be handled, not swallowed so that I am aware of exceptions and can retrieve a stack trace when one happens.

## Motivation:
A COE Led to us having a complete re-evaluation of our exception handling. This is the first set of stories to address exception cases in our system. This will lower on-call burden, and avoid issues which cause COEs.

## Acceptance Criteria:
This story is completed when:

Given that we are calling a method which throws a checked exception
When we receive a checked exception from that method call
Then, we should handle that checked exception.

Then, we should Log the appropriate exception message through our logger

Then, we should return a checked exception from our system (if appropriate)

## Details:

We should first address the small number of universal exception issues which are present in our logic. These are limited to cases where exceptions are being mishandled, or swallowed with no intention.

Do not throw explicitly throw an unchecked in method/constructor definition

Unchecked exceptions are indicative of programming errors. If they are able to be declare in the throws clause, then they are able to be avoided. Unchecked exceptions should not be caught except in an ExceptionTranslation Sent to the user.








## Testing
Testing will require updating unit tests, and testing through regression testing through Coral Explorer for each service. Verify that upstream references are not impacted functionally.

## External Links:
Link any external tickets/files which may be helpful in this story:
https://quip-amazon.com/bS3CAjw8HQ61/Exception-Analysis
https://sim.amazon.com/issues/KRL-11072

https://dzone.com/articles/9-best-practices-to-handle-exceptions-in-java
https://howtodoinjava.com/best-practices/java-exception-handling-best-practices/
