
# [Multi] Exception Handling 2 - Do not throw explicitly throw java.lang.Exception in method/constructor definition (C)
## Summary:
**As a** developer, **I want** the most specific exception declared, **So that** I do not obscure unchecked exceptions by catching them accidentally.

## Motivation:
A COE Led to us having a complete re-evaluation of our exception handling. This is the first set of stories to address exception cases in our system. This will lower on-call burden, and avoid issues which cause COEs.

## Acceptance Criteria:
This story is completed when:

Given that we are implementing a method which throws a checked exception
When the checked exception is declared in the constructor
Then we should utilize a more specific exception than Runtime/Exception

## Details:

Raw exceptions should never be thrown, and should not be declared as thrown on the function definition. Even if a RuntimeException or checked exception is being explicitly thrown - it should be a higher level Exception instance so as to not force the catching of generic Exceptions.

```
private DBStandardReturnEvent fetchStandardReturnEvent(
    String returnEventId, String dsn) throws Exception
// Should be
private DBStandardReturnEvent fetchStandardReturnEvent(
    String returnEventId, String dsn) throws
```
```
private String getAddressIdForShipment(DBReturnEvent event)
    throws Exception
// Should be
private String getAddressIdForShipment(DBReturnEvent event)
    throws InvalidInputException
```
```
public  get deviceType) throws Exception
// Should be
public  get deviceType) throws InvalidInputException
```

# Scope








## Testing
Testing will require updating unit tests, and testing through regression testing through Coral Explorer for each service. Verify that upstream references are not impacted functionally.

## External Links:
Link any external tickets/files which may be helpful in this story:
https://quip-amazon.com/bS3CAjw8HQ61/Exception-Analysis
https://sim.amazon.com/issues/KRL-11072

https://dzone.com/articles/9-best-practices-to-handle-exceptions-in-java
https://howtodoinjava.com/best-practices/java-exception-handling-best-practices/
