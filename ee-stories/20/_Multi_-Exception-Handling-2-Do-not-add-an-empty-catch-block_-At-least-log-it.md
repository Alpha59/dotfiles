
# [Multi] Exception Handling 2 - Do not add an empty catch block. At least log it
## Summary:
**As a** developer, **I want** all exceptions to be at least logged, **So that** I am able to find a reference to what happened in the logs

## Motivation:
A COE Led to us having a complete re-evaluation of our exception handling. This is the first set of stories to address exception cases in our system. This will lower on-call burden, and avoid issues which cause COEs.

## Acceptance Criteria:
This story is completed when:

Given that we are implementing a method which Catches an exception
Then we should never just swallow the exception in an empty catch block

Then we should log the exception information
Then we should add a metric for the exception

## Details:

This is not ok (despite the comment). This will silently swallow an error condition and then continuing execution. Occasionally this may be the right thing to do, but often it's a sign that a developer saw an exception, didn't know what to do about it, and so used an empty catch to silence the problem. Even if this is “OK”, the user should be notified that the printer already exists.

```
//
try {
    sentinelFacade.addPrinter(printerName, address, model, fcCode);
} catch(SentinelDuplicatePrinterCondition e) {
    // This is ok.  It means we have tried to register the same printer
    // address twice.
}

// Should be
try {
    sentinelFacade.addPrinter(printerName, address, model, fcCode);
} catch(SentinelDuplicatePrinterCondition e) {
    log.info('A printer is already registered at this address');
    metrics.addCount('PrintersPreRegistered', Unit.ONE);
    metrics.addProperty('PreRegisteredPrinterName', printerName);
}
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
