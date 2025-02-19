# Fault-Tolerant Design

Fault-tolerant design is a software development approach that prioritizes system resilience by handling unexpected conditions gracefully, not failing outright. Instead of throwing errors when encountering edge cases, a fault-tolerant system applies logical handling strategies to ensure smooth operation. Defaulting to throwing errors leads to unnecessary system failures, degraded user experience, and increased operational overhead. Instead, a well-designed system anticipates potential anomalies and implements intelligent fallbacks or adaptive processing.

For example:

* **Handling Null Values** – If an input value is null, but a reasonable default exists, the system uses the default alternate to throwing an error. This prevents unnecessary failures and allows processing to continue without interruption.
* **Interpreting Unexpected Data Formats** – If a system expects a field in a specific format (integer) but receives the field in a different format (string), the system will attempt to interpret and normalize the field instead of rejecting the incorrect format outright. This increases interoperability and reduces the need for strict input constraints.
* **Resolving Ambiguous Database Lookups** – If a database query returns two results when one is expected, the system can attempt to determine the correct record based on available context rather than failing. This involves applying business rules, prioritizing recent records, or using other heuristics to make an informed decision.

By implementing fault-tolerant design principles, software becomes resilient, user-friendly, and maintainable. Fault-tolerant code minimizes unnecessary disruptions, reduces operational intervention, and enhances overall reliability. In contrast, defaulting to error-throwing can lead to brittle systems that fail unpredictably, require excessive exception handling, and create a poor user experience.

## Error/Fault/Failure

Throwing Exceptions in code is a last resort. Exceptions must be used judiciously and appropriately.

* **Error** is an exception which is because of Bad Request, not intended to be retried by the clients (HTTP 4XX)
    * Errors require high alarms thresholds
    * Errors are caused by the client (HTTP 4XX)
    * Errors are propagated to the user.
    * Errors signal to the User that **THE USER** has originated a mistake.
        * `Cancel is not allowed because device has already been replaced`
        * `No screening details found for Return Event`
            * When a user attempts to Kit a device without screening the device first.
    * Errors are never used for normal control flow.
        * Use conditional statements and return values for expected scenarios.
    * Errors are never thrown in Async Workflows (Herd/SQS).
    * Errors are generic 4XXs, but ought to be specific to the user messaging/cause.
        * Errors need to have a status code usable for language translations.
    * Errors do NOT log the Stack Trace.
* **Fault** is an exception that is a standardized exception, caused because of a dependency, dependency unavailable (HTTP 5XX), or missing business logic.
    * Faults have medium alarm thresholds
    * Faults must be surfaced to the ONLY user when fault-tolerant design is unclear how to resolve an issue.
    * Faults can be caused by dependent systems or unhandled cases in the system (HTTP 5XX)
        * `KDMS error: Defect code(s) not mapped for device`
            * Ticket can be reported to NPI team directly.
        * `Device does not have the WHD outbound channel.`
            * Ticket can be reported to NPI team directly.
        * `WaitingToShipSameUnit is not Shipped`
            * Not a Problem, make Fault Tolerant.
        * `Expecting 1 standard return event with id ... found 2`
            * Not a Problem, make Fault Tolerant.
    * Faults are handled gracefully or provide a fallback.
    * Reserve Faults for cases where Business intervention is required
* **Failure** is an exception that is thrown from the service itself which is never considered and must not occur
    * Failures have low alarms thresholds
    * Failures are translated before being passed to the user.
    * Failures are caused by Unchecked Exceptions (HTTP 500)
        * `Data is missing from the Herd Document!`
            * This is a Programmer error, and must be fixed by a programmer.
        * `NullPointerException`
            * This is a Programmer error, and must be fixed by a programmer.
    * Language Errors / 500 Errors never have details raised to the user.
        * A user **NEVER** receives a Null pointer or Stack Trace.
        * Even if "user" is an API caller.
        * User receives the relevant details
            * `Cancel is not allowed because device has already been replaced`
    * 500 Errors use generic codes.
    * Reserve Failures for genuinely exceptional cases.
    * Failures require code fixes to resolve into Faults/Errors.

## Other scenarios:

* `UserId cannot be blank`
    * User Error if UserId is a field that the user needs to fill in (UI should prevent submit)
    * Fault when the User is not the one filling in the UserId.
    * Never a Failure.
* `No screening details found for Return Event`
    * User Error if the user is trying to KIT a device that has not been screened
    * Otherwise, should not throw, should try to self-heal by creating default screening details.
* `Cancel is not allowed because device has already been replaced`
    * Error if the User is trying to Cancel a Device that has already been replaced.
    * Otherwise, it should not throw an error - it should skip the cancel step.
* `Unable to find a Priority Return Event <return-event-id>`
    * User Error if the user is attempting a Priority only action
    * Otherwise, look for a Standard Return Event.
        * If no Standard Return Event is found, this is a Fault or Fault-Tolerant, depending on the situation.

## Exception Translation

A common misconception is that an Error remains an Error through the call stack. A method, “Update Screening Date” requiring a `screeningDate` is an example. `screeningDate` is a required field, and as such, if `screeningDate` is missing, the user or callers mistake is to not provide a screening date.

```
def updateScreeningDate(screeningDate):
   if not screeningDate:
      throw MissingScreeningDateError
   saveScreeningDate(screeningDate)
```

For the calling service:

```
def updateScreeningDateInServiceA():
    try:
        returnOrder = getReturnOrderFromDatabase()
        screeningDate = returnOrder.getScreeningDate()
        serviceA.callUpdateScreeningDate(screeningDate) // Throws an Error
    except Error e:
        log.error(e) // This is the observability aspect
        throw MissingDataFailure // This is now a Failure.
```

This becomes a Failure. The Error acted as unexpected, and unaccounted for. The calling service either sets the screening date (self-healing):

```
def updateScreeningDateInServiceA():
    returnOrder = getReturnOrderFromDatabase()
    screeningDate = returnOrder.getScreeningDate()
    if not screeningDate:
        screeningDate = Date.now()
    serviceA.callUpdateScreeningDate(screeningDate) // No longer throws that Error
```

Or treat this as an error to its respective caller (if one exists):

```
def updateScreeningDateInServiceA(screeningDate):
    try:
        serviceA.callUpdateScreeningDate(screeningDate)
    except MissingScreeningDateError e:
        log.error(e) // This is the observability aspect
        throw e
```

If treated as a Failure, the developer has 2 paths forward. Introduce a self-healing Fault (Prevent the fault by setting the date), or determine the source of the missing data — and resolve the problem at the source. Self-healing is a possibility if the business rule for this scenario is known.

If treated as an Error to be propagated up the chain, then the next caller in the stack has the same decision to make.

To create a fault, an extra layer is required:

```
def updateScreeningDateInServiceA(domain):
    try:
        returnOrder = getReturnOrderFromDatabase()
        screeningDate = returnOrder.getScreeningDate()
        configuredDays = getSomeConfiguration(domain) // This throws a NullPointer/undefined/whatever Failure
        if not screeningDate:
            screeningDate = Date.now() - configuredDays
        serviceA.callUpdateScreeningDate(screeningDate) // No longer throws that Error
    except Failure:
        throw MissingConfigurationFault
```

In this case, the User does not have control over the missing configuration — but a confirmed possibility exists that the configuration is missing. This creates a fault that will not self-heal. This fault is raised to the User, but not their responsibility to resolve.

