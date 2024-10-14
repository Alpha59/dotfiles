
# [Multi] Exception Handling 2 - Do not catch generic exceptions (G)
## Summary:
**As a** developer, **I want** the most specific exception caught, **So that** I do not obscure unchecked exceptions by catching them accidentally.

## Motivation:
A COE Led to us having a complete re-evaluation of our exception handling. This is the first set of stories to address exception cases in our system. This will lower on-call burden, and avoid issues which cause COEs.

## Acceptance Criteria:
This story is completed when:

Given that we are calling a method which throws a checked exception
When the checked exception is thrown
Then we should catch the more specific checked exception
And we should handle the more specific checked exception accordingly

Then, we should Log the appropriate exception message through our logger

Then, we should return a checked exception from our system (if appropriate)

## Details:


Utilizing generic catch blocks can obscure unexpected errors. Generic Exceptions are used as the parent class for many other exceptions, and should only be used if the exception being thrown is not more specific. It  is best to specify which exceptions you want to catch - rather than just catching all exceptions equally. This will allow addressing different exception types differently.

* NullPointerException
* RuntimeException
* Exception

>This is directly related to the COE.

```
catch (Exception e){
    log.error(
        'Failed to update dashboardService stowed for device: ' + input.getDsn(), e);
}
```

```
catch (RuntimeException e) {
    String errorMessage = String.format(
        'Fail in reading catalog data for asin %s, marketplaceId %s',
            asin, marketplaceId);
    throw new DependencyException(errorMessage, e);
}
```

```
} catch (NullPointerException | IllegalArgumentException e) {
    throw new InvalidInputException(e.getMessage(), e);
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
