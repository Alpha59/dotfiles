# Musings on OE

The propose of this document is to discuss the work stream to tackle “Operational Excellence” in the Reverse Logistics Systems. Before I dive too deep into the problem, and possible solutions, I think it is important to define “Operational Excellence” since it means something different to everyone. The OE scorecard which is used to give an idea how a team is doing operationally tracks items such has ticket count, blocked pipelines, and overdue COE action items. For the propose of this document, I’d like to define Operational Excellence simply as “A highly available and valuable system in which issues are exposed without customer contacts. Issues can be resolved quickly, and every code commit is in production within hours.”

This definition ties in very closely with the OE scorecard, and driving towards this standard will naturally improve our OE Scorecard.

The remainder of this document will dive into areas I believe where the reverse logistics systems is failing short, and what we can do to fix it. As a team we can decide which areas we believe will give us the most benefit and start there. I do not suspect we will have time to finish all items in this document, but I am confident we can still make a major impact.

## Metrics & Alarms

>***“A highly available system in which issues are exposed without customer contacts**. Issues can be resolved quickly, and every code commit is in production within hours”*


We can not know if our system is “highly available” or find out about issues before a customer reaches out to us without metrics and alarms. Metrics will help us determine the health of system, and the alarming to expose issues.

### **GOAL:** I want to be able to see the current health of our system at a glance.

Currently we have metrics around all our services and have created dashboards in wiki. The areas of improvement here is to move existing dashboards to the new wiki with our latest templates. We also need to verify all the APIs are properly emitting metrics, and are showing on the dashboard. I would like to create a consolidated page to understand the general health of the system as a whole. This consolidated page could be used to show information such as “is-it-down”, and help determine the uptime of the system to be able to answer “What was our uptime year to date?”. As a stretch goal, we should have banners on our website to alert customers of ongoing issues, reduced capacity, etc.

The system being up and running is one thing; but what customer is actually happy with a slow system. Part of system is health is monitoring and tracking latency. This is really easy for our coral APIs, and even the API Gateway calls, but this is not necessarily the latency our customer is seeing. We need to have a way to monitor, and alarm, on the latency as seen from the end customer. Unfortunately these metrics are some of the hardest to find, so further investigation on *how* to capture these metrics is needed. Once captured, we can create dashboards, and monitors rather easily

**TASKS**

- [ ] Capture metrics around latencies and errors the customer is actually seeing.
- [ ] Validate all services/apis have proper graphs for all apis while migrating existing dashboards to new wiki.
- [ ] Investigate a consolidated dashboard represent health of RL Systems as a whole (cross service)
- [ ] Investigate adding data/metrics to consolidated dashboard to answer common availability questions.
- [ ] Add banners to websites to alert customers of on-going issues.

### **GOAL:** I want to know about an issue before a customer has to contact us.

This is one area our team can really move the needle and see major improvements. Right now, we actively ignore auto-cut tickets. Ideally auto-cut tickets would be as important as any customer cut ticket because it is our system alerting us to an issue a customer is facing but isn’t reporting. Our major issue right now getting to that point is separating the real issues from the noise. In order for us to make auto-cuts as high of a priority as customer tickets, we need to eliminate the noise (and thus lower our ticket count).

The best way to eliminate extra tickets is to root cause the issue and actually fix it. Therefore I propose for some amount of time we dedicate a resource to dive deep on auto-cut tickets, root cause, and address the issue. While root causing the issue we may determine that this ticket was in fact a false alarm. Eliminating false alarms, besides from lowering ticket count, has the added benefit of saving developer’s time in investigating.

**TAKS**

- [ ] Additional on-call to root cause existing issues. (To stop them from happening again)

### **GOAL:** I want to know we are alarming on the right thing.

The vast majority of auto-cuts from our system are High Fault Count and High Latency. One way to eliminate High Fault Count false alarms is to ensure we are faulting on actual faults. For example, we should not fault if the user inputed a username in the DSN field. To solve this, we need to do a deep dive on our services and the exceptions they throw. We need to be particularly mindful Dependency Exceptions.

We should fault on a Dependency Exception if the Dependency is a third party, but we should not fault if the Dependency is our own system. We want to be sure that any third party errors that are causing issues for our customers are brought to our attention because we cannot be confident our dependencies are alarming correctly for our use case. But we can be sure our own services are alarming correctly.

