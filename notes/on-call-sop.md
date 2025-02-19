## On-Call Responsibilities and Daily SOP

**Purpose:** The On-Call Responsibilities and Daily Standard Operating Procedure (SOP) outlines the tasks and responsibilities of an on-call team member. It provides a structured approach to managing the on-call queue, addressing various ticket types, and improving team operations.

**Steps:**

1. <Review team health dashboard: Pending link here>
2. **Organize On-Call Queue:**
    1. Start by organizing the on-call queue, prioritizing the oldest tickets. Begin scanning from the bottom of the queue and work upward.
    2. Identify and close out "quick wins" – tickets that can be resolved in less than 10 minutes. This includes tasks such as canceling WSR (Workstation Request) requests, closing customer tickets that have been inactive while waiting for a reply, responding to simple information requests, or closing bulk tickets related to common outages.
    3. Address any tickets that should have a quick resolution, but are uncertain how to resolve them promptly. Collaborate with a teammate for assistance, promoting knowledge sharing.
3. **Address High-Priority Tickets:**
    1. Review the queue for high-priority tickets that require immediate attention. This may include large impacting bugs in the FC (Fulfillment Center), DLQ (Dead Letter Queue) tickets open for 7+ days, customer tickets idle on the team's end for 3+ days, and herd tickets.
    2. Explore systematic solutions to eliminate these issues, rather than addressing each specific ticket individually.
4. **Prevent Recurrence:**
    1. Deep dive into tickets that need preventive measures to avoid future occurrences. Focus on improving team operations and preventing similar issues from arising in the future.
    2. Root cause analysis should be conducted to ensure that resolved issues do not reoccur.
5. **Check External Requests Folder:**
    1. Examine the Device Reverse Logistics Tech - External Requests folder and check for any tickets that should be in the On-Call folder. Move them to the appropriate location and repeat Step 1.
6. **Proactive Improvements:**
    1. If there are no tickets to work on while on-call, proactively investigate how to enhance the team's operations. This may involve:
    2. Unblocking pipelines to ensure smooth workflow.
    3. Resolving Software Assurance Service (SAS) risks to maintain service quality.
    4. Identifying and removing dead code.
    5. Writing functional tests to improve code reliability.
    6. Participating in code refactoring to enhance codebase quality.

**Responsible Party:** On-Call Team Member

**Frequency:** The On-Call Responsibilities and Daily SOP should be followed during each on-call shift to efficiently manage the on-call queue and contribute to continuous improvement.


## Additional notes ...

### Announcement Section

Ideally each **resolved** ticket should have following announcement put manually or through bot. If a ticket caused customer impact, ticket must have this announcement  -

```
Issue : <Describe what was the issue>
Root Cause : <What caused this issue>
Fix : <How this issue was/can-be fixed>
Customer impact : <What was customer impact>
```


Each **active and unresolved** Sev2.5+ should have following announcement -

```
Issue : <Describe what is the issue>
Root Cause : <What caused this issue if you know it. Put `Unknown` until
root cause if identified>
Customer impact : <What is customer impact. Put 'Unknown' otherwise until customer
impact is identified>
Next steps :
         * <If unknown, what are we doing to identify customer impact>
         * <If unknown, What are we doing to mitigate customer impact>
         * <If unknown, What are we doing to identify root cause of the issue>
         * <If unknown, What are we doing to fix root cause>
```

### Ticket Runbook

Please ensure ticket has runbook attached to it. If runbook does not exist or needs update, please cut an OE backlog task in this folder.

### Pipeline Hygiene

As of Friday, August 30, Oncall handoff is every Wednesday. Please spend 0.5 day on Tuesday to unblock pipelines in criticality order mentioned <here>.

### Ticket Root Cause

Either fix the root cause of cut an OE backlog in <this> folder to prevent recurrence of ticket before resolving. Please mention ticket link in SIM for context.