However, if the possibility of the configuration missing is excluded (all domain/configuration mappings exist) then this becomes a user Error for incorrectly supplying the domain.

```
def updateScreeningDateInServiceA(domain):
    try:
        returnOrder = getReturnOrderFromDatabase()
        screeningDate = returnOrder.getScreeningDate()
        configuredDays = getSomeConfiguration(domain) // This throws a NullPointer/undefined/whatever Failure
        if not screeningDate:
            screeningDate = Date.now() - configuredDays
        serviceA.callUpdateScreeningDate(screeningDate) // No longer throws that Error
    except Failure:
        throw IncorrectDomainError // User is expected to fix
```

## Downsides and Alternatives to Fault-Tolerant Design

While fault-tolerant design improves system resilience, Fault Tolerance is not always the best approach. In some cases, allowing errors to surface explicitly is preferable for maintaining correctness, ensuring data integrity, and preventing silent failures. Below are downsides of fault-tolerant design, along with alternative approaches and their use cases.

### Silent Data Corruption & Loss of Integrity

By automatically resolving issues, fault-tolerant systems risk making incorrect assumptions regarding how to handle unexpected situations. This potentially leads to data corruption, loss of accuracy, or incorrect business decisions.

Alternative: **Fail-Fast Design**

* Fail-fast systems immediately throw errors when encountering unexpected conditions, forcing developers to explicitly handle edge cases before deployment.
* Instead of making assumptions, the system logs the error, notifies stakeholders, and halts execution, preventing incorrect data from propagating.

Example where Fail-Fast Design works:

* Compilers & Static Analyzers use Fail-Fast design. Programming languages with strict type systems (e.g., Rust, Haskell) prevent undefined behavior by failing at compile time never attempting to autocorrect errors.

### Masking Root Causes & Debugging Complexity

When a system autocorrects or adapts to unexpected input, the assumption obscures underlying problems. Developers will fail to notice errors, leading to hard-to-diagnose bugs in production.

Alternative: **Observability & Circuit Breakers with Fault Tolerance**

* Instead of blindly retrying, circuit breakers detect repeated failures and temporarily halt operations, preventing cascading failures.
* Observability tools (CloudWatch) ensure that fault-tolerant systems log anomalies for later analysis.

Example where **Observability & Circuit Breakers with Fault Tolerance works**:

* ECS automatically restarts failed containers but maintains logs, allowing engineers to investigate persistent failures, not masking them.
* Rolling back the most recent deployment when failures are detected is the Circuit Breaker.

Example where Observability works:

* Calling DIS to retrieve the Device Code and Metadata, unable to connect to DIS, however the DSN can still be decoded to retrieve the Device Code.
* Logging the Failure allows observability without interrupting the User.
* The circuit breaker (not calling DIS) is used with other patterns, such as retry, fallback (DSN Decoding), and timeout, to enhance fault tolerance in systems.

*It can be noted that Observability and Circuit breakers are both subsets of fault tolerance.*

### Increased Complexity & Performance Overhead

Fault tolerance requires additional logic, increasing system complexity and adding computational overhead. This reduces performance efficiency, and increases development costs.

Alternative: **Strict Input Validation**

* Instead of handling unexpected cases dynamically, strict validation ensures only properly formatted data enters the system, eliminating unnecessary computation.

Example Where Input Validation Works

* When users are inputting data to a UI, strict validation before submit allows the user to correct their errors. This works in scenarios where the user input is what causes the Fault.

### Business Logic Ambiguity

Fault-tolerant logic requires making assumptions regarding how to handle ambiguous cases. If different parts of the system apply different heuristics, inconsistent business rules emerge.

Alternative: **User Intervention & Human-in-the-Loop Systems**

* Instead of making assumptions, systems prompt the user for clarification or escalate ambiguous cases for manual review.

Example:

* When a mapping is missing in KDMS, the business approved default is to be used. If no business approved default is available, then the Fault needs to be escalated.

While fault-tolerant design is valuable for improving user experience and system reliability, Fault Tolerance is not the solution to every Fault. In cases where data integrity, security, or real-time performance is critical, fail-fast design, strict validation, and human-in-the-loop decision-making are appropriate.

## Fault-Tolerant Chaos Handling Over Error-Throwing and Execution Halts

In software engineering, the decision to either handle chaos smartly through fault-tolerant mechanisms or to immediately throw an error and halt execution has significant implications for system stability, user experience, and operational efficiency. Fault-tolerant design is preferred, ensuring that systems remain operational, resilient, and capable of adapting to unexpected conditions.

### Preventing Unnecessary Disruptions and Downtime

If a system halts execution upon detecting an anomaly, the operational workflow is disrupted, even if the issue is minor or recoverable. Fault-tolerant systems attempt to correct, adapt, or work through errors, ensuring continued operation.

If a system is expecting an epoch timestamp in milliseconds `1738868829000` but receives the timestamp in seconds `1738868829`, no action exists that allows the user to resolve this. If the “User” is an SQS message, that is especially unacceptable. Fail-fast concepts invoke a Failure, and the message is unprocessed until the upstream sender corrects the data type. Fault-tolerant systems detect and resolve the discrepancy, allowing continued processing and no unreasonable delays.  By handling the issue intelligently, the system maintains a seamless user experience, an improvement compared to throwing an error and causing downstream problems.

### Improving User Experience by Handling Imperfect Inputs

Real users regularly provide incomplete, inconsistent, or incorrect data. A rigid system that strictly validates every input frustrates users and reduces usability. When the user does not have an LPN, but the system is aware of the existing LPN, requiring the LPN as an input degrades the user experience. A smarter fault-tolerant approach suggests, or infers, the data. By handling input unknowns gracefully, the system delivers value even in the presence of missing data.

### Avoiding the “All-or-Nothing” Problem

Rigid error handling causes cascading failures, where one minor issue halts an entire workflow. Instead, smart chaos handling ensures that non-critical failures do not compromise the entire system. When a workflow is attempting to issue a replacement device to the customer, one step requires a promise date to be recorded. The existence of the Promise date plays an integral role in the consumer interaction, establishing expectations. Delivering on those expectations builds trust with the consumer.

A missing or undefined promise date, creates a data discrepancy. Stopping the workflow prevents the consumer from receiving a replacement device within the promised timeline. Fault-tolerant design argues that logging the failure or creating a metric allows developers to investigate and determine if a code change is required to ensure the Promise date is populated, without stopping the workflow from completing. Continuing to process the replacement allows the remaining actions to occur, without stopping the workflow. 99.99% of the valid actions are processed. A Fast-fail in this scenario raises the need for the promise date to be corrected, at the expense of the system’s primary goal.

### Reducing Operational Costs (On-call burden) by Minimizing Manual Interventions

Systems that default to throwing errors require constant operational oversight to resolve failures manually. A smarter, fault-tolerant system automatically resolves common issues, reducing the need for human intervention. In a scenario where a screening record is not created, a strict failure approach prevents the device from being screened. Manual intervention is required to create a blank screening record to allow the operations customer to continue processing. A fault-tolerant approach will create the blank screening record, without blocking the customer’s processes. Logging and metrics are used to notify developers of an upstream issue when the number of records in this category exceeds a reasonable amount. By implementing self-correcting mechanisms, operational overhead is significantly reduced. The On-call does not manually intervene, and the operation’s user is not blocked from processing the device.

