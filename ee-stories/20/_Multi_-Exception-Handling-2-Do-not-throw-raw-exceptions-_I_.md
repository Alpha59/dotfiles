
# [Multi] Exception Handling 2 - Do not throw raw exceptions (I)
## Summary:
**As a** developer, **I want** the most specific exception caught, **So that** I do not obscure unchecked exceptions by catching them accidentally.

## Motivation:
A COE Led to us having a complete re-evaluation of our exception handling. This is the first set of stories to address exception cases in our system. This will lower on-call burden, and avoid issues which cause COEs.

## Acceptance Criteria:
This story is completed when:

Given that we are implementing a method which throws a checked exception
When the checked exception is thrown
Then we should utilize a more specific exception than Runtime/Exception

Then, we should Log the appropriate exception message through our logger

Then, we should return a checked exception from our system (if appropriate)

## Details:

Throwing raw exceptions prevents upstream code from handling exceptions properly. Just like catching generics can obscure more serious issues, throwing raw exceptions can obscure when exceptions are thrown which require a more specific handle case. Always use a subclassed Exception of the appropriate type.

* RuntimeException
* Exception

```
catch (ConditionalCheckFailedException e) {
    if (returnEventDao.getReturnEvent(returnEventId) == null) {
            throw new RuntimeException(
            'Failed to create return event: ' + returnEvent, e);
    }
}
// Should be
throw new
    'Failed to create return event: ' + returnEvent, e);
```
```
if (rowsUpdated != 1) {
    throw new RuntimeException(
           'Number of rows updated is not 1. Rows: ' + rowsUpdated);
}
// Should be
throw new
          'Number of rows updated is not 1. Rows: ' + rowsUpdated);
```
```
} catch (ExecutionException e) {
    context.getLogger().log('Error while inserting records');
    closeConnection(context);
    throw new RuntimeException(e);
}
// Should be
throw new
    'Failed to create return event: ' + returnEvent, e);
```

# Scope
CSFATSService/src/com/amazon/csfats/clients/jira/JiraService.java:68
CSFATSService/src/com/amazon/csfats/clients/jira/JiraService.java:71
CSFATSService/src/com/amazon/csfats/sqs/Incoming
CSFATSService/src/com/amazon/csfats/sqs/Incoming
CSFATSService/src/com/amazon/csfats/storage/dao/AuditDao.java:26
CSFATSService/src/com/amazon/csfats/storage/dao/
CSFATSService/src/com/amazon/csfats/storage/dao/
CSFATSService/src/com/amazon/csfats/storage/dao/
CSFATSService/src/com/amazon/csfats/storage/dao/
CSFATSService/src/com/amazon/csfats/storage/dao/
CSFATSService/src/com/amazon/csfats/storage/dao/
CSFATSService/src/com/amazon/csfats/storage/dao/
CSFATSService/src/com/amazon/csfats/storage/dao/
CSFATSService/src/com/amazon/csfats/storage/dao/

## Testing
Testing will require updating unit tests, and testing through regression testing through Coral Explorer for each service. Verify that upstream references are not impacted functionally.

## External Links:
Link any external tickets/files which may be helpful in this story:
https://quip-amazon.com/bS3CAjw8HQ61/Exception-Analysis
https://sim.amazon.com/issues/KRL-11072

https://dzone.com/articles/9-best-practices-to-handle-exceptions-in-java
https://howtodoinjava.com/best-practices/java-exception-handling-best-practices/