For example, a call from OLP, will typically go through a sequence such as OLP → DRPI → DRBS → KROBS → AFT. Let’s go through two examples

1. AFT Fails:
    KROBS should log a Fault, and should bubble up an exception. That exception should not be logged as a fault in either DRBS or DRPI. If the exception were logged as a fault in DRBS and DRPI, we’d then potentially have a 3 open tickets for the same issue, and waste developer time investigating.
2. KROBS Fails:
    KROBS should log a Fault, DRBS and DRPI would see a Dependency exception but not Fault. Again, if these services would fault as well we’d see additional tickets.

To implement this is rather simple, we define DependencyException as an error instead of a fault, then the source of the error should throw a Fault (such as a ServiceException). In this example, in both cases KROBS would throw a Fault (likely a Service Exception). The only difference between the two cases then would be when KROBS catches an exception from AFT, it does some sort of logging, then instead of throwing a DependencyException, we through a ServiceException.

Another option is we model DependencyException as an error, and then define a new to be named Dependency Exception which is a fault. In the case where AFT fails, KROBS would throw the faulting dependency exception, which then gets translated to the non-faulting dependency exception on the way back up. In the case where KROBS fails, it would throw a service exception which would then be translated into a non-faulting Dependency exception on the way up.

**TASKS**

- [ ] Dive Deep into the exceptions our services are throwing.
- [ ] Ensure we are throwing the correct http status code.
- [ ] Ensure faults as actually faults. Recategorize anything that should be an error.
- [ ] Validate only the service which has the error is faulting.
- [ ] Investigate moving exceptions into Common Model.
- [ ] Exceptions should have additional information to help users contact us.

### **GOAL:** I want to be sure our alarm levels set appropriately.

Currently all our alarms have the same thresholds regardless of service or API. This may make sense in terms of faults (especially if we are actually faulting on the right thing). Using the same template for all APIs does not make a lot of sense in terms of latency. For latency we can look at overall historical graphs and determine a value to set for each individual API. In terms of High Fault count alarming, we could do the same, but we should wait until we have cleared out some of the noise to get a good idea what a valid high fault count value is. We should still keep alarm configuration in code as it is the easiest way to track and verify we have the right alarms set up, but our configuration will need to change, which will likely require us working a lot of existing alarmist ion files.

**TASKS**

- [ ] Investigate proper alarming values. (Consider thresholds and different ways to measure such as percentage based)
- [ ] Update alarmist configurations to be per API.
- [ ] Insure we have proper infrastructure alarming.
- [ ] Consider using x-ray.

### goal: When a customer does need to contact us, I want it to be easy for them to find us

Nothing is more annoying when you’re facing a problem than unable to find help. Our CTIs should be clear, and easy to find. Beyond that, our user facing UIs should have easy to find links to get the help they need. We should also help people find CTIs for our business partners who configure data, and know which is the most appropriate team to contact.

**TASKS**

- [ ] Review and correct CTIs [Look into those Exceptions which show CTI]
- [ ] Create additional quicklinks to be included in UIs
- [ ] Investigate dynamic “Need Help” links based on current page.
- [ ] Update our wiki documentation with links to our CTIs as well as our business partner’s CTIs.

### **GOAL:** All our herd graphs are monitored and alarmed

A fair amount of our software is running through herd, and is currently not closely monitored. This has led to large long running issues that could have been spotted earlier with proper monitoring. Most of our alarming on Herd is currently set to Sev3, we need to reconsider this and set appropriate Sev2 alarms. We also need to investigate the common errors we are seeing and if the problems can be solved autonomously.

**TASKS**

- [ ] Ensure all herd graphs have Sev3 errors for all states, and Sev2/2.5s set appropriately for customer impacting errors.
- [ ] Investigate better categorization of errors, so when graphs do error, they are bucketed appropriately.
- [ ] Look into autonomous fixes for common errors; (wait states + retry?)
- [ ] Investigate current wait states, are these masking errors which should be identified earlier?

## Pipelines

>***“**A highly available system in which issues are exposed without customer contacts. **Issues can be resolved quickly, and every code commit is in production within hours**”*