### Facilitating More Maintainable and Extensible Code

Systems designed with strict error-handling tend to be brittle, requiring extensive try-catch blocks and manual error propagation logic. Fault-tolerant approaches reduce boilerplate code and make systems more adaptive to change. When a service changes a variable from “ReturnEventType” to “ReturnOrderType”, a strictly failure-driven system requires that all upstream services have immediate code changes. The same applies if a new required field is added. A fault-tolerant API checks both “ReturnEventType” and “ReturnOrderType”, preventing immediate downtime for upstream callers. A metric is used to determine when no calls are using “ReturnEventType”.  By making the system flexible, future changes require less rework and maintenance effort.

## Conclusion

Fault-tolerant programming prevents unnecessary disruptions. Systems remain operational in the presence of minor issues. This enhances user experience. Users receive constructive feedback instead of frustrating failures.

Fault-tolerant programming prevents avoids All-or-Nothing Failures. Partial failures don’t bring down entire systems. Preventing system failures supports continued scalability. Large, distributed systems remain resilient to component failures. Fault tolerance improves maintainability. Codebases grow adaptive and require less boilerplate exception handling. This reduces operational expenses, as fewer manual interventions are needed to resolve common issues.

While fail-fast approaches are appropriate for a limited number of mission-critical systems, in real-world applications, handling chaos intelligently ensures a balance of reliability, usability, and resilience. Next time your “Check engine” light comes on; that is Fault tolerant design using observability. I prefer the check engine light to my car stalling at highway speeds.

## Poll

Pick the one you agree with from each poll:

# Appendix

## General Mitigation Strategies for Exceptions:

1. Implement robust error handling and logging.
2. Use circuit breakers to prevent cascading failures.
3. Implement retry mechanisms with exponential backoff.
4. Use timeouts for all external calls.
5. Implement health checks and monitoring.
6. Use caching strategies to reduce dependency on external services.
7. Implement fallback mechanisms and graceful degradation.
8. Use asynchronous processing where possible to prevent blocking.
9. Implement proper resource management (connection pooling, thread pooling).
10. Implement proper exception hierarchies and error codes.
11. Implement proper logging and tracing for easier debugging.
12. Use feature flags to quickly disable problematic features.
13. Implement proper load balancing and auto-scaling.
14. Implement proper resource cleanup (e.g., closing connections, file handles).
15. Implement proper input validation to prevent unexpected data from causing failures.
16. Use static code analysis tools to catch potential issues early.
17. Implement proper configuration management to prevent misconfigurations.
18. Use containerization to ensure consistent environments across development and production.
19. Implement proper versioning for APIs and data structures to manage changes.
20. Implement proper logging and monitoring for all cache operations.
21. Use distributed tracing to understand the flow of requests across microservices.
22. Implement proper rate limiting and throttling to prevent system overload.
23. Use blue-green deployments or canary releases to minimize the impact of new deployments.
24. Implement proper data partitioning strategies to improve scalability and reduce the impact of failures.
25. Implement proper data backup and recovery strategies.
26. Use database replication and failover mechanisms to improve database availability.
27. Implement proper queue management with dead-letter queues for failed message processing.
28. Use idempotency keys for critical operations to prevent duplicate processing.
29. Implement proper request tracing to easily identify the source of failures.
30. Implement proper data archiving strategies to manage data growth.

## Failures

1. NetworkException (Failure)
    1. Purpose: Indicates a network-related issue.
    2. Cause: Network connectivity problems, DNS failures, or other network-related issues.
    3. How it's a Failure: It's an unexpected condition that prevents normal operation and is not directly caused by user input or expected system limitations.
    4. Mitigation: Implement robust network error handling, retries with exponential backoff, and circuit breakers.
2. TimeoutException (Failure)
    1. Purpose: Indicates that an operation has exceeded its allocated time.
    2. Cause: Slow responses from external services, resource contention, or system overload.
    3. How it's a Failure: It represents an unexpected delay that prevents normal operation.
    4. Mitigation: Implement timeouts for all external calls, use circuit breakers, and ensure proper resource allocation.
3. ServiceUnavailableException (Failure)
    1. Purpose: Indicates that a required service is not available.
    2. Cause: Service is down, undergoing maintenance, or overwhelmed.
    3. How it's a Failure: It's an unexpected condition that prevents normal operation.
    4. Mitigation: Implement service health checks, circuit breakers, and fallback mechanisms.
4. CircuitBreakerOpenException (Failure)
    1. Purpose: Indicates that a circuit breaker has tripped to prevent cascading failures.
    2. Cause: Multiple failures in dependent services or resources.
    3. How it's a Failure: While it's a protective measure, it still represents a system inability to perform normal operations.
    4. Mitigation: Implement proper circuit breaker patterns with appropriate thresholds and recovery strategies.
5. DatabaseConnectionException (Failure)
    1. Purpose: Indicates a failure to connect to the database.
    2. Cause: Database server is down, network issues, or configuration problems.
    3. How it's a Failure: It's an unexpected condition that prevents normal data operations.
    4. Mitigation: Implement connection pooling, retry mechanisms, and fallback strategies (e.g., read from cache).
6. DiskFullException (Failure)
    1. Purpose: Indicates that the disk storage is full.
    2. Cause: Insufficient disk space, uncontrolled log growth, or data accumulation.
    3. How it's a Failure: It's an unexpected condition that prevents normal operation and data storage.
    4. Mitigation: Implement disk space monitoring, automatic log rotation, and data archiving strategies.
7. IOException (Failure)
    1. Purpose: Indicates an I/O-related error.
    2. Cause: File system issues, network problems, or hardware failures.
    3. How it's a Failure: It's an unexpected condition that prevents normal I/O operations.
    4. Mitigation: Implement proper error handling for I/O operations, use retries where appropriate, and have fallback mechanisms.
8. SerializationException (Failure)
    1. Purpose: Indicates a failure in serializing an object.
    2. Cause: Incompatible object structures, circular references, or unsupported data types.
    3. How it's a Failure: It's an unexpected condition that prevents normal data processing and transmission.
    4. Mitigation: Implement proper serialization protocols, use versioning for data structures, and handle circular references.
9. TransactionException (Failure)
    1. Purpose: Indicates a failure in a database or distributed transaction.
    2. Cause: Concurrency issues, resource unavailability, or system inconsistencies.
    3. How it's a Failure: It's an unexpected condition that prevents normal operation and data consistency.
    4. Mitigation: Implement proper transaction management, use compensating transactions, and design for eventual consistency where appropriate.
10. CacheException (Failure)
    1. Purpose: Indicates a failure in cache operations.
    2. Cause: Cache inconsistency, cache overflow, or cache service unavailability.
    3. How it's a Failure: It's an unexpected condition that can lead to performance degradation or data inconsistencies.
    4. Mitigation: Implement cache consistency protocols, use cache eviction policies, and have fallback mechanisms to the primary data source.
11. MessageQueueException (Failure)
    1. Purpose: Indicates a failure in message queue operations.
    2. Cause: Queue overflow, connection issues, or message processing errors.
    3. How it's a Failure: It's an unexpected condition that disrupts normal message flow and processing.
    4. Mitigation: Implement proper queue management, use dead-letter queues, and have retry mechanisms.
