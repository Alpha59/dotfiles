# Functional Testing

Functional testing at Amazon is an area which many teams struggle to properly perfect. This is caused by several factors, which are outlined in this discussion, and leads to a number of developmental delays and issues. By examining the current state of testing, and taking a high-level view of the definitive uses of different test levels, a better approach to Functional Testing is revealed throughout this paper. This discussion is focused on the purpose, goal, and ultimately the implementation of functional tests. Although some proposed approaches are discussed, and solutions presented, this paper does not provide a definitive resolution to the Functional test approach at Amazon. The aim of this paper is instead focused on presenting a more definitive definition of Functional tests to provide a clear path forward for teams wishing to take advantage of functional testing.

## Functional Test Overview

Functional Tests are meant to be written together with Business Customers. Functional tests require a proper environment which allows them to execute properly. Moving logic out of the UI and into a service can be the first step to ensuring good functional tests.


>[Deliver Results](https://w.amazon.com/bin/view/LeadershipPrinciples/DeliverResults): Leaders focus on the key inputs for their business and deliver them with the right quality and in a timely fashion. Despite setbacks, they rise to the occasion and never settle.


Functional tests differ from Unit Tests in that they need to be owned by the Customer as well as the Developer. The Customer should be defining the Test functionality in a way that allows them to Read/Write tests, even if they are then implemented by the developer separately. Functional tests must be run automatically – as part of the pipeline. Changes to the Functional Tests should be reviewed as part of the business process. Functional tests should outline a business process – they should be written and executed from the perspective of a business user, and the expectation that they are following a business process.

### Why Functional Test

Functional tests serve several purposes, but can be boiled down to a few key points. Functional tests can be used to isolate issues between multiple interacting services. Although unit tests can be used to detect bugs in individual classes or services, functional tests serve the purpose of detecting inter-module dependencies. Functional tests primarily serve the purpose of replacing manual testing of the entire system. Manual testing can become increasingly slow, and thus slow down the release cycle, in a larger system. The goal of Functional tests should be to eliminate the manual step of the process – and instead of re-testing existing architecture, fall back to automated testing.

 Since Functional tests are jointly owned with the business, they can also help to determine business requirements. They do this by creating a framework for the business to define the logic that they would like to see implemented. This can lead to more precise requirements, and fewer requirements that contradict each other. Functional Tests, and their supporting customer document, act as a living requirements document. This helps to ensure that requirements are up-to-date, and include all the business critical scenarios that need to be defined.


>[Insist on the Highest Standards](https://w.amazon.com/bin/view/LeadershipPrinciples/InsistOnTheHighestStandards): Leaders have relentlessly high standards — many people may think these standards are unreasonably high. Leaders are continually raising the bar and drive their teams to deliver high quality products, services, and processes. Leaders ensure that defects do not get sent down the line and that problems are fixed so they stay fixed.



#### Layers Of Software

In the context of designing an application using a layered architecture, the three layers you mentioned—service layer, domain layer, and persistence layer—play distinct roles in organizing and separating different aspects of the application's functionality. Here's a quick summary of each:

* **Service Layer:** The service layer, sometimes referred to as the application layer, is responsible for handling the application's business logic and coordinating the interactions between different components. It acts as an interface between the presentation layer (user interface) and the domain layer. The service layer receives requests from the user interface, processes them, and delegates tasks to the appropriate parts of the application. This layer can contain services, which are responsible for specific use cases or functionalities within the application.
* **Domain Layer:** The domain layer (also known as the business logic layer) contains the core business logic and rules of the application. It represents the real-world concepts, rules, and behaviors that the application models. This layer encapsulates the fundamental data structures, entities, and operations that are specific to the domain of the application.
* **Persistence Layer:** The persistence layer, sometimes referred to as the data access layer, is responsible for managing the storage and retrieval of data to and from a data store, such as a database. It abstracts the details of data storage and retrieval operations from the rest of the application. The persistence layer provides a way for the application to interact with the data store without having to know the underlying implementation details. This separation allows for flexibility in changing the data storage solution without affecting the rest of the application.

These three layers work together in a layered architecture to promote modularity, separation of concerns, and maintainability in software development. The service layer handles application-specific logic and coordination, the domain layer encapsulates the core business logic, and the persistence layer manages data storage and retrieval operations. This separation helps in building maintainable, scalable, and understandable software systems.

In addition to the service layer, domain layer, and persistence layer, there can be other layers in a software application, depending on the complexity and requirements of the system. Here are some additional layers that might be present in a software architecture:

* Presentation Layer: The presentation layer is responsible for handling the user interface and user interaction. It includes components that present data to users and collect user input. This layer focuses on the visual representation of the application and user experience. It can include web interfaces, desktop GUIs, mobile app interfaces, and other user-facing components.
* Integration Layer: The integration layer facilitates communication between different software components or systems. It handles tasks such as data transformation, message passing, and service orchestration. This layer is crucial when an application needs to interact with external services, APIs, or third-party systems.
* Security Layer: The security layer is responsible for enforcing security measures and policies throughout the application. It manages authentication, authorization, data encryption, and other security-related aspects. This layer ensures that the application remains protected against unauthorized access and data breaches.
* Infrastructure Layer: The infrastructure layer includes components that provide low-level services and support for the application. This can include services like logging, monitoring, configuration management, and deployment automation. The infrastructure layer ensures that the application runs reliably and efficiently in its operational environment.
* Communication Layer: The communication layer handles communication between different parts of the application, whether they are running on the same machine or distributed across a network. This layer is responsible for establishing connections, handling protocols, and managing data exchange.
* Caching Layer: The caching layer is responsible for storing frequently accessed data in memory to improve performance. By storing data in a cache, the application can reduce the need to retrieve data from slower data stores like databases.
* Logging and Monitoring Layer: This layer is responsible for collecting and managing logs, metrics, and other monitoring data from the application. It helps in diagnosing issues, tracking performance, and gaining insights into the application's behavior.
* Messaging Layer: The messaging layer facilitates asynchronous communication between different components of the application or between distributed systems. It is often used to decouple components and improve scalability.
* Utilities and Common Libraries Layer: This layer includes reusable components, libraries, and utilities that are used across different parts of the application. It promotes code reuse and consistency.
* External Services Layer: This layer includes integrations with third-party services or APIs that the application relies on for additional functionality, such as payment gateways, mapping services, or social media platforms.

The number and specific naming of layers can vary based on the architecture and design choices for your software application. The goal is to create a structure that promotes modularity, separation of concerns, and maintainability.

### What Functional Tests should Cover

Functional tests should always execute logic from the service layer down to the domain layer, but may or may not include the persistence layer. This can be a complicated topic, as often the persistence layer can make testing difficult, if not impossible, to maintain. Another complication is that interacting with other services where the persistence layer is not controlled by the development team - may lead to in-accurate results. This being the case, it is important to note that many errors are located at these boundaries, and functional tests should serve the purpose of attempting to check these boundary layers as well.

 Functional tests should not live in the same framework as Unit Tests, since they should not be focused on “Code-Coverage”, although using them to identify “Code-Coverage” may help to eliminate unnecessary or dead code. At the same time though, users should be able to view the output of functional tests, so that they are aware of the changes - in a business focused report. This report should be generated in a way that allows business users to view all the new tests, removed tests, and modified tests, as well as see the results of failed tests.


>[Customer Obsession](https://w.amazon.com/bin/view/LeadershipPrinciples/CustomerObsession): Leaders start with the customer and work backwards. They work vigorously to earn and keep customer trust. Although leaders pay attention to competitors, they obsess over customers.


 The primary focus of Functional Tests should still be on the business logic. **This means that functional tests should not be added, modified, or removed for Operational Excellence related work**. This should allow tests to be much more robust, they should only break or change when the business logic associated with the workflow is changed. The functional testing report can also have specific business value in helping to determine which bugs are of highest priority. By viewing which business processes are broken, management can target the most business critical bugs first.

### Challenge

The current state of testing within the devices org, and across MAWS applications is challenging and makes product development, integration, and functional testing painful.

* The test environment is usually not faithful to the production environment, since many developers use the test environment for experimenting with internal service changes. There are no agreed upon organizational standards for environments.
* Test data is highly volatile, and refreshed infrequently. There are no agreed upon organizational standards for test data.
* Unpredictable availability of test services can delay release schedules.
* Not enough time built into the project schedules to perform quality testing
* Many SDEs disinclined to perform quality testing due to higher barrier to modification than unit testing

 There is no central test environment that faithfully recreates the entire production environment. There is no process to select versions of components or subsystems against which to test. There is no easy method to create or refresh test-specific data. It is often labor-intensive and time-consuming to put a customer data into the requisite state for testing.

Functional tests are meant to prevent “Change Fear” where a change’s downstream impacts are not known, and therefore a developer is hesitant to make changes. Or worse, poor functional testing can give overconfidence to developers so that they do not properly consider the downstream impacts, and introduce catchable bugs into the system. Functional testing at Amazon can introduce both problems at once because poorly designed, and poorly documented functional tests give developers a fear of changing the functional tests. When a functional test is passing, developers are overly confident that the change will not have a negative impact - but when a functional test is not passing, developers are not aware of the reasons why the tests exist - paralyzing them into being unsure if tests should be updated, or code should be fixed.

## Theory of Tests

Testing serves a variety of uses in the development cycle, not limited to just marking the code coverage as complete, or adding lines of code to the developers’ change request. Understanding the importance of testing requires breaking test scenarios down into their categories of uses.

* Detecting Defects from Execution-based testing
* Designing test cases from different perspectives
* Selecting a subset of test cases from the set of all possible test cases
* Effectiveness of the test case selection strategy
* Priority of selected tests

Testing cannot uncover faults that do not exist, only faults which do exist. An ideal test is a test where the sample of the input domain can conclude that the program contains no errors. Faults occur due to inadequate understanding of all conditions which a program may be executed, or failure to realize that certain combinations of conditions require special treatment. This can lead to either:

* Missing Control Flow Path
* Inappropriate Control Flow Path Selection
* Inappropriate or missing actions within a Control Flow path

## **Problem Statement**

Functional tests as defined by Amazon are incorrect representations of functional tests. Functional tests at Amazon are designed to test a single function, or activity, of a system, with the idea that functional tests should be run in an isolated environment, like unit testing, which ignores integrations. This is antithetical to the premise and definition of functional tests. Since Functional Tests are managed solely by the development team, and do not include any business buy in - they serve no greater purpose of verifying that functionality is, in fact, the expected behavior. They only verify that the Functional tests are passing.


>Functional tests are designed to check if changes to your service work as intended, before promoting those changes to production. They are similar to unit tests, except they instead use real endpoints and configurations instead of mocks. This type of testing verifies that each software component of your application/service is working correctly. Examples of functional testing are unit testing and integration testing. - [Builder Hub](https://builderhub.corp.amazon.com/docs/hydra/user-guide/getting-started-basics.html#basics-functional)

### What Broke Amazon Testing

Testing at Amazon was reimagined by “[Project Hellfire](https://w.amazon.com/bin/view/Hellfighters)”, from the Builder Tools organization on January 31st, 2012, who muddied the line between integration, and functional tests in response to a series of developer surveys conducted in 2011. As part of this proposal, the “Hellfire” initiative improved builder tools and pipelines with the premise that writing functional tests should include the unit testing functionality of ”Isolating“ unnecessary parts of the stack effectively.

 To resolve the existing issue at Amazon of expecting functional testing to be performed by clients, and not developers, “Project Hellfire” focused efforts on creating a robust test environment to thoroughly test the code changes being introduced by a development team. Although this seems like a reasonable solution, it came at the expense of testing integrations with other services, and focusing only on testing the changes which were being introduced. This initiative did not account for documentation in any way, and expected the functional tests would be self documenting. Although this is a commonly accepted unit testing mindset, it removes the business or stakeholder ownership of functional tests, and reduces the effectiveness of functional tests to simply more robust unit testing of individual activities.

 It is important to note that a Functional Test does not need to be completely integrated into the ecosystem, and should not require a production environment to run. There is an expectation that some dev/test environment changes will cause errors, but over exertion of isolation, and focusing on testing only your software changes, can also lead to errors and poor integrations. “Project Hellfire” was ultimately focused on increasing the ease of development, and the overall developer buy-in of functional tests to increase the usefulness of CI/CD pipelines. This goal was successfully accomplished, as it is now considered an Amazon standard to include functional tests and pipelines in all Amazon projects.

## Differentiating Testing Types

### Unit Testing

Unit testing is the testing of units of a program within an isolated environment. Unit tests can be on any level, but must test a distinct and independent piece of the program. These tests should cover all logically relevant pieces of code. Testing all the units of a program is required before moving on to testing larger parts of the system. Where an integration test looks at how individual functions or modules interact, a unit test is only looking to validate the input/output of a specific portion of code - independent of the state or other program units.

 Unit tests should

* Execute every line of code
* Execute every predicate in a unit to evaluate them to true/false separately.
* Observer that the unit performs its intended function and ensure that it contains no errors.

Scope:

* Unit tests focus on testing individual units of code in isolation. A unit could be a function, method, or a small component of code.
* The purpose of unit testing is to ensure that each unit of code works as expected and produces correct output for various inputs.

Isolation:

* Unit tests are designed to run in isolation from the rest of the application. They often use mock objects or stubs to simulate the behavior of other components or dependencies.

Granularity:

* Unit tests are very fine-grained and target specific functionalities within a unit of code.
* They are designed to catch small bugs, edge cases, and validate the correctness of the code logic.

Coverage:

* Unit tests focus on achieving high coverage within the unit being tested.
* The objective is to test all the possible scenarios and paths within the unit to ensure its correctness.

### Control Flow Testing

Programs are defined by the series of paths that can be taken throughout the program, which may be an infinite, or considerable number, of paths - depending on the number of inputs and possible outputs to the program. Ideally, testing strives to execute the fewest number of inputs/outputs to cover all possible paths - and should create a feedback loop with the executed code to create a smaller number of possible paths to produce the desired input/output relationship.

 Control flow testing which covers all available paths can detect all faults, **except for the faults due to missing path errors.** Covering the shortest paths first, and growing the number of possible outputs systematically to ensure that the inputs and outputs to the shortest paths are always tested, is the best way to grow a control flow testing suite.

Control Flow Testing focuses on assessing the correctness of a program's control flow, which defines the sequence in which individual statements, functions, or blocks of code are executed. This technique aims to ensure that the program follows the intended logical pathways and handles various input scenarios effectively. Control Flow Testing helps identify issues related to decision-making, loops, branches, and the overall flow of execution within the application.
The primary objectives of Control Flow Testing include:

* Path Coverage: Control Flow Testing aims to cover different execution paths in the code. Each path represents a unique sequence of instructions or branches that the program can take. Achieving high path coverage helps increase the likelihood of finding defects in the code.
* Decision Coverage: This aspect of Control Flow Testing ensures that every possible decision point, such as if statements and switch cases, is tested with different possible conditions. It aims to verify that both the true and false branches of these decision points are executed and evaluated.
* Loop Coverage: Loop structures are prone to issues such as off-by-one errors and infinite loops. Control Flow Testing attempts to exercise loops with various loop conditions and boundary values to uncover potential defects.
* Statement Coverage: Statement coverage ensures that every individual statement in the code is executed at least once during testing. While it provides a basic level of coverage, it might not reveal more complex control flow issues.
* Branch Coverage: Branch coverage focuses on testing every branch or alternative path that can be taken at decision points. This helps identify issues related to missing branches or unexpected behavior.
* Multiple Condition Coverage: Involves testing all possible combinations of conditions within a decision point. This helps reveal interactions between conditions that might lead to unexpected behavior.

To perform Control Flow Testing, test cases are designed to target specific control flow elements, such as loops, conditionals, and function calls. Test inputs are chosen to exercise different execution paths, and the behavior of the program is observed to verify whether it matches the expected outcomes.

Scope:

* Control flow tests focus on testing the flow of execution through different parts of the code, including branches, loops, and decision points.
* The purpose of control flow testing is to ensure that the application follows the intended logical pathways and handles different execution scenarios appropriately.

Context:

* Control flow tests often require a broader context and interaction with various parts of the application, as they aim to test the entire path of execution through multiple units of code.

Granularity:

* Control flow tests are more coarse-grained compared to unit tests. They deal with the interactions between units of code rather than the specifics of each unit.

Coverage:

* Control flow tests aim to cover different execution paths, branches, and decision points within the codebase.
* The focus is on identifying issues related to decision-making, loops, and the overall flow of execution.


Modern Unit testing frameworks, and unit test implementations, will often include higher level tests that are used as a substitute for separate Control Flow Testing.

### Data Flow Testing

Data flow testing centers around the idea that a program moves data from point A to point B with the proper manipulations performed in between. Most data Flow testing is performed by static analysis, meaning that a compiler will catch errors related to undefined references, or unused definitions. Data Flow testing is designed to catch data flow anomalies, or flow of data that does not appear to serve any purpose. Once data is in an anomalous state, that data can no longer move back into a normal state. Typical anomalous state transitions include

* Defined → Defined
* Undefined → Referenced
* Defined → Undefined

These states are inherently useless, and should be eliminated when identified. The purpose of data flow testing is to highlight these 3 state changes, and to prevent their appearance. Although traditional Strong and Static typed languages are used to ensure data flow testing is performed at compile time, however, modern interpreters for dynamically typed languages, and even most weakly typed languages perform the same Data Flow Testing, which helps to eliminate anomalous state bugs. Data Flow Testing, colloquially referred to as Compiler errors, tests only that code will not have errors during execution - it **can not be used to test the validity of program logic**.

Scope:

* Data Flow Testing focuses on assessing the movement and transformation of data within a program or application.
* It aims to identify issues related to how data is used, assigned, and transferred throughout the codebase.

Context:

* Data Flow Testing requires a context that involves tracking the flow of data across different variables, functions, and components.
* It analyzes how data values change as they pass through various parts of the application.

Granularity:

* Data Flow Testing is often finer-grained than Control Flow Testing but coarser-grained than Unit Testing.
* It involves tracking the interactions between variables, statements, and expressions to ensure proper data manipulation and propagation.

Coverage:

* Coverage in Data Flow Testing refers to the paths and interactions of data within the application.
* The objective is to ensure that data is correctly processed, modified, and utilized at various points in the code.
* Types of data flow coverage criteria include:
    * All Definitions (DU): Ensures that all assignments (definitions) to a variable are covered by tests.
    * All Uses (UD): Ensures that all usages of a variable are covered by tests.
    * All Paths: Ensures that all possible paths that data can take are tested.

In Data Flow Testing, test cases are designed to follow the data as it flows through the application. This involves tracking how data is read from input sources, modified, and propagated to various parts of the code. The goal is to identify issues like uninitialized variables, redundant assignments, data inconsistencies, and data misuse.

### Domain Testing

Broken into 2 types of errors, programs can either produce a computational error (one where the input causes the program to execute the desired path, but the output value is incorrect) or a domain error (where the input causes the program to execute an undesired path). This can be viewed as the use of `verify` statements to determine which side-effects have occurred during the execution of a task based on the inputs to the system.

 A program is said to have a domain error if the program incorrectly performs input classification. The domain is the set of values which the program performs identical computations. Boundary points are the points where inputs change from one domain to another domain. These are important test cases for domain testing. Domain testing can test that the proper code paths are executed, or even that all appropriate code paths are accounted for, but **can not test that the results of the code path are the expected computational results.**

Scope:

* Domain Testing focuses on assessing the behavior of a software application within specific input domains or ranges.
* It aims to identify how the application handles different valid and invalid input values within those domains.

Context:

* Domain Testing requires defining the valid and invalid input values that are relevant to the application's functionality.
* It involves testing the application's behavior across various input domains to ensure that it responds correctly.

Granularity:

* Domain Testing is relatively coarse-grained compared to Unit Testing. It assesses the application's response to different input ranges rather than individual units of code.

Coverage:

* Coverage in Domain Testing refers to testing a representative set of values from various input domains to ensure that the application behaves as expected.
* It aims to cover different classes of inputs, including boundary values, typical values, and extreme values.

Domain Testing helps uncover issues related to input validation, range checking, boundary handling, and handling of exceptional cases. By testing different input values from relevant domains, you can improve the reliability and robustness of your application.

### Integration Testing

 Integration testing is the construction of multiple modules into a single system, and testing to ensure that the modules are stable across. Modules being assembled are often created by different groups of developers who work in parallel, and changes should be tested to ensure that all modules are communicating in the expected manner. Integration tests can be used to identify which modules are the most error-prone, and can help to ensure that unit tests remain isolated - since modules outside the unit can be effectively ignored, without eliminating their test coverage.

 Integration tests should be run in a way to assemble the modules gradually, testing the functionality of each module as it is added - while still mocking the changes from various other modules. An integration test has been completed once all the modules have been properly assembled, and all interaction paths have been tested. Integration tests can combine modules which are connected in 3 different ways, Procedural calling interfaces (one module calls another), Shared Memory Interfaces (one module writes to a database, and a second pulls the information out of the database), and Message Passing Interface (A cross service call where the data structure may undergo multiple changes when being sent across modules).

 Integration tests are designed to address the interface errors between various modules, and should be designed to eliminate errors in the combined interactions of 2 modules. Integration tests can either be built from the top-down or bottom-up approach, where the modules are repetitively tested, each time adding more “layers” to the dependency graph. This approach is ideal for testing a system and identifying where the errors originate in the communication protocol.

 An example of integration testing would be to call the activities, while excluding all lower level calls, and DAO/Coral calls, and then slowly integrate the Lower level calls and DAO calls while mocking the Coral calls, testing the Procedural calling interfaces, and then Shared Memory Interfaces. The Coral calls could then be integrated, to test the Message Passing Interface. These tests should be integrated into the pipelines, but notable are not testing the functionality - only that the individual modules are “Performing the expected behaviors”.

 Integration tests should exist on the package/service level, but should be testing all the dependency integrations. This does not mean that the functionality of the integration should be working - only that the integration itself is not causing any failures. Integration testing should be performed in a Gamma environment to ensure that the tests are verifying the integrations as closely as possible to Prod (without affecting prod data, or passing new functionality to prod pre-maturely).

Scope:

* Integration Testing focuses on testing the interactions and collaborations between different components, modules, or subsystems within a software application.
* It aims to identify issues that arise when multiple parts of the application work together.

Context:

* Integration Testing requires a context that involves combining and testing the interactions between various components or units of code.
* It focuses on the interfaces, communication channels, and data exchanges between different parts of the application.

Granularity:

* Integration testing is coarser-grained than Unit Testing. It involves testing the interactions between multiple units or components rather than individual units of code.

Coverage:

* Coverage in Integration Testing refers to testing various scenarios in which components interact.
* It aims to ensure that data, control flow, and communication between components work as expected.

Integration Testing helps identify issues related to interface mismatches, communication problems, data sharing, and synchronization between components. By ensuring that different parts of the application work together seamlessly, Integration Testing contributes to the overall stability and reliability of the software.

### Smoke Testing

Smoke testing is the process of validating code changes before the changes are checked into the product’s source tree. The purpose of smoke testing is not to ensure that the system is 100% error free. The Goal of smoke tests is only to validate the most critical functionality of a system, and ensure that the system is still working at a high level. Smoke tests are meant to be short, light tests, often used to validate that system configuration is configured correctly.

 Smoke tests should be run as part of the build, before merging the code into mainline. These tests can be used as an indicator towards the Functional Test health in a system, and should exist as a subset to the Functional Test standard. Smoke Testing can be thought of as KTLO testing, ensuring that a minimal amount of critical functionality is still available and working. Where Functional Tests can be overridden for a hot-fix or mission-critical change, smoke tests should never be broken.

Since Smoke tests are a subset of functional tests which are run during the build process, they are often repeated during the functional test cycle. Smoke test need to be able to run “Environment free” in the same way that unit tests run. Although smoke tests will run from through the entire call-stack, they will not be expected to make external calls, or persistence layer calls. Only a few smoke tests should be implemented and maintained on a system - testing only the most critical functionality.

Scope:

* Smoke Testing, also known as Build Verification Testing or Sanity Testing, is a preliminary test that aims to determine whether a software build or release is stable enough for further testing.
* It focuses on quickly identifying major issues that could prevent the application from functioning at a basic level.

Context:

* Smoke Testing is performed after a new build or version of the software is compiled or deployed. It is meant to provide a quick assessment of the build's overall health.
* This testing is not in-depth; it's intended to give a "smoke signal" about the build's basic functionality.

Granularity:

* Smoke Testing is relatively coarse-grained. It typically involves testing broad, high-level functionalities of the application rather than specific components or units of code.

Coverage:

* Coverage in Smoke Testing refers to covering the most critical and commonly used functionalities of the application.
* It aims to identify showstopper issues that would make further testing or deployment unfeasible.

In Smoke Testing, a set of basic test cases is executed to ensure that the application can start, launch, and exhibit primary functionalities without major errors. It is not an exhaustive or comprehensive test; rather, it's a quick check to catch glaring issues before proceeding with more detailed testing.

### Canary Testing

Canary testing and Smoke testing will often cover the same KTLO functionality, and may even be the same tests - however, the purpose and environment are different. Where Smoke tests may be run in the build, or in the beta environment, Canary tests should be run against One-Box or another A/B testing environment. Much like a Canary in the Coal Mines - Canary testing is designed to provide a pre-alert system to any issues which require immediate action. If the Canary tests fail, then a One-box build should be immediately rolled back. Some teams may choose to run Canary tests regularly (daily, hourly, nightly) to trigger any issues which may arise due to system integrations, or other non-code related changes. This is a great practice, and is highly recommended.

Scope:

* Canary Testing is a deployment and testing strategy used to gradually introduce a new version of software or code to a subset of users or systems before releasing it to the entire user base.
* It focuses on ensuring that the new version behaves as expected and doesn't introduce critical issues before it's rolled out to a wider audience.

Context:

* Canary Testing is performed in a production or production-like environment, but only a small percentage of users or systems are exposed to the new version initially.
* This technique is often used to mitigate risks associated with deploying new code changes that could potentially impact user experience.

Granularity:

* Canary Testing is at the higher end of granularity, as it involves deploying and testing an entire version or feature set of the software.
* It's not focused on individual units of code but rather on the overall behavior of the application.

Coverage:

* Coverage in Canary Testing refers to the proportion of users or systems that are exposed to the new version.
* It aims to identify any issues that might emerge when the new version is introduced to a small subset of the user base.

Canary Testing is an effective way to reduce the risk of widespread issues caused by new releases. It helps ensure a smoother transition and improved quality when introducing changes to a live system. Although Canary tests and Smoke tests may cover the same functionality, and even share common testing logic, the primary difference is the runtime environment. Where smoke tests should run as part of a build, or standard pipeline without further integration, Canary tests are integrated into the Production environment with all integrations and persistence layers un-mocked.


### Functional Tests

Functional tests differ from unit tests as they require joint ownership by both the customer and the developer. The customer defines test functionality, allowing them to create and understand tests, even if developers implement them. Functional tests outline business processes and are written and executed from a business user's perspective.

Functional tests are a type of software testing that validates the behavior and functionality of a software application by testing it against the specified business requirements. These tests focus on ensuring that the application's features and functionalities perform as intended, meeting the needs of both end-users and stakeholders. Functional tests simulate real-world scenarios and user interactions to verify that the application operates correctly and produces the expected outputs.

In functional testing, the application is tested as a whole, and the emphasis is on evaluating its functional aspects, such as user interfaces, data processing, calculations, workflows, and integrations. These tests are typically written and executed from the perspective of a business user, ensuring that the application aligns with the user's expectations and follows the defined business processes.

Functional tests help detect defects, inconsistencies, and deviations from the expected behavior, allowing for timely identification and resolution of issues before the software is released to users. These tests contribute to the overall reliability, quality, and user satisfaction of the software by validating its functional correctness and adherence to the specified business requirements.

Scope:

* Functional tests focus on testing the interactions and behavior of multiple components or services within a system. They aim to validate the system's adherence to business processes.

Context:

* Functional tests are essential in a continuous integration and delivery environment, helping to ensure that changes do not disrupt the overall system functionality. They are executed automatically as part of the pipeline, reducing manual testing efforts.

Granularity:

* Functional tests operate at a higher level than unit tests. They verify interactions between components and services, as well as the flow of data and operations within a business process.

Coverage:

* Functional tests cover end-to-end scenarios that represent actual business processes. They aim to identify any issues arising from the interactions between different parts of the system.

Functional tests serve multiple purposes. They identify inter-module dependencies and issues within a system. They also replace manual testing, streamlining the release cycle and enhancing testing efficiency. By involving the customer, these tests help refine business requirements and contribute to a living requirements document.

Business requirements are the foundation upon which functional tests are built. Each business requirement translates into a corresponding functional test that validates whether the software meets that requirement. Here's how business requirements can be equated to their use in functional tests:

1. Business Requirement:

* Example: "Users should be able to create an account on the platform."

Corresponding Functional Test:

* Test Name: "User Registration"
* Test Functionality: Verify that users can successfully create an account by providing valid information. Check for appropriate validation messages for invalid data.

2. Business Requirement:

* Example: "Customers should be able to add products to their shopping cart."

Corresponding Functional Test:

* Test Name: "Add to Cart"
* Test Functionality: Validate that customers can add products to their shopping cart. Check that the cart updates correctly and reflects the added items.

3. Business Requirement:

* Example: "The system should calculate shipping costs based on the user's location and selected shipping method."

Corresponding Functional Test:

* Test Name: "Shipping Calculation"
* Test Functionality: Test the accuracy of shipping cost calculations based on different user locations and selected shipping options.

4. Business Requirement:

* Example: "Admin users should have the ability to approve or reject submitted content."

Corresponding Functional Test:

* Test Name: "Content Approval Workflow"
* Test Functionality: Verify that admin users can approve or reject submitted content items. Check if the system correctly handles both approval and rejection scenarios.

5. Business Requirement:

* Example: "Customers should be able to view their order history and track the status of their orders."

Corresponding Functional Test:

* Test Name: "Order History and Tracking"
* Test Functionality: Confirm that customers can access their order history and accurately track the status of their orders.

In each case, a business requirement is translated into a functional test that specifically checks the expected behavior of the software in relation to that requirement. These functional tests collectively ensure that the software system meets the defined business needs and provides the intended functionality to users.

Functional tests create a framework for the business to define logic, leading to more precise and consistent requirements. They serve as a living document, ensuring that requirements remain up-to-date and comprehensive. Ultimately, functional tests help maintain the stability and reliability of a software system by validating its behavior from a business perspective.

## **Solution**

### How do you functional test

Functional tests should be run as part of the CI/CD cycle, and should be designed so that they can be distributed across multiple runners. Functional tests should always run against a Pre-production environment, so that they do not affect production data. Despite popular belief, functional tests should clean up their data after running. This may mean dropping the entire database, and creating a new database for the functional tests to run against - or it may mean removing all records created by the functional test suite. Unlike unit tests, the “clean-up” or “break-down” should not be done during the test cycle, as data should be able to interact as it would in a production environment - however, data should be fully removed before running the next set of functional tests.


>[Bias for Action](https://w.amazon.com/bin/view/LeadershipPrinciples/BiasForAction): Speed matters in business. Many decisions and actions are reversible and do not need extensive study. We value calculated risk taking.


The most important aspect of functional tests is not the testing, but the communication layer with business partners. Functional tests should be visible to business partners, and designed with collaboration with business partners. Although the implementation details should continue to be left in developer hands - the definitions and audits of functional tests should be done together with the customer. In this way, Functional tests are the ultimate tribute to Customer Obsession.

 For most systems, it is best to start with a fresh database (one that does not have existing records) and to run functional tests against this database. It may be relevant to create some mock records, which are relevant to the testing scenario. Additionally, to exert control, mocking external dependencies is a particularly useful way to ensure data independence. Some tests may benefit from interfacing with external systems that are high risk - but in most cases this will lead to unpredictable breakage in the functional testing environment.

 Some teams find it useful to have a dedicated Functional Test Enforcer (or Bar Raiser) who monitors functional test execution, and ensures that developers are compliant with functional tests. It is important to maintain confidence in the functional tests; otherwise, they will be continually ignored, deprioritized, or overwritten. This will lead to situations where functional tests are harder to maintain and fix when they are broken.

 Functional tests should be grouped by their business partners, or customer cohorts. This will help to ensure that the representative from that customer group can monitor the functional tests designed specifically to cover their use cases, and not need to worry about other business teams. This will also ensure that developers can run only a sub-set of the functional tests as part of their development cycle, leading to a faster code/check cycle in development.

 Functional tests should always be defined using a Black Box Technique. The code or system being tested should not be accessed directly, since the implementation details are not relevant. The only thing being tested by a functional test should be the Input/Output of the system.

 Functional tests should be defined before the implementation of a feature - but not necessarily written beforehand. This allows users to mark tests as implemented or passing during the development cycle. This gives greater visibility to the progress of an applications’ development.

 Using Metrics along the execution path, and coordinating those metrics with the functional test definitions, could be a useful way to determine how often a given path is executed. This may be useful for determining priority in the future, or determining if a process is being utilized as expected from a business perspective.

### Evaluating Functional Tests

 To help provide metrics around the functional test environment, it may be useful to include specific metrics. These metrics can be used to justify testing, but also determine testing effectiveness.

 The first is *Test Case Effectiveness,* which measures the number of defects found during the Continuous Integration cycle. Although fewer bugs are always considered the best-case scenario - a high Test Case Effectiveness is not an indicator of poor code, only an indicator of good tests.

 The second is *Test Effort Effectiveness,* Which measures the number of defects which are discovered by customers or in production - which would indicate that they were not caught by Functional Tests. A good metric result for Test Effort Effectiveness can be a good indicator that the system will not have unexpected error cases.


>[Are Right, A Lot](https://w.amazon.com/bin/view/LeadershipPrinciples/AreRightALot): Leaders are right a lot. They have strong judgment and good instincts. They seek diverse perspectives and work to disconfirm their beliefs.


 The concept of completed testing is nearly impossible. A complete test is a test where all possible problems are identified at the end of the testing cycle. For most programs, this is impossible because the domain of possible inputs is too large, or the design is too complex to test all possible states and state changes.

 Testing at various levels covers different topics:

* Unit tests are meant to test the code
* Integration tests are designed to test the Design
* System tests are meant to test the architecture
    * Functional Tests
    * Security Testing
    * Robustness Testing
    * Load Testing
    * Stability Testing
    * Stress Testing
    * Performance Testing
    * Reliability Testing
* And Acceptance Tests are meant to test the Requirements
    * Primarily performed by the customer
    * Tests the Quality of the product, looking for non-specified requirements
    * Tests Customer expectations


 Regression or smoke testing are not a specific level of testing, but the introduction of tests designed to validate previously validated faults in the system.


>[Dive Deep](https://w.amazon.com/bin/view/LeadershipPrinciples/DiveDeep): Leaders operate at all levels, stay connected to the details, audit frequently, and are skeptical when metrics and anecdote differ. No task is beneath them.


 Formal description Techniques can be used to define the requirements, and are represented as diagrams. Several FDTs exist, including Estelle, Lotos, SDL, and Z. These FDTs are often useful for the description of requirements, but difficult to create as they require a high level of precision that cannot be expected from most business partners or customers.

### Functional BRD

Functional tests are focused on testing the requirements of the system, as defined by the requirements specification documents (BRD). Tests are designed to verify the individual functionalities of the system, and not the System as a whole. A functional BRD serves several purposes for both the development team and the Business Users.

1. The identification of functions that the software is expected to perform
    1. This can be found in the Requirements and Functional Specifications document provided by the business (BRD)
    2. Source Code which defines the actual behavior of the system, and skews the expected results based on the confirmation bias of the program
    3. Input and Outputs of the domain, which may overlook the edge cases
    4. Operational Profile, which is defined from the characterization of how the system is used - it is created based on usage profiles.
    5. Fault Model, which tests based on previously encountered system faults. This requires tracking all faults, and is primarily used for regression testing of the system, to ensure that faults are not re-introduced
2. The creation of input data based on the function's specifications
3. The determination of output based on the function's specifications
4. The execution of the test case
5. The comparison of actual and expected outputs
6. To check whether the application works as per the customer's need.


 Functional tests can best be defined as the expected input vector, and output values of an entire system. Functional tests are best performed by creating unique matrixes of inputs, and determining what the expected output matrix of the system should be based on the inputs. All functional tests should live within their own isolated environment - so that functional tests are not dependent on existing data (or previous functional test runs) within the system.

 Since the input domain is expected to be too large for all the elements to be used as a test input, and designing a test which generates/specifies all possible input/outputs would be time-consuming beyond what is reasonable - a different method must be used to define the functional test set. To achieve this, we create equivalency groups - where different input sets are expected to have the same output of the system. An example of this, is if it is expected that every ASIN will be treated the same, regardless of the ASIN value - there is no need to functionally test each individual ASIN, and this can be a single equivalency factor.


>[Frugality:](https://w.amazon.com/bin/view/LeadershipPrinciples/Frugality)Accomplish more with less. Constraints breed resourcefulness, self-sufficiency, and invention. There are no extra points for growing headcount, budget size, or fixed expense.


 You can identify the Equivalency classes by breaking the system's expected functionality into increasingly smaller partitions, and identifying a single expected input/output for each of the partitions. Input conditions can either specify a range, a set of values, or an individual value. For each test, if a range/set is being input - then the Functional Test can programmatically generate the input for that specific test run.

 Of course, the negative condition must also be tested - that given a partition of inputs, the output is not the expected output if the inputs are outside the partition. In each iteration of test design, if the equivalency classes are treated in 2 different ways by the system, then that equivalency class should be split into 2 groups.

 For each equivalency class, a number should be assigned to that equivalency class. A valid test case which covers as many possible equivalency classes which are not covered should be written. A new test case should then be written which covers exactly 1 of the uncovered invalid input/output combinations for the equivalency class.

 An Extension of this, is to use the equivalency class Boundaries as an additional equivalency class. For each of the possible equivalency class Boundaries, consider this to be an additional equivalency class that needs to be tested in the same way.

 A statistical Analysis of defects in programming systems found that 23.9% of defects reported came from requirements issues, and 24.3% came from functionality. **This means that 48% of errors in any system stem from misunderstanding, or poor implementation of customer requirements.** These errors should be targeted by the Functional tests, and should be well-defined in collaboration with business users to ensure that these errors are eliminated as early in the process as possible. In contrast, only 5.2% of errors stem from system integrations - primarily because these integrations are often the easiest failures for developers to identify early in the development cycle.

 Out of the above analysis, from the 48% of functionality errors, 19% were found to be from missing requirements, missing requirement constraints, or problematic requirements, while 27% stemmed from requirements which changed during the development lifecycle and were not properly updated in all parts of the system. Given a problematic, or conflicting requirement, a functional test document gives a point-driven analysis of what conflicts will be caused.


>[Have Backbone; Disagree and Commit](https://w.amazon.com/bin/view/LeadershipPrinciples/HaveBackboneDisagreeAndCommit): Leaders are obligated to respectfully challenge decisions when they disagree, even when doing so is uncomfortable or exhausting. Leaders have conviction and are tenacious. They do not compromise for the sake of social cohesion. Once a decision is determined, they commit wholly.


For this reason, the existence of a requirements document, with unambiguous definitions for communication, is essential to proper software development. All stakeholders should have access to this requirements document so that they are all given the same interpretation of the requirements. An example list of fields for a requirements document can be found below:

* Requirement ID
* Title
* Description
* Current State (done, implementation review, etc)
* Product/Project Name
* Requester
* Notes
* Need by Date
* Priority
* Severity
* Justification
* BRD ID
* is KTLO
* **Committed Completion Date**
* **Engineering Notes**
* **Estimated time to Implement**
* **Engineer Assigned**
* **Functional Spec Title**
* **Functional Test ID**
* **Functional Test Result**
* **Functional Spec Version**
* **Repo Name**
* **SHAs**
* **Testing Note**
* **Defect ID**

*The bold fields represent fields which are documented by developers*

### Functional Test Failures

If a functional test is failing, then the following approach should be taken to remedy the situation as quickly as possible. This assumes that functional tests start from a point of success and business validation.

1. If the Functional Test scenario is still a supported Business Use Case - Fix broken code
2. If the Functional Test scenario is intentionally modified
    1. Get business sign off on the updates
    2. Update Functional Test Document
    3. Update Functional Tests to pass
3. If the Functional Test is checking an invalid data field (day of month), remove the broken assertion
4. If Functional Test scenario is intentionally removed
    1. Get business sign off on the updates
    2. Update Functional Test Document
    3. Remove Functional Tests which are no longer valid

A new Functional Test should be added when a new Functional Test document / BRD item is created or required.


>[Earn Trust](https://w.amazon.com/bin/view/LeadershipPrinciples/EarnTrust): Leaders listen attentively, speak candidly, and treat others respectfully. They are vocally self-critical, even when doing so is awkward or embarrassing. Leaders do not believe their or their team’s body odor smells of perfume. They benchmark themselves and their teams against the best.


Ensuring that Functional Testing is considered a priority shows stake-holders, customers, and business partners that their input is not only valued, but guaranteed. By giving visibility into which Functional Test scenarios are not working, information about system errors is not opaque, and immediate action can be taken.

### Test Effort Estimation

Tests should be part of the initial story, so that they are not deprioritized. A subtask can be used, and estimated separately if required. If necessary, a new sprint lane can be added to account for tests, but a story should not be considered complete until the Unit, Integration, and Functional Tests have all been created/updated, and the Functional BRD has been appropriately filled out.


>[Ownership](https://w.amazon.com/bin/view/LeadershipPrinciples/Ownership): Leaders are owners. They think long term and don’t sacrifice long-term value for short-term results. They act on behalf of the entire company, beyond just their own team. They never say “that’s not my job.”


If the functional tests are failing due to a change, then developers should take ownership of their change and identify what caused the failure. They should re-visit the steps towards what action needs to be taken when there is a functional test change, and complete those actions. A story is not completed if the functional tests are not passing to the same standards, or better, than they were when the previous code change was deployed.

### Agnostic Functional Test

Functional tests should be agnostic of the system below, as are the customers who consume it. This is particularly possible when utilizing Content-Based Routing Mocks, since there is no need to mock internal portions of the code base. Traditional Functional Test frameworks are written to run tests using HTTP protocols to connect to services, ensuring that connections are made in the same way as clients are expected to connect.

Within the Amazon ecosystem, very few applications are expected to handle direct HTTP connects, and instead are focused on the use of Coral connections. This being the case, it should not matter to the functional testing suite if the tests are run on MAWS, AWS, or Azure, simply that they are reachable through the expected protocol. As the underlying technologies are updated and changed to best benefit the development and operational excellence standards of our team, the functional tests should remain unchanged, and passing. Although some additional configuration may be required in the functional tests, the individual tests should not be predicated on the underlying technology stack to pass.

## Testing Tool at Amazon

### Mocking and Chameleon

Mocking is an important part of unit tests, and can generally be accomplished through Mockito, or another language level mocking library. These solutions work very well for unit test mocking, and are specifically designed to perform well under unit testing conditions. The integration of verifications, matchers, and (in most mocking libraries) assertions, are the cornerstone of good unit test development and isolation.

 Service level mocking needs to take a slightly different approach, since mocks in Functional Tests should not be taking the same approach as mocks in the Unit tests. Where a unit test library will replace the function calls, and function returns directly - functional tests should still make network level calls to external services, and system layers, but may need to mock the responses due to a poor test/dev environment. This content-based routing mechanism is a common mocking technique with UI and Functional Test design, to ensure that the systems integrations and functionality is still tested, without requiring all dependencies to exist in a test environment.

 Mocking should be used as sparingly as possible in the Functional test system, and should never be used to mock services owned by the development team. If a system can be replicated in a development environment reliably, then mocking should not be utilized in a functional test suite. A base assumption should be made that the test or development environment can provide all production functionality (without affecting production data), and should be called directly. When this assumption is disproven by a problematic service (e.g. AFT), then mocking through a Content-Based Router is the next best solution.

 Chameleon works within the Amazon Ecosystem to become a Content-Based Routing Mocking (CBR) framework which is compatible with Coral, AWS, and Java Interface calls. This makes it the perfect solution for working with Functional Test Mocks at Amazon. Like many CBR Mocking frameworks, chameleon will intercept all Functional Test requests, and fallback to calling the original system if a mock is not found. These request and response calls are stored outside the service code, and outside the individual Functional Test system. Setting up Chameleon mocks follows a familiar format to Mockito, and should not pose a significant developer learning curve.

 Chameleon is hosted on it’s own MAWS instance, and requires no additional setup for mocking MAWS service calls. For mocking NAWS service calls, or calling from NAWS, some additional component set-up is required.

### Test Environments and Hydra

Traditional test environments require set-up of infrastructure, maintenance of infrastructure, and can often become out of sync with production environments. Hydra focuses on eliminating this by moving to a server-less infrastructure for running functional tests. Using CloudFormation and CDK tools, Hydra can be configured to create and manage the AWS persistence layer resources need to test your deployed code.

 Using RDE with Hydra can improve the build tools available locally for development, enabling tests to run locally without the need to push through the pipeline. Hydra can be set up using LPT pipelines, which means that the entire infrastructure is managed in code.

### Pipelines at Amazon

 The recommended way to run tests in the Amazon infrastructure is to use Test on Demand to run tests before deploying to an environment, and blocking tests against the ToD approval step. Each step of the process should test individual items, without repeats. If an earlier stage tested something, it most likely does not need to be retested. Much like an expanded integration test system, pipelines should build the layers of a test outward. The recommended methodology is to build tests as

With the addition of a recommended Gamma environment, which creates a faithful representation of the Production Environment, the pipeline changes only slightly. The change consists of moving System tests to the Gamma stage (to ensure that they are as close to the production environment as possible) and moving the Code Review Verification to Beta→ Gamma Promotion. This is done to allow developers to experiment more freely in the Beta Environment, without risk of pushing un-validated code to Beta/Gamma. Developers may need to push code to Beta before they can manually validate that it works. This is common for build issues, or unreproducible bugs.

Additional Steps may be required in either setup, but are customizable to the individual environment. Integration Tests, and Functional Tests can be run using either Test On Demand (ToD), or Hydra, depending on the requirements of the system. Hydra is preferred for services moving forward, as Test On Demand has no planned support for Native AWS. Hydra can also run tests against Lambda functions, and MAWS services, so there is no need to use ToD workers for further development. Although ToD is not planned to be deprecated, there is no longer feature improvement planned, and resources have been moved to Hydra Feature development.

 Pipelines should be used to deploy both AWS and MAWS resources. Pipelines can be used in conjunction with CloudFormation or CDK, for deploying AWS resources. An ideal pipeline is configured completely through CDK, LPT, and CloudFormation, so that there are no unpredictable changes to the pipelines. Using a version-able file set for pipeline development can ensure that the environment is not compromised, and can be easily reproduced.

## Conclusion

At Amazon, we insist on the highest standards to deliver the best results to our customers. Testing is not the exception to this rule, but should be the data-driven valuation of the rule. Tests are broken into various domains, to provide numerous layers of checks and balances that grow the verification process, cementing our insurance at each stage. As we move through the testing pipeline, we should move away from developer oriented checks, and into customer oriented checks. This means that each of our test suites should grow on the previous, without being repetitive of the previous test suites.

There is no single solution to testing, and there are many approaches to testing software solutions. Each test phase does not invalidate the usefulness of another test phase, but instead re-enforces the results of the previous test phase by expanding the domain of the tests. Functional tests, when performed properly, can help any team embody the true nature of the Amazon Leadership Principles.

Good Functional Testing is

* [Customer Obsession](https://w.amazon.com/bin/view/LeadershipPrinciples/CustomerObsession)
    * Functional Tests should obsess over ensuring that the customer’s needs are met
* [Ownership](https://w.amazon.com/bin/view/LeadershipPrinciples/Ownership)
    * Functional Tests should always be part of the implementation, showing the developers own a change from start to finish, and don’t sacrifice long-term value for short-term results.
* [Are Right, A Lot](https://w.amazon.com/bin/view/LeadershipPrinciples/AreRightALot)
    * Functional Tests should work to support or reject the beliefs that we have on system operation. A passing functional test suite should give confidence that the team has properly implemented the business requirements.
* [Insist on the Highest Standards](https://w.amazon.com/bin/view/LeadershipPrinciples/InsistOnTheHighestStandards)
    * Functional Tests are the highest standard we can insist on, they ensure that our system is working at the highest level that we can guarantee.
* [Bias for Action](https://w.amazon.com/bin/view/LeadershipPrinciples/BiasForAction)
    * Functional Tests help to ensure that we are able to push changes quickly, and with confidence. Even if many changes require updates to functional tests before they are production ready - any change that is pushed to production will have been verified on a multi-step process.
* [Frugality](https://w.amazon.com/bin/view/LeadershipPrinciples/Frugality)
    * Functional Tests are a balancing act of learning to reduce the number of tests, while ensuring that all test scenarios are met. This exercise in frugality will be carried across all our operations.
* [Earn Trust](https://w.amazon.com/bin/view/LeadershipPrinciples/EarnTrust)
    * Functional Tests have high visibility to the business, and stake-holders. We do not need to earn trust if we have a mechanism to ensure it. When stake-holders can see that we consistently account for their needs and requirements, they will trust that we extend that to every error of development.
* [Dive Deep](https://w.amazon.com/bin/view/LeadershipPrinciples/DiveDeep)
    * Functional Tests alone are not a deep dive, but they are a step on the diving ladder which ensures that all portions of the code base, and all aspects of the code are explored.
* [Have Backbone; Disagree and Commit](https://w.amazon.com/bin/view/LeadershipPrinciples/HaveBackboneDisagreeAndCommit)
    * Functional Test documents given developers and development managers a platform to argue against conflicting and problematic requirements. With long running software, changes may have unknown adverse effects, and Functional Testing documents can help to ensure that these effects are caught and raised to the business, before they are presented to the customer.
* [Deliver Results](https://w.amazon.com/bin/view/LeadershipPrinciples/DeliverResults)
    * Functional Tests ensure that results are delivered correctly, and with the minimal amount of backlash to the system. By including Business Users in the Functional Testing process, it is a guarantee that the results the business expects to see, are delivered the way that they expect them.

Good functional testing is the best way to embrace the best practices around the leadership principles. Functional tests extend beyond just a checkbox on the story or change request. They represent the core identity of the Amazon principles.

### Proposed Next Steps

The next steps for ensuring that functional tests in the Amazon Devices organization are up to the standard that Amazon strives to meet are:


1. Reconfigure Pipelines to run tests and checks at all the appropriate stages
    1. Pipelines should use LPT/CDK to ensure that pipelines are editable and reproducible
2. Collect requirements and configure a Functional Test Document to share, review, and maintain with our business partners
    1. This will require business buy-in of the concept, and business understanding of the changed process
3. Redefine existing Functional Tests as Integration Tests, and re-write Integration Tests to progressively build out the layers of the system - ensuring proper integration at each layer
4. Start implementing the Functional Test Document as agreed on by the business

With these steps, we can move forward as a company, and work towards a future where our customers are the focus of our development cycle.


>“There are two ways to extend a business. Take inventory of what you're good at and extend out from your skills. Or determine what your customers need and work backward, even if it requires learning new skills” - Jeff Bezos



The best way to ensure operational excellence is to focus on functional testing. This change will help every aspect of the business and development cycle. Now is the time to allocate resources towards good Functional Testing practices.

## References

https://ecs.syr.edu/faculty/fawcett/Handouts/CSE776/PatternPDFs/functionaltesting.pdf
https://w.amazon.com/bin/viewrev/HydraTestPlatform/
https://www.softwaretestinggenius.com/download/staqtpsn.pdf
https://www.researchgate.net/publication/235430372_Confirmation_Bias_in_Software_Development_and_Testing_An_Analysis_of_the_Effects_of_Company_Size_Experience_and_Reasoning_Skills
https://docs.microsoft.com/en-us/previous-versions/ms182613(v=vs.80)?redirectedfrom=MSDN
https://www.drdobbs.com/tools/change-code-without-fear/206105233
https://www.simform.com/functional-testing-types/
https://www.guru99.com/functional-testing.html
https://w.amazon.com/bin/view/Testing/
https://w.amazon.com/bin/view/DeveloperToolsMatrix/AllTestingandAnalysisTools
https://w.amazon.com/bin/view/Testing/Why
https://w.amazon.com/bin/view/Hellfighters
https://w.amazon.com/index.php/Chameleon_Mocking_Service
https://w.amazon.com/bin/view/RDE/Tutorial/Hydra/
https://w.amazon.com/bin/view/ProjectHydra/
https://w.amazon.com/?Pipelines/ApprovalWorkflows
https://w.amazon.com/bin/view/ToD
https://w.amazon.com/index.php/Pipelines/CodeDeploy/FAQ
https://builderhub.corp.amazon.com/docs/native-aws/developer-guide/hello-world-lambda-add-stage.html
https://w.amazon.com/bin/view/Create_CrossAccount_Pipeline_using_CloudFormation/
https://w.amazon.com/bin/view/AutoPilot/Efficiency/Projects/AutomaticStressTest/
https://w.amazon.com/bin/view/DuckHawk/
https://docs.aws.amazon.com/codebuild/latest/userguide/welcome.html
https://w.amazon.com/bin/view/RDE/
http://www.cs.stir.ac.uk/~kjt/using-fdts/using-fdts.pdf


>“For Our Purposes, I define "reading" as looking at printed words and getting enough meaning from them to satisfy your purpose.”
― **Peter Kump**

* * *
*--wiki-sync: "*[*Users/ailor/FunctionalTesting*](https://w.amazon.com/bin/view/Users/ailor/FunctionalTesting)*"--*


