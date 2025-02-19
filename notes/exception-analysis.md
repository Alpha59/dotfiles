# Exception Analysis

As part of a recent [COE](https://www.coe.a2z.com/coe/215615/content) it was discovered that exception handling in the Device Returns realm is not fully handled. A dependency exception was caught, and ignored under the assumption that the returned exception required no action from the Device Returns Team. This assumption led to a customer-to-customer data vulnerability being exposed.  Although this initial error is resolved, and a more thorough process implemented to insure customer data integrity, it led to a system-wide analysis of exception handling, and the following recommendations.

The Device returns team discovered that several assumptions, made regarding dependency exceptions, were not validated. As a result, the error leading to the COE remained unchecked.

## General Recommendations

1. Document ticket or wiki which outlines the cause of Dependent Service Exceptions from outside of Device Returns.
2. Create and log a metric for Dependent Service exceptions which includes the affected Return Event or Unit Identifier
3. Error is an exception which is because of Bad Request and are not meant to be retried by the clients
    1. Errors should have high alarms thresholds
    2. Errors should be caused by the client (HTTP 4XX)
    3. Errors should always be propagated to the user.
    4. Errors are modeled without the explicit `<fault` trait.
4. Fault is an exception that is a known exception or caused because of a dependency, dependency unavailable
    1. Faults should have medium alarm thresholds
    2. Faults should always be caught and surfaced to user when it is unclear how to resolve this issue.
    3. Faults should be caused by dependent systems or unhandled cases in our System (HTTP 5XX)
    4. Faults are modeled with the explicit `<fault` trait.
5. Failure is an exception that is throws from the service itself which was never considered and should not have been occurred, e.g. `NullPointerException`
    1. Failures should have low alarms thresholds
    2. Failures should be translated by the ExceptionTranslator before being passed to the user.
    3. Failures are always defined in Java Code (un-modeled) and appear also as a Fault
    4. Failures should be caused by Unchecked Exceptions (HTTP 500)

## Recommendation

Moving forward, we should address the following issues with our Exception handling. This will be handled in three separate initiatives.

We should first address the small number of universal exception issues which are present in our logic. These are limited to cases where exceptions are being mishandled, or swallowed with no intention.

1. Do not catch an exception just to Re-throw
2. Do not throw a new exception in a catch block, original stack trace may be lost
3. Fix or avoid  `NullPointerException`; do not Catch them
4. Avoid throwing null pointer exceptions
5. Do not use `printStackTrace(); `utilize a `logger.error` instead.
6. Do not throw explicitly throw an unchecked in method/constructor definition
7. Do not add an empty catch block. At least log it.
8. ~~Consider using a try-with-resources statement instead of explicitly closing the resource~~
    1. Where available, use try-with-resource instead of using a finally to close the resource.

Next, we need to address the larger problem regarding the use of numerous exceptions. We should reduce the set of available exceptions down to include only the exceptions listed below. These Exceptions should be declared in a common DeviceReturnsCommonModel library, and should utilize Logging and Message codes (including wiki reference) to better document Exception handling.

* Faults:

    * `DeviceReturnsServiceException`
* Errors:
    * `InvalidInputException`
    * `DeviceReturnsConfigurationError`
    * `DeviceReturnsEventException`
* Failures:
    * `java.lang.IllegalStateException`
    * `ServiceRuntimeException`

Finally, the following exceptions should be re-implemented using the list from above. Each of the above generic exception handling methods should use one of the more explicit exceptions thrown from either our service, or catching the exception from a dependent service. These exception cases need to be evaluated for more than just strict handling.

1. Do not catch generic exceptions
2. Do not throw raw exceptions
3. Do not throw explicitly throw java.lang.Exception in method/constructor definition.

## Improperly Handled Exceptions

Improperly handled exceptions (417 total) are noted with the number of occurrences found in the primary Device Returns Codebase:

### Do not catch generic exceptions

* `NullPointerException`
* `RuntimeException`
* `Exception`

Utilizing generic catch blocks can obscure unexpected errors. Generic Exceptions are used as the parent class for many other exceptions, and should only be used if the exception being thrown is not more specific. It  is best to specify which exceptions you want to catch - rather than just catching all exceptions equally. This allows addressing different exception types differently.

*This is directly related to the COE.*

```
catch (Exception e){
    log.error(
        "Failed to update dashboardService stowed for device: " + input.getDsn(), e);
}
```

```
catch (RuntimeException e) {
    String errorMessage = String.format(
        "Fail in reading catalog data for asin %s, marketplaceId %s",
            asin, marketplaceId);
    throw new DependencyException(errorMessage, e);
}
```

```
} catch (NullPointerException | IllegalArgumentException e) {
    throw new InvalidInputException(e.getMessage(), e);
}
```

### Do not throw raw exceptions

* `RuntimeException`
* `Exception`

Throwing raw exceptions prevents upstream code from handling exceptions properly. Just like catching generics can obscure more serious issues, throwing raw exceptions can obscure when exceptions are thrown which require a more specific handle case. Always use a subclassed Exception to the appropriate type.

```
catch (ConditionalCheckFailedException e) {
    if (returnEventDao.getReturnEvent(returnEventId) == null) {
            throw new RuntimeException(
            "Failed to create return event: " + returnEvent, e);
    }
}
// Should be
throw new UnableToCreateReturnEventException(
    "Failed to create return event: " + returnEvent, e);
```

```
if (rowsUpdated != 1) {
    throw new RuntimeException(
           "Number of rows updated is not 1. Rows: " + rowsUpdated);
}
// Should be
throw new UnableToUpdateReturnEventException(
          "Number of rows updated is not 1. Rows: " + rowsUpdated);
```

```
} catch (ExecutionException e) {
    context.getLogger().log("Error while inserting records");
    closeConnection(context);
    throw new RuntimeException(e);
}
// Should be
throw new UnableToCreateReturnEventException(
    "Failed to create return event: " + returnEvent, e);
```

### Do not throw explicitly throw java.lang.Exception in method/constructor definition


Raw exceptions should never be thrown, and should not be declared as thrown on the function definition. Even if a `RuntimeException` or checked exception is being explicitly thrown - it should be a higher level Exception instance to not force the catching of generic Exceptions.

```
private DBStandardReturnEvent fetchStandardReturnEvent(
    String returnEventId, String dsn) throws Exception
// Should be
private DBStandardReturnEvent fetchStandardReturnEvent(
    String returnEventId, String dsn) throws ReturnEventNotFound
```

```
private String getAddressIdForShipment(DBReturnEvent event)
    throws Exception
// Should be
private String getAddressIdForShipment(DBReturnEvent event)
    throws ShipmentAddressNotFound
```

```
public DeviceMetadata getKindleMetadata(String deviceType) throws Exception
// Should be
public DeviceMetadata getKindleMetadata(String deviceType) throws MetaDataNotFound
```

### Do not throw a new exception in a catch block, original stack trace may be lost

If an exception occurs, the original stack trace should be passed into any exception which is being returned in response.

```
catch (IOException e) {
    throw new JSONException("Cannot read PCE filter spec file");
}
// Should be
throw new JSONException("Cannot read PCE filter spec file, e);
```

```

catch (Exception e) {
    String message = logAddressServiceException(e, customerId, shippingAddressId, "");
    throw new ServiceException(message);
}
// Should be
throw new ServiceException(message, e);
```

```

catch (final PersistenceException e) {
    if (e.getCause() instanceof MySQLIntegrityConstraintViolationException) {
        throw newInvalidDataException(SourceSystem.KDMS, "Duplicate Key Error");
    }
    throw newServiceException(SourceSystem.KDMS, "Exception putting Guidance Map", e);
}
// Should be
if (e.getCause() instanceof MySQLIntegrityConstraintViolationException) {
    throw newInvalidDataException(SourceSystem.KDMS, "Duplicate Key Error", e);
}
```

### Fix or avoid  `NullPointerException`; do not Catch them

`NullPointerExceptions` should not be caught, they should be handled before the catch block. This may mean raising an `IllegalArgumentException`.

```
try {
    Validate.notBlank(returnEvent.getMarketplaceId(), "MarketplaceId can't be blank");
    Validate.notBlank(returnEvent.getAsin(), "Asin cannot be blank");        }
catch (NullPointerException | IllegalArgumentException e) {
log.error(ERROR_VALIDATING_RE, e);
    throw new InvalidInputException(e.getMessage(), e);
}
```

```
try {
    JsonNode body = payload.get("body");
    if ( !body.textValue().isEmpty() && !body.fieldNames().hasNext() ) {
        payload = objectMapper.readTree(body.textValue());
    }
    validatePayload(type, payload.get("body")); // Validate the body only
    ((ObjectNode)payload).put("body", body.toString());
} catch (NullPointerException e) {
    validatePayload(type, payload);
    payload = objectMapper.createObjectNode().put("body", payload.toString());
}
```

```
try {
    return ImmutableMap.<String, String>builder()
           .put(LabelAttributes.POST_INBOUND_GUIDANCE_TYPE,guidance.getGuidanceType())
           .build();
} catch (NullPointerException ex) {
    throw new InvalidInputException(
    String.format("Unable to retrieve Post Inbound Guidance for DSN %s.", dsn), ex);
}
```

### Do not use `printStackTrace(); `utilize a `logger.error` instead.

Just like a sufficiently complex system should not use `System.out` to pass messages to the execution system, it should not utilize `e.printStackTrace()`, which runs the risk of obscuring log output. Printing the stack trace sends logs directly to the `sys.err` output, which may not be compatible with the log monitoring system.

```
try {
    injectRows(rows, record, logger);
} catch (Exception e) {
    logger.log("Unable to parse record: %s", record.toString());
    logger.log(e.toString());
    e.printStackTrace();
    failedRecords.add(record);
}
// Should be
log.error(msg, e);
```

```
try {
    return Files.walk(Paths.get(filePath))
            .filter(Files::isRegularFile)
            .collect(Collectors.toList());
} catch (final IOException e) {
    System.out.println("Error Getting Files");
    e.printStackTrace();
}
// Should be
log.error(msg, e);
```

```
try {
    PutMetricDataResult response = cwClient.putMetricData(request);
    System.out.println(
        String.format("AWS CloudWatch PutMetricData Response: %n%s", response));
}
catch (InternalServiceException e) {
    e.printStackTrace();
}
// Should be
log.error(msg, e);
```

### Do not catch an exception just to Re-throw

This provides no benefit except making the code harder to maintain.

```
try {
    return callable.call();
}
catch (RequestHandlerException ex) {
    throw ex;
}
// Should be
return callable.call();
```

```
try {
    return callable.call();
} catch (PersistenceException ex) {
    if (ex.getCause() instanceof MySQLIntegrityConstraintViolationException) {
        throw new FlagConstraintException(message, ex);
    }
    throw new ServiceException(message, ex);
}
catch (InvalidFlagException | ServiceException ex) {
    throw ex;
}
// Should be
try {
    return callable.call();
} catch (PersistenceException ex) {
    if (ex.getCause() instanceof MySQLIntegrityConstraintViolationException) {
        throw new FlagConstraintException(message, ex);
    }
    throw new ServiceException(message, ex);
}
```

```
try {
    soapMessage.saveChanges();
    SOAPMessage soapResponse = soapMessageDispatcher
        .dispatchMessage(soapMessage, host + "/service");
    return convertSoapResponse(soapResponse);
} catch (ServiceException e) {
    throw e;
}
// Should be
soapMessage.saveChanges();
SOAPMessage soapResponse = soapMessageDispatcher.dispatchMessage(soapMessage, host + "/service");
return convertSoapResponse(soapResponse);
```

### Do not throw explicitly throw an unchecked in method/constructor definition

Unchecked exceptions are indicative of programming errors. If they can be declared in the throws’ clause, then they can be avoided. Unchecked exceptions should not be caught except in an `ExceptionTranslation `Sent to the user.

```
private RestResponse<Record> getRestResponse(RestURI uri) throws RuntimeException
```

```
public static void validateReturnEvent(@NonNull final ReturnDevice returnDevice)
            throws UnsupportedOperationException, InvalidInputException {
```

```
public IdentifierMetadata getIdentifierMetadata(@NonNull final String identifier)
            throws IllegalArgumentException, DISException {
```

### Do not add an empty catch block. At least log it.

This is not ok (despite the comment). This will silently swallow an error condition and then continue execution. Occasionally, this may be the right thing to do, but often it's a sign that a developer saw an exception, didn't know what to do about it, and so used an empty catch to silence the problem. Even if this is “OK”, the user should be notified that the printer already exists.

```
// KindleDeviceMappingService/src/com/amazon/kindledevicemappingservice/activity/PutPrinterAssociationActivity.java:180
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
    log.info("A printer is already registered at this address");
    `metrics``.``addCount``(``"PrintersPreRegistered"``,`` ``Unit``.``ONE``);`` `
`    metrics``.``addProperty``(``"PreRegisteredPrinterName"``,`` ``printerName``);`
}
```

### Avoid throwing null pointer exceptions.

Applications should throw instances of this class to indicate other illegal uses of the `null` object. `NullPointerException` objects may be constructed by the virtual machine. Normally, a higher level abstraction is more appropriate - so that developers know what shouldn’t be null. NPEs are assumed to be created by the VM at runtime.

```
// KindleReturnsAlarms/src/com/amazon/kindle/returns/alarms/monitortemplates/RDSMonitor.java:69
if (highThreshold == null && lowThreshold == null) {
    throw new NullPointerException(
        "Either high threshold or low threshold is required");
}
// Should be
if (highThreshold == null && lowThreshold == null) {
    throw new MissingRequiredDataException(
        "Either high threshold or low threshold is required");
}
```

### Consider using a try-with-resources statement instead of explicitly closing the resource

Using resources is just cleaner, and ensure that the resource is closed without requiring a final statement.

```
// DeviceReturnsOperationPortal/src/com/amazon/kindle/returns/portal/controller/CSVOperationsController.java:175
try {
    values = reader.readValues(fileReader);
    values.forEachRemaining(outputList::add);
}
finally {
    fileReader.close();
}

// Should be
try (BufferedReader br = new BufferedReader(new FileReader(path))) {
    values = reader.readValues(fileReader);
    values.forEachRemaining(outputList::add);
}
```

### Should be handled with Try-with-Resources

* PreparedStatement
* Formatter
* BufferedOutputStream
* DataOutputStream
* GZIPOutputStream
* InputStreamReader
* PrintWriter
* Exceptions currently in System:

Systems marked in Pink are creating the Exception class in java Code, opposed to a Coral Model. Our system should not generate any Failures in code, since these are unexpected.

## Coral Exception List

* `Availability `
* `BackOffException `
* `ThrottlingException `
* `Security `
* `AccessDeniedException `
* `DelegationException `
* `NotAuthorizedException `
* `Service `
* `InternalFailure `
* `MalformedHttpRequestException `
* `RequestAbortedException `
* `RequestEntityTooLargeException `
* `RequestTimeoutException `
* `ServiceUnavailableException `
* `TimeoutException `
* `UnknownOperationException`

### Appendix: Script for finding incorrect exceptions:

```
# Do try-catch as close to the source of exceptions as possible (or let it bubble all the way to the top)
# Do log an error with a full stack trace close to the source of exceptions
# Do construct rethrown exceptions so that the full stack trace is not lost
# Do use either coral exception translations at the top level OR a try-catch as an alternative in special cases (exception translations preferred)
# Do use coral modeled exceptions;
# do NOT let unmodeled exceptions go past the top level (will result in a non-specific InternalException with no information visible to the client about the underlying cause)
# Do NOT use many intermediate try-catch blocks. At most use one at the low level, and one at the top level (or none at all if the coral exception translations can handle it)

notify $1 "Begin Processing $1" "Frog";
echo "                              " | tee ./status;
echo "                              " | tee ./status;
echo "==============================" | tee ./status;
echo "$1" | tee ./status;
echo "==============================" | tee ./status;
if [[ ! -d $1 ]]; then
    echo "CREATING" | tee ./status;
    brazil ws create --name $1;
    cd $1;
    echo "PROCESSING" | tee ./status;
    brazil ws use -p $1;
else
    cd $1;
    echo "PROCESSING" | tee ./status;
fi

if [[ $1 == *"Model"* ]]; then
    echo "PROCESSING MODEL" | tee ./status;
    # Get All available Exception
    grep -oE '<(fault|exception).*' ./src/$1/* -R | sed -e 's/^.*target="\([^"]*\)".*/    \1/g' | sort -u | tee ./exceptions;
    # Get All Available Faults
    grep -oE '<fault.*' ./src/$1/* -R | sed -e 's/^.*target="\([^"]*\)".*/    \1/g' | sort -u | tee ./faults;
    grep -oE 'structure.*Exception' ./src/$1/* -R | grep "smithy" | sed -e 's/.*structure[[:space:]]*\([^[:space:]]*\).*/    \1/g' | sort -u | tee -a ./exceptions;

    # Print Faults and errors out to base file.
    echo "                      " | tee -a ../exception_model;
    echo "                      " | tee -a ../exception_model;
    echo "$1                    " | tee -a ../exception_model;
    echo "----------------------" | tee -a ../exception_model;
    echo "Faults:" | tee -a ../exception_model;
    cat ./faults | tee -a ../exception_model;
    echo "Errors:" | tee -a ../exception_model;
    grep -Fxvf  ./faults ./exceptions | tee -a ../exception_model;

    # cleanup
    rm ./exceptions;
    rm ./faults;
    echo "COMPLETED" | tee ./status;
else
    echo "PROCESSING JAVA" | tee ./status;
    # Get All available Exception from Java Code.
    # Find mishandled exceptions:
    echo "                      " | tee -a ../exception_analysis;
    echo "                      " | tee -a ../exception_analysis;
    echo "$1                    " | tee -a ../exception_analysis;
    echo "----------------------" | tee -a ../exception_analysis;
    echo "Errors In Code:" | tee -a ../exception_model;
    grep -oE 'class.*extends.*Exception' ./src/$1/src/* -R | sed -e 's/^.*class \([[:alpha:]]*\).*/    \1/g' | sort -u | tee -a ../exception_model;

    echo "COMPLETED" | tee ./status;
fi
```