12. EventPublishingException (Failure)
    1. Purpose: Indicates a failure in publishing an event.
    2. Cause: Event broker unavailability, network issues, or serialization problems.
    3. How it's a Failure: It's an unexpected condition that prevents normal event-driven operations.
    4. Mitigation: Implement local event storage for retry, use circuit breakers, and have fallback mechanisms.
13. LoadBalancerException (Failure)
    1. Purpose: Indicates a failure in load balancing operations.
    2. Cause: All backend services unavailable, configuration issues, or network problems.
    3. How it's a Failure: It's an unexpected condition that prevents proper distribution of traffic.
    4. Mitigation: Implement health checks, use circuit breakers, and have fallback routes.
14. ServiceDiscoveryException (Failure)
    1. Purpose: Indicates a failure in discovering service instances.
    2. Cause: Service registry unavailability, network issues, or configuration problems.
    3. How it's a Failure: It's an unexpected condition that prevents locating and connecting to services.
    4. Mitigation: Use caching of service locations, implement fallback to static
15. HealthCheckFailedException (Failure)
    1. Purpose: Indicates that a health check has failed for a service or component.
    2. Cause: Service malfunction, resource exhaustion, or dependency failures.
    3. How it's a Failure: It's an unexpected condition that indicates a service is not operating correctly.
    4. Mitigation: Implement comprehensive health checks, automate service restarts, and have fallback mechanisms.
16. LoggingException (Failure) - Non-blocking
    1. Purpose: Indicates a failure in the logging system.
    2. Cause: Log storage full, logging service unavailable, or configuration issues.
    3. How it's a Failure: It's an unexpected condition that prevents proper system monitoring and debugging.
    4. Mitigation: Implement local log caching, use log rotation, and have alternative logging mechanisms.
17. MonitoringException (Failure)  - Non-blocking
    1. Purpose: Indicates a failure in the monitoring system.
    2. Cause: Monitoring service unavailable, data collection issues, or configuration problems.
    3. How it's a Failure: It's an unexpected condition that prevents proper system oversight and alerting.
    4. Mitigation: Implement redundant monitoring systems, use local caching of metrics, and have manual check procedures.
18. TracingException (Failure)  - Non-blocking
    1. Purpose: Indicates a failure in the distributed tracing system.
    2. Cause: Tracing service unavailable, data collection issues, or configuration problems.
    3. How it's a Failure: It's an unexpected condition that prevents proper request tracking across services.
    4. Mitigation: Implement local trace storage for retry, use sampling to reduce load, and have alternative debugging methods.
19. RetryExhaustedException (Failure)
    1. Purpose: Indicates that all retry attempts for an operation have been exhausted.
    2. Cause: Persistent failures in the underlying operation.
    3. How it's a Failure: It's an unexpected condition that indicates a persistent problem in the system.
    4. Mitigation: Implement exponential backoff, circuit breakers, and fallback mechanisms.
20. FallbackException (Failure)
    1. Purpose: Indicates that a fallback mechanism has failed.
    2. Cause: Failure in both primary and fallback systems.
    3. How it's a Failure: It's an unexpected condition that indicates multiple layers of redundancy have failed.
    4. Mitigation: Implement multiple fallback options, graceful degradation, and clear error reporting.
21. TimeoutException (Failure)
    1. Purpose: Indicates that an operation has exceeded its allocated time.
    2. Cause: Slow responses, resource contention, or system overload.
    3. How it's a Failure: It's an unexpected delay that prevents normal operation.
    4. Mitigation: Implement timeouts for all operations, use asynchronous processing, and optimize slow operations.
22. InternalServerErrorException (Failure)
    1. Purpose: Indicates an unexpected error condition in the server.
    2. Cause: Unhandled exceptions, programming errors, or system failures.
    3. How it's a Failure: It's an unexpected condition that prevents normal operation and indicates a system malfunction.
    4. Mitigation: Implement comprehensive error handling, logging, and monitoring.
23. BadGatewayException (Failure)
    1. Purpose: Indicates that a server acting as a gateway or proxy received an invalid response from an upstream server.
    2. Cause: Upstream server errors, network issues, or misconfiguration.
    3. How it's a Failure: It's an unexpected condition that prevents normal operation due to dependency failures.
    4. Mitigation: Implement proper error handling for upstream services, use circuit breakers, and have fallback mechanisms.
24. GatewayTimeoutException (Failure)
    1. Purpose: Indicates that a gateway or proxy server did not receive a timely response from an upstream server.
    2. Cause: Slow upstream servers, network latency, or overloaded systems.
    3. How it's a Failure: It's an unexpected condition that prevents normal operation due to timing issues.
    4. Mitigation: Implement proper timeout settings, use asynchronous processing, and have fallback mechanisms.
25. AsyncOperationException (Failure)
    1. Purpose: Indicates a failure in an asynchronous operation.
    2. Cause: Errors in background processing, thread pool exhaustion, or task cancellation.
    3. How it's a Failure: It's an unexpected condition that prevents normal background processing.
    4. Mitigation: Implement proper error handling for async operations, use thread pool management, and have retry mechanisms.
26. ConsistencyException (Failure)
    1. Purpose: Indicates a violation of consistency rules in the system.
    2. Cause: Concurrent updates, failed distributed transactions, or bugs in business logic.
    3. How it's a Failure: It's an unexpected condition that leaves the system in an inconsistent state.
    4. Mitigation: Use optimistic concurrency control, implement compensating transactions, and have reconciliation processes.
27. StateManagementException (Failure)
    1. Purpose: Indicates a failure in managing state in stateful systems or stream processing.
    2. Cause: State corruption, storage failures, or consistency violations.
    3. How it's a Failure: It's an unexpected condition that can lead to incorrect processing results or system inconsistencies.
    4. Mitigation: Use durable state backends, implement state versioning, and have state recovery mechanisms.
28. ResourceExhaustionException (Failure)
    1. Purpose: Indicates that a system resource (CPU, memory, disk, etc.) has been exhausted.
    2. Cause: Resource leaks, unexpected high load, or misconfiguration.
    3. How it's a Failure: It's an unexpected condition that can lead to system instability or crashes.
    4. Mitigation: Implement proper resource monitoring, use adaptive resource allocation, and have clear degradation strategies.
29. DeadLetterQueueException (Failure)
    1. Purpose: Indicates a failure related to dead-letter queue operations.
    2. Cause: Queue full, message expiry, or processing failures.
    3. How it's a Failure: While it's a mechanism to handle failures, it still represents unprocessed messages or operations.
    4. Mitigation: Implement proper DLQ monitoring, use retry strategies with backoff, and have clear DLQ processing procedures.

## Errors

Errors are an integral part of any software system. They serve as a communication mechanism between different parts of a system, or between the system and its users, to indicate that something is wrong or that an expected operation cannot be completed. In the context of web services and APIs, errors are particularly crucial as they bridge the gap between client applications and server-side processes.

Why Errors Exist:

1. Communication: Errors provide a standardized way to communicate issues between the client and server.
2. Debugging: They help developers identify and fix problems in the system.
3. User Guidance: Errors can guide users on how to correct their actions or inputs.
4. System Integrity: They prevent invalid operations that could compromise data integrity or system stability.
5. Security: Errors can be used to mask sensitive information while still indicating an issue.

Two Main Categories of Errors (Server Perspective):

From a server's perspective, errors broadly fall into two main categories: Client Errors and Server Errors.