We have previously discussed learning out issues in the previous sections, but once we know of an issue, we need to be able to release code quickly. The number one thing that slows that down is blocked pipelines. All our pipelines should generally be unblocked, and code should be able to go to all the way to production within hours. Right now we typically have more pipelines blocked than not; and tests which require pressing “restart” to get the stars to align and have the test pass.

### **GOAL:** Functional Test pass consistently, and test the right things.

Functional tests are integral point of our testing to validate our system is working. We lose confidence when the tests fail inconsistently. We also lose confidence when the tests are just overridden. Each functional test package should pass consistently and fail only when there is an actual problem in our code. When a bug does make it to production, a functional test should be added to validate the same bug never presents itself again. We can get to this point by first looking at our existing tests and ensure the tests are still valid (our code base has changed a lot in the past year, while our tests have changed less so) and pass consistently. I propose we deep dive each test, remove invalid tests, onboard with common testing framework for data step-up/cleanup, and ensure we have happy test cases for each API. At this point I would avoid adding error test cases, unless we know the error case being tested has happened in the past or is currently an issue for associates.

**TASKS**

- [ ] Onboard all tests with common test framework.
- [ ] Remove old, invalid test cases.
- [ ] Add any missed happy path test cases.
- [ ] Validate the tests pass consistently.
- [ ] Create a team norm on adding functional tests.
- [ ] Look into Chameleon and Dev Desktop setups for SQS.

### **GOAL:** RediforK tests validate reasonable  expectations, and pass with in a reasonable timeframe.

Currently we have Redifork configured to look at one-box metrics and ensure successful calls to our APIs before promoting code changes to production. I believe this a good practice to prevent issues from making to production, but we setup Redifork once, and often do not readdress it unless there is a problem (such as missing metrics). We also set random nice round numbers for validation testing. These numbers look pretty, but it is not known if they are a good representation of our call pattern. Even worse, some of these tests take over 20 hours to complete essentially blocking our pipeline for day, or they time out all together after a day, blocking our changes which actually have no failures.

**TASKS**

- [ ] Determine which APIs are critical and should be used in Redifork tests.
- [ ] Investigate tests which are not dependent on the number of calls.
- [ ] Update Redifork tests so they validate our code is working but do not block the pipelines longer than 60 minutes.

### GOAL: All pipelines are using the latest best practices.

Pipelines are another tool we setup once and do not often go back and investigate if we’re using the best practices. Pipelines has a built in tool to alert you to concerns on your pipeline, we should look at these suggestions and validate the ones we are ignoring are for good reason, and correct anything else that we could do better.

**TASKS**

- [ ] Audit our pipelines against current best practices. (Define a best practice that makes sense for our team.)
- [ ] Audit our pipelines and deprecate any we no longer need.

## Code Quality, Process, and Ownership

>***“A highly available system** in which issues are exposed without customer contacts. Issues can be resolved quickly, and every code commit is in production within hours”*


Another key component of having a highly available system is having high quality code. It is really no surprise that well written, reviewed, and tested code tends to be much more stable than quick hacks pushed through with zero oversight. Closely related to high code quality is the processes around releasing software. Well defined stories are easier to implement and combined with a well defined process leads to faster development times with less scope creep.

### Goal: our team has a consistent Design, coding and agile standards

Having a consistent standard in both coding and design helps overall quality improve. If you do not have to focus on style choices you can focus more closely on actual functionality. This helps speed up the entire development cycle from design to code review.

**TASKS**

- [ ] Decide on a team standard for code style.
- [ ] Make sure checkstyle is enforced every where, using the common build configuration.
- [ ] Investigate git hooks/IDE configuration to do this automatically.
- [ ] Document and provide configuration files in common shared location (either wiki, team drive, or repo)
- [ ] Agile process is well documented and followed by the team.

### goal: all our systems are documented

Documentation tends to become obsolete as soon as it is written, and is hard to keep up with due to the emphasis on delivering projects. Not maintaining solid documentation ends up leading to pockets of tribal knowledge, and slowing the onboarding of new engineers. One of the best ways to keep documentation up to date is doing it in code it self through javadoc and commenting. Along with self documented code, making documentation of changes part of the task will force the team to make documentation a priority.

**TASKS**

- [ ] Add a team norm around documentation maintenance.
- [ ] Investigate any tooling from turning Javadoc into wikis
- [ ] Migrate existing documentation into the new wiki and link it properly so it is easy to navigate.
- [ ] Documentation for Customers.