1. User Errors: These are errors that are caused by the client's actions and can typically be corrected by the client.
2. Client Errors: These are errors that are caused by the client's call and typically must be corrected by the software implementation of the Client.
    1. Although the Server has thrown an Error - this is a Failure on the Client (UI).

Characteristics:

* The server believes the error lies with the client's request.
* The client can potentially fix the issue by modifying their request.
* These errors don't typically require changes on the server side.


Why This Categorization Matters:

1. Responsibility: Categorization delineates whether the client (code), or the user is accountable for the error.
2. Action Plan:  Guides the next steps, whether the client (code) should modify their request or if user’s need to modify their inputs.
    1. User-mitigatable errors might be handled more lightly, while system-mitigatable errors often require more urgent attention (Like a Failure).
    2. This categorization helps support teams quickly determine whether they need to guide the user or investigate system issues.
3. User Experience: Categorization between User/Client helps in crafting appropriate error messages and guiding user actions.
    1. Provide appropriate guidance to users. For user-mitigatable errors, you give them the power to resolve issues. For system-mitigatable errors, you set appropriate expectations regarding resolution.
    2. A high rate of user-mitigatable errors might indicate need for better UI/UX, while frequent system-mitigatable errors could point to infrastructure or code issues.
4. System Design: These 2 categories influence how errors are logged, monitored, and addressed in the system architecture. A user error does not require a developer to intervene. A client (code) error does.
    1. Understanding this distinction helps in designing more robust systems. You can build better input validation for user-mitigatable errors and better fallback mechanisms for system-mitigatable errors.


This categorization provides a clear framework for handling errors, improving system reliability, and enhancing the overall user experience. In practice, providing clear, actionable error messages for user-mitigatable errors and informative, assuring messages for system-mitigatable errors enhances the overall reliability and usability of your software system.

When a user-facing UI receives a client error (typically a 4XX HTTP status code) from a server, it should handle the situation in a way that is informative, user-friendly, and actionable.

1. Clear Error Message:
    1. Display a concise, non-technical explanation of what went wrong.
    2. Use language that the average user can understand.
2. Specific Error Details:
    1. If available and appropriate, show more detailed information about the error.
    2. This could include error codes or specific fields that caused the issue for debugging if the user is unsure of the next steps or actions
3. Actionable Guidance:
    1. Provide clear instructions on what the user can do to resolve the error.
    2. For instance, "Please check your input and try again" or "You need to log in to access this feature".
4. Preserve User Input:
    1. When possible, maintain the user's input so they don't have to re-enter everything.
5. Option to Retry:
    1. Provide a clear way for the user to attempt the action again after making corrections.
6. Alternative Actions:
    1. Suggest alternative actions or paths the user can take if applicable.
7. Logging (Backend):
    1. While not visible to the user, ensure errors are logged for analysis and improvement.


Examples for different types of client errors:

For a 400 Bad Request (e.g., invalid form submission):
   "We couldn't process your request due to invalid information. Please check the highlighted fields and try again."

For a 401 Unauthorized:
   "You need to be logged in to access this feature. Please log in or create an account to continue."

For a 403 Forbidden:
   "You don't have permission to access this resource. If you believe this is an error, please contact support."

For a 404 Not Found:
   "We couldn't find the page you're looking for. It may have been moved or deleted. You can try searching for it or return to the homepage."

For a 429 Too Many Requests:
   "You've made too many requests in a short time. Please wait a few minutes before trying again."

The goal is to guide the user towards resolving the issue independently, or to set clear expectations if the error is not immediately resolvable by the user. Proper handling maintains a positive user experience, even when errors occur.

### User Mitigated Errors:

These are errors that can be resolved through actions taken by the end-user of the application or API.
Characteristics:

* The user can directly influence the outcome by changing their input or behavior.
* The error message should provide clear instructions on how to correct the issue.
* These errors often relate to input validation, permissions, or user-specific constraints.

User-mitigatable errors are important to distinguish because they empower the user to take corrective action without requiring technical intervention. They improve user experience by providing immediate feedback and a path to resolution.

1. DataNotFoundException (Error)
    1. Purpose: Indicates that requested data is not found in the system.
    2. Cause: Client requests data that doesn't exist.
    3. How it's an Error: It's a 4XX client error, typically 404 Not Found.
    4. Server Mitigation: Implement proper data validation and provide clear error messages. Use caching to reduce likelihood of stale data requests.
    5. User Mitigation: Request data that is available.
2. ValidationException (Error)
    1. Purpose: Signals that input data failed validation checks.
    2. Cause: Client submits invalid or incomplete data.
    3. How it's an Error: It's a 4XX client error, typically 400 Bad Request.
    4. Server Mitigation: Implement client-side validation, provide clear validation rules in API documentation, and return specific error messages.
    5. User Mitigation: Input Valid data
3. AuthorizationException (Error)
    1. Purpose: Signals that an authenticated user lacks permission for an action.
    2. Cause: User attempts to access restricted resources or perform unauthorized actions.
    3. How it's an Error: It's a 4XX client error, typically 403 Forbidden.
    4. Server Mitigation: Implement proper role-based access control (RBAC) and provide clear permissions documentation.
    5. User Mitigation: Request additional permissions.
4. DuplicateKeyException (Error)
    1. Purpose: Indicates an attempt to insert a duplicate key in a unique field.
    2. Cause: Client tries to create a resource with an identifier that already exists.
    3. How it's an Error: It's a 4XX client error, typically 409 Conflict.
    4. Server Mitigation: Implement proper uniqueness checks, provide clear error messages, and suggest alternative identifiers if possible.
    5. User Mitigation: Try again with a different key
5. ForeignKeyConstraintException (Error)
    1. Purpose: Signals a violation of a foreign key constraint.
    2. Cause: Client attempts to delete or modify data that other data depends on.
    3. How it's an Error: It's a 4XX client error, typically 409 Conflict.
    4. Server Mitigation: Implement cascading deletes where appropriate, provide clear dependency information, and suggest resolving dependencies before action.
    5. User Mitigation: Review data and re-submit with corrected fields
6. UniqueConstraintException (Error)
    1. Purpose: Indicates a violation of a unique constraint in the database.
    2. Cause: Client attempts to insert or update data that violates a uniqueness rule.
    3. How it's an Error: It's a 4XX client error, typically 409 Conflict.
    4. Server Mitigation: Implement uniqueness checks before database operations, provide clear error messages about which constraint was violated.
    5. User Mitigation: Review data and re-submit with corrected fields
7. InvalidStateException (Error)
    1. Purpose: Indicates that an operation is invalid for the current state of a resource.
    2. Cause: Client attempts an action that's not allowed in the current state.
    3. How it's an Error: It's a 4XX client error, typically 409 Conflict or 422 Unprocessable Entity.
    4. Server Mitigation: Implement proper state checks, provide clear documentation about valid state transitions.
    5. User Mitigation: Don’t perform this operation, or correct the state so this operation is allowed
8. StaleDataException (Error)
    1. Purpose: Signals that the client is working with outdated data.
    2. Cause: Client attempts to modify data that has been changed since it was last retrieved.
    3. How it's an Error: It's a 4XX client error, typically 409 Conflict.
    4. Server Mitigation: Implement optimistic locking, provide version information with resources, and suggest refreshing data before retrying.
    5. Client/User Mitigation: Refresh the available data
9. OptimisticLockException (Error)
    1. Purpose: Indicates a failure in optimistic locking.
    2. Cause: Concurrent modifications to the same resource.
    3. How it's an Error: It's a 4XX client error, typically 409 Conflict.
    4. Server Mitigation: Implement proper optimistic locking mechanisms, provide clear error messages, and suggest strategies for conflict resolution.
    5. User Mitigation: Re-try when data is not locked or in conflicts
10. PessimisticLockException (Error)
    1. Purpose: Signals a failure to acquire a pessimistic lock.
    2. Cause: Attempt to lock a resource that's already locked.
    3. How it's an Error: It's a 4XX client error, typically 409 Conflict or 423 Locked.
    4. Server Mitigation: Implement proper locking mechanisms, provide information about lock duration, and suggest retry strategies.
    5. User Mitigation: Re-try when data is not locked or in conflicts
11. DataIntegrityException (Error)
    1. Purpose: Indicates a violation of data integrity constraints.
    2. Cause: Client attempts an operation that would leave data in an inconsistent state.
    3. How it's an Error: It's a 4XX client error, typically 409 Conflict or 422 Unprocessable Entity.
    4. Server Mitigation: Implement thorough data validation, provide clear error messages about which integrity constraint was violated.
    5. User Mitigation: Re-try when data is not locked or in conflicts
12. ResourceNotFoundException (Error)
    1. Purpose: Indicates that the requested resource doesn't exist.
    2. Cause: Client requests a non-existent resource.
    3. How it's an Error: It's a 4XX client error, typically 404 Not Found.
    4. Server Mitigation: Implement proper resource checks, provide clear error messages, suggest alternative resources if possible.
    5. User Mitigation: Request an existing Resource
13. ConflictException (Error)
    1. Purpose: Signals a conflict with the current state of the resource.
    2. Cause: Client attempts an operation that conflicts with the resource's current state.
    3. How it's an Error: It's a 4XX client error, 409 Conflict.
    4. Server Mitigation: Implement proper state checks, provide clear error messages about the nature of the conflict.
    5. User Mitigation: Request non-conflicting data

### System (Software User) Errors:

These are errors that can only be resolved through actions taken by the software system or its administrators, not by the end-user.

Characteristics:

* The user cannot directly influence the resolution of the error.
* Error messages should inform the user that the issue has been logged and will be addressed by the system or support team.
* These errors often relate to system state, configuration, or external dependencies.

System-mitigatable errors are important to distinguish because they require different handling. The system needs to log these errors, potentially alert administrators, and handle them gracefully without expecting user intervention.

1. AuthenticationException (Error)
    1. Purpose: Indicates failure to authenticate a user.
    2. Cause: Invalid credentials or authentication token.
    3. How it's an Error: It's a 4XX client error, typically 401 Unauthorized.
    4. Server Mitigation: Implement secure authentication methods, use HTTPS, and provide clear error messages without exposing sensitive information.
    5. System Mitigation: Refresh the authentication
2. RateLimitExceededException (Error)
    1. Purpose: Indicates that the client has exceeded the allowed number of requests.
    2. Cause: Client makes too many requests in a given time period.
    3. How it's an Error: It's a 4XX client error, typically 429 Too Many Requests.
    4. Server Mitigation: Implement rate limiting on the server, provide clear rate limit information in headers, and suggest retry-after times.
    5. System Mitigation: Throttling/Debouncing requests
3. FileNotFoundException (Error)
    1. Purpose: Signals that a requested file is not found.
    2. Cause: Client requests a non-existent file.
    3. How it's an Error: It's a 4XX client error, typically 404 Not Found.
    4. Server Mitigation: Implement proper file management, provide clear error messages, and suggest alternative resources if possible.
    5. System Mitigation: Don’t request missing files
4. ParsingException (Error)
    1. Purpose: Indicates failure to parse input data.
    2. Cause: Client submits malformed data that can't be parsed.
    3. How it's an Error: It's a 4XX client error, typically 400 Bad Request.
    4. Server Mitigation: Implement robust parsing logic, provide clear input format requirements, and return specific error messages about parsing failures.
    5. System Mitigation: Don’t submit invalid data in the request
5. VersionMismatchException (Error)
    1. Purpose: Signals a mismatch between client and server versions.
    2. Cause: Client uses an incompatible version of the API.
    3. How it's an Error: It's a 4XX client error, typically 400 Bad Request or 422 Unprocessable Entity.
    4. Server Mitigation: Implement proper versioning strategy, provide clear version information in API documentation, and suggest upgrade paths.
    5. System Mitigation: Try again with the new version
6. APIVersionException (Error)
    1. Purpose: Indicates that the requested API version is not supported.
    2. Cause: Client requests an unsupported or deprecated API version.
    3. How it's an Error: It's a 4XX client error, typically 400 Bad Request or 406 Not Acceptable.
    4. Server Mitigation: Implement proper API versioning, provide clear documentation on supported versions, and suggest migration to supported versions.
    5. System Mitigation: Fix the Caller to use the correct API Version
7. InvalidInputException (Error)
    1. Purpose: Signals that the input provided by the client is invalid.
    2. Cause: Client submits data that doesn't meet the required format or constraints.
    3. How it's an Error: It's a 4XX client error, typically 400 Bad Request.
    4. Server Mitigation: Implement thorough input validation, provide clear input requirements in API documentation, and return specific error messages about invalid inputs.
    5. System Mitigation: Fix the Caller to use the correct Input
8. ThrottlingException (Error)
    1. Purpose: Signals that the client is being throttled due to excessive requests.
    2. Cause: Client makes too many requests in a short time period.
    3. How it's an Error: It's a 4XX client error, typically 429 Too Many Requests.
    4. Server Mitigation: Implement proper rate limiting, provide clear information about limits, and suggest appropriate request rates.
    5. System Mitigation: Throttling/Debouncing on Client Requests
9. SchemaValidationException (Error)
    1. Purpose: Signals that input data doesn't conform to the expected schema.
    2. Cause: Client submits data that doesn't match the defined schema.
    3. How it's an Error: It's a 4XX client error, typically 400 Bad Request.
    4. Server Mitigation: Implement schema validation, provide clear schema documentation, and return specific validation errors.
    5. System Mitigation: Fix the schema in the request
10. ContentTypeException (Error)
    1. Purpose: Indicates that the Content-Type of the request is not supported.
    2. Cause: Client sends data with an unsupported Content-Type.
    3. How it's an Error: It's a 4XX client error, typically 415 Unsupported Media Type.
    4. Server Mitigation: Clearly document supported Content-Types, implement proper Content-Type checking.
    5. System Mitigation: Fix the content type in the request
11. AcceptHeaderException (Error)
    1. Purpose: Signals that the server can't produce a response matching the Accept headers.
    2. Cause: Client requests a response format that the server can't provide.
    3. How it's an Error: It's a 4XX client error, typically 406 Not Acceptable.
    4. Server Mitigation: Clearly document supported response formats, implement content negotiation.
    5. System Mitigation: Fix the content type in the request
12. UnsupportedMediaTypeException (Error)
    1. Purpose: Indicates that the request entity has a media type the server doesn't support.
    2. Cause: Client sends data in an unsupported format.
    3. How it's an Error: It's a 4XX client error, 415 Unsupported Media Type.
    4. Server Mitigation: Clearly document supported media types, implement proper media type checking.
    5. System Mitigation: Fix the content type in the request
13. MethodNotAllowedException (Error)
    1. Purpose: Signals that the HTTP method is not allowed for the requested resource.
    2. Cause: Client uses an HTTP method not supported by the resource.
    3. How it's an Error: It's a 4XX client error, 405 Method Not Allowed.
    4. Server Mitigation: Implement proper method handling, return Allow header with supported methods.
    5. System Mitigation: Fix the method type in the request
14. PreconditionFailedException (Error)
    1. Purpose: Indicates that one or more conditions in the request header fields failed.
    2. Cause: Client's preconditions (like If-Match) are not met.
    3. How it's an Error: It's a 4XX client error, 412 Precondition Failed.
    4. Server Mitigation: Implement proper handling of conditional requests, provide clear documentation on preconditions.
    5. System Mitigation: Fix the pre-conditions in the request
15. IdempotencyKeyException (Error)
    1. Purpose: Signals an issue with the idempotency key.
    2. Cause: Client reuses an idempotency key incorrectly or uses an invalid key.
    3. How it's an Error: It's a 4XX client error, typically 400 Bad Request or 409 Conflict.
    4. Server Mitigation: Implement proper idempotency key handling, provide clear documentation on idempotency key usage.
    5. System Mitigation: Create a new idempotency Key (or do nothing, since the idempotency key indicates the request already occurred).
16. DeserializationException (Error)
    1. Purpose: Indicates a failure in deserializing data into an object.
    2. Cause: Corrupted data, incompatible versions, or malformed input.
    3. How it's a Error: It's an unexpected condition that prevents normal data processing and usage.
    4. Server Mitigation: Implement robust deserialization with proper error handling and version checking.
    5. System Mitigation: Fix the content type in the request

## Faults

1. ConfigurationException (Fault)
    1. Purpose: To indicate issues with system configuration.
    2. Cause: Incorrect or missing configuration settings.
    3. Fits Fault definition: It's an unexpected condition that prevents normal operation.
    4. Mitigation: Contact appropriate team to add appropriate Configurations
2. BusinessLogicException (Fault)
    1. Purpose: To indicate violations of business rules or logic.
    2. Cause: Unexpected data or state that doesn't comply with business requirements.
    3. Fits Fault definition: It represents a failure in the application's core logic.
    4. Mitigation: Contact owning Stakeholders to determine what appropriate logic should be in this situtation
3. DeserializationException (Fault)
    1. Purpose: Indicates a failure in deserializing data into an object.
    2. Cause: Poor data de-serialization implementation
    3. How it's a Fault: It's an unexpected condition that prevents normal data processing and usage.
    4. Mitigation: Implement robust deserialization with proper error handling and version checking to prevent the error from being thrown.
4. SerializationException (Fault)
    1. Purpose: Indicates a failure in serializing an object.
    2. Cause: Poor data serialization techniques
    3. How it's a Fault: It's an unexpected condition that prevents normal data processing and transmission.
    4. Mitigation: Implement proper serialization protocols, use versioning for data structures, and handle circular references.
5. InvalidInputException (Fault)
    1. Purpose: Signals that the input provided by the client is invalid.
    2. Cause: Client submits data that doesn't meet the required format or constraints.
    3. How it's an Fault: It's a fault if the correct input can be created:
        1. Expecting: Integer
        2. Received: “18”
        3. Self-healing `typeof(input) === "integer" ? input : parseInt(input,10``)`
    4. Server Mitigation: Implement thorough input validation, provide clear input requirements in API documentation, and return specific error messages about invalid inputs.
    5. System Mitigation: Fix the Caller to use the correct Input
6. DateTimeParseException (Fault)
7. DuplicateKeyException (Fault)
8. TypeMismatchException (Fault)
9. ValueNotSpecifiedException (Fault)
10. BooleanRepresentationUnknown (Fault)
11. TimeZoneUnknownException (Fault)
12. WhiteSpaceNotAllowedAtEndOfStringException (Fault)

### Self Healing Samples:

The distinction between faults that need to be observed and those that can be silently self-healed is crucial for effective system management and optimization.

Faults that need to be observed (via metrics/logs):

1. Critical Business Logic Errors:
    1. These directly impact core functionality and may indicate deeper issues in the system or business processes.
2. Data Integrity Issues:
    1. These could lead to cascading errors and inconsistencies across the system.
3. Repeated Self-Healing Actions:
    1. If the same issue is being self-healed frequently, it might indicate a underlying problem that needs addressing.
4. User Experience Impacting Issues:
    1. These directly affect user satisfaction and system usability.

Faults that can be silently self-healed:

1. Transient Network Issues:
    1. These are often temporary and resolve themselves.
2. Minor Data Format Inconsistencies:
    1. As long as they can be reliably corrected, these don't typically indicate larger issues.
    2. Example: Converting date formats from MM/DD/YYYY to YYYY-MM-DD.
3. Cache Misses:
    1. These are normal and expected in distributed systems.
4. Load Balancing Adjustments:
    1. Part of normal system operations in distributed environments.
5. Automatic Retries on Idempotent Operations:
    1. If designed correctly, these don't affect the final state of the system.
6. Minor UI Adjustments:
    1. If they don't significantly impact user experience, these can be handled quietly.
    2. Falling back to a default font if a custom font fails to load.

Rationale for the Distinction:

1. Signal-to-Noise Ratio:
    1. Observing every self-healed fault could overwhelm monitoring systems and obscure critical issues.
    2. Silent self-healing for minor, expected issues helps maintain a cleaner, actionable set of logs and metrics.
2. Operational Focus:
    1. Observing critical faults allows teams to focus on systemic issues that require human intervention or strategic changes.
    2. Silently handling minor issues allows the system to operate smoothly without constant human oversight.
3. Performance Considerations:
    1. Logging and metrics collection for every minor self-healing action introduces performance overhead.
    2. Silent handling of routine issues can be more efficient.
4. Trend Analysis:
    1. Observing certain faults allows for trend analysis over time, which informs system improvements.
    2. Routine self-healing actions might not provide valuable trend data.


In practice, the decision of what to observe versus what to silently self-heal depends on the specific context of the system, its users, and its operational requirements. It's common to implement tiered logging, where all self-healing actions are logged at a debug level, but only more significant ones are elevated to elevated log levels or metrics for immediate attention.

The key is to strike a balance between maintaining system health, operational efficiency, and having sufficient visibility into critical system behaviors. This balance allows for proactive problem-solving and continuous improvement while avoiding information overload.

1. Data Recovery: In cases where data might otherwise be lost or rejected due to format issues, self-healing can help recover and process that data correctly.
2. Fault Tolerance: This approach makes the service more fault-tolerant, able to handle minor inconsistencies in input data without failing or requiring manual intervention.
3. Graceful Degradation: Instead of failing outright when encountering an unexpected format, the service gracefully adapts, allowing the process to continue. This aligns with the principle of robustness in system design.
4. Error Reduction: By automatically detecting and adapting to the correct the fault, the service reduces the chances of data being misinterpreted or rejected due to format issues. This leads to fewer errors and less manual intervention.
5. Improved Data Processing: With self-healing, the service can process a wider range of inputs correctly, leading to more accurate data analysis and fewer data quality issues downstream.
6. Time Saving: Automatic detection and correction save time for both users and developers. Users don't need to spend time reformatting their data, and developers don't need to handle as many support requests related to format issues.
7. User Convenience: Users may not always be aware of the exact format requirements. By accepting multiple delimiter types, the service becomes more user-friendly, reducing frustration and the need for users to manually reformat their data.
8. Interoperability: Different systems and regions may use different defaults. For example, some European countries use semicolons instead of commas to avoid confusion with decimal separators. Self-healing allows the service to work seamlessly with data from various regions and systems.
9. Enhanced User Experience: Users perceive the service as more intelligent and flexible, leading to a better overall user experience and potentially increased user adoption and satisfaction.

#### Observed

This is an example of correcting the Type when a mismatched type is determined. Observing type mismatches and their corrections is an important practice in many systems. Frequent type mismatches could indicate issues with data sources, input validation, or data transformation processes. Observing these corrections helps in identifying and addressing the root causes of data quality issues. Recurring type corrections could have a cumulative performance impact. Monitoring allows for assessing this impact and optimizing if necessary.

```
public int processValue(Object value) {
    if (value instanceof Integer) {
        return (Integer) value;
    } else if (value instanceof String) {
        try {
            return Integer.parseInt((String) value);
        } catch (NumberFormatException e) {
            log.warn("Failed to parse string to integer. Using default value.");
            log.metric("TypeMismatchIntegerExpected");
            return DEFAULT_VALUE;
        }
    }
    return DEFAULT_VALUE;
}
```

This is an example where the date coming from the input source is not properly formatted - but is in an acceptable state:

```
public Date parseDate(String dateString) {
    List<SimpleDateFormat> knownFormats = Arrays.asList(
        new SimpleDateFormat("yyyy-MM-dd"),
        new SimpleDateFormat("MM/dd/yyyy"),
        new SimpleDateFormat("dd-MMM-yyyy")
    );

    for (SimpleDateFormat format : knownFormats) {
        try {
            return format.parse(dateString);
        } catch (ParseException e) {
            // Continue to next format
            log.metric("DateFormatIncorrect")
        }
    }
    log.warn("Unable to parse date string. Using current date.");
    log.metric("DefaultDateUsedForCreatedDate")
    return new Date();
}
```

This will self-heal (when appropriate) an incorrect status that is passed into the application.

```
public Status parseStatus(String statusString) {
    try {
        return Status.valueOf(statusString.toUpperCase());
    } catch (IllegalArgumentException e) {
        log.warn("Unknown status: {}. Defaulting to UNKNOWN.", statusString);
        log.metric("StatusUnknownExceptionUsingDefault")
        return Status.UNKNOWN;
    }
}
```

Self-healing decimals that are rounded to the wrong format is a crucial feature for many systems, especially those dealing with financial data, scientific calculations, or any application where precision is important. Different sources or users might provide decimal numbers with varying levels of precision. Self-healing ensures that all decimal values are consistently formatted within the system, maintaining data integrity.

```
public BigDecimal adjustPrecision(BigDecimal value, int scale) {
    return value.setScale(scale, RoundingMode.HALF_UP);
}
```

Self-healing broken or missing timezones is a crucial feature for many systems, especially those dealing with global users or data from various geographical locations. Timezone information is critical for accurate time-based operations. Self-healing ensures that even if timezone data is missing or incorrect, the system can still process time-related information consistently. For systems operating across multiple time zones, having a reliable way to handle timezone discrepancies is crucial for smooth operation and data integrity.

```
public ZonedDateTime standardizeTimeZone(ZonedDateTime dateTime) {
    return dateTime.withZoneSameInstant(ZoneId.of("UTC"));
}
```

#### Non-Observed

Non-observered Self-Healing faults are faults that do not need to be observed because no corrective action is needed when the self-healing is used. No Error/Failure fix required: This does not require any monitoring or observability.

The self-healing approach for incorrect CSV delimiters is a great example of how systems can be made more robust and user-friendly. CSV files can come from various sources, and not all sources adhere to the same standards. Some may use commas, others semicolons, and some might even use tabs. By self-healing the delimiter, the service ensures that it can process data consistently regardless of the input format. By handling various delimiter types automatically, the service reduces the number of support tickets and queries related to CSV formatting issues, freeing up support resources for more complex problems.

```
public List<String[]> parseCsv(String input) {
    List<String[]> result = new ArrayList<>();
    String[] lines = input.split("\n");
    for (String line : lines) {
        String[] fields;
        if (line.contains(",")) {
            fields = line.split(",");
        } else if (line.contains(";")) {
            fields = line.split(";");
        } else {
            fields = line.split("\t");
        }
        // Remove quotes if present
        for (int i = 0; i < fields.length; i++) {
            fields[i] = fields[i].replaceAll("^\"|\"$", "").trim();
        }
        result.add(fields);
    }
    return result;
}
```

Self-healing incorrect Boolean inputs is another great example of making a service more robust and user-friendly. Boolean values can be represented in various ways (true/false, yes/no, 1/0, on/off). By self-healing these inputs, the service ensures consistent interpretation of Boolean data regardless of the input format. Different systems or data sources might use different representations for Boolean values. Self-healing allows the service to work seamlessly with data from various sources without requiring standardization at the source.

```
public Boolean parseBoolean(String value) {
    if (value == null) return null;
    String lowercaseValue = value.toLowerCase().trim();
    if (lowercaseValue.matches("^(true|yes|1|on)$")) {
        return true;
    } else if (lowercaseValue.matches("^(false|no|0|off)$")) {
        return false;
    }
    log.warn("Unable to parse boolean value: {}", value);
    return null;
}
```

Self-healing incorrectly formatted JSON is a powerful technique that can significantly enhance the robustness and usability of a service. JSON is a widely used data format, but it's also easy to make minor formatting mistakes. Self-healing ensures that slightly malformed JSON can still be processed, maintaining data consistency across the system. Users or client systems may not always provide perfectly formatted JSON. By accepting and correcting common mistakes, the service becomes more user-friendly and forgiving. Automatic correction of JSON formatting saves time for both users and developers. Users don't need to spend time perfecting their JSON, and developers don't need to handle as many JSON-related issues.

```
public JsonNode parseJson(String input) {
    ObjectMapper mapper = new ObjectMapper();
    try {
        return mapper.readTree(input);
    } catch (JsonProcessingException e) {
        // Try to fix common issues
        String fixed = input.replaceAll("'", "\"")  // Replace single quotes with double quotes
                            .replaceAll("(\\w+)\\s*:", "\"$1\":") // Add quotes to keys
                            .replaceAll(",\\s*}", "}") // Remove trailing commas
                            .replaceAll(",\\s*]", "]");
        try {
            return mapper.readTree(fixed);
        } catch (JsonProcessingException ex) {
            log.warn("Unable to parse JSON: {}", input);
            return mapper.createObjectNode(); // Return empty object
        }
    }
}
```

Self-healing URLs in unexpected formats is a valuable technique that can significantly improve the robustness and user-friendliness of a service. URLs can be entered or transmitted in various formats, some of which may be technically incorrect but still understandable. Self-healing ensures that these URLs are standardized, maintaining consistency in how the service handles web addresses. Users often input URLs in formats they're accustomed to, which may not always be technically correct. By accepting and correcting common mistakes, the service becomes more user-friendly and forgiving. Instead of rejecting URLs with minor formatting issues, the service adapts and continues processing. This aligns with the principle of robustness in system design.

```
public String sanitizeUrl(String url) {
    if (!url.startsWith("http://") && !url.startsWith("https://")) {
        url = "https://" + url;
    }
    return url.replaceAll("\\s+", "").trim();
}
```
