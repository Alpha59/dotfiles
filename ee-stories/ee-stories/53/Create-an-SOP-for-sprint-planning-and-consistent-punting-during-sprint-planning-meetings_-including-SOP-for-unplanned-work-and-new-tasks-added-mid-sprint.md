## Summary
**As a** product manager or scrum master, **I want** a Standard Operating Procedure (SOP) for sprint planning, addressing consistent punting (deferring tasks) during sprint planning meetings, **so that** the team can ensure better sprint planning, manage unplanned work, and handle new tasks added mid-sprint effectively without causing delays or disruptions.

This SOP establishes clear guidelines for planning sprints, managing tasks that are repeatedly deferred, and handling unplanned work or new tasks that arise mid-sprint. This will help the team maintain focus, meet sprint commitments, and improve velocity over time.

### Vision
A well-documented SOP for sprint planning will ensure that the team can properly scope work, prioritize tasks, and handle any unforeseen work that occurs during the sprint. By providing a clear process for deferring tasks and addressing unplanned work, the team will be able to improve sprint predictability, manage workload effectively, and ensure that the right priorities are being addressed.

### Background
Currently, the team may struggle with punting tasks that don’t get completed during the sprint, leading to over-commitment and missed sprint goals. Additionally, unplanned work or new tasks that arise mid-sprint can disrupt focus and cause delays. A structured process is needed to manage these situations effectively and ensure that sprints remain productive and focused.

### Purpose
The purpose of this SOP is to provide clear procedures for sprint planning, dealing with tasks that are consistently punted, and handling unplanned work or new tasks added mid-sprint. This supports the broader goals of improving sprint execution, reducing disruptions, and maintaining a predictable development process.

## SOP for Sprint Planning

### Sprint Planning Procedure
1. **Review Backlog and Prioritize**:
   - Begin each sprint planning meeting by reviewing the product backlog.
   - Prioritize the highest-value tasks based on business needs, team capacity, and deadlines.
   - Ensure that the team agrees on the priorities and understands the scope of each task.

2. **Capacity Planning**:
   - Review the team’s available capacity for the upcoming sprint. Consider planned time off, other commitments, and velocity from previous sprints.
   - Ensure that the sprint is scoped realistically based on the available capacity.

3. **Break Down User Stories**:
   - Break down large stories into smaller, more manageable tasks if necessary.
   - Ensure that each task or story is clear, has well-defined acceptance criteria, and can be completed within the sprint.

4. **Identify Potential Risks**:
   - Discuss potential risks or blockers that could delay the sprint or specific tasks.
   - Assign ownership to ensure that blockers are addressed early.

### Procedure for Consistently Punted Tasks
1. **Review Punt History**:
   - During sprint planning, review any tasks that were punted from previous sprints.
   - Identify patterns in why these tasks are repeatedly deferred (e.g., lack of resources, changing priorities, unclear requirements).

2. **Prioritization of Punted Tasks**:
   - If a task has been punted multiple times, discuss whether it should be prioritized higher in the current sprint or deprioritized entirely.
   - Ensure that the reasons for punting the task are clearly documented.

3. **Decision Framework for Punted Tasks**:
   - If the task is critical but was punted due to lack of resources, reassign or escalate it.
   - If the task is no longer a priority, move it to the backlog with a note to revisit at a later time.

4. **Commitment on Punted Tasks**:
   - For tasks that are punted into the current sprint, ensure a renewed commitment to complete them.
   - Reduce the likelihood of punting by ensuring that these tasks are properly scoped and supported.

### SOP for Unplanned Work and New Tasks Added Mid-Sprint
1. **Identify and Categorize Unplanned Work**:
   - When unplanned work arises during a sprint, categorize it as either **urgent** (must be addressed immediately) or **non-urgent** (can be deferred to the next sprint).
   - For urgent unplanned work, determine the impact it will have on the current sprint goals.

2. **Reevaluate Sprint Scope**:
   - If the unplanned work is urgent, reassess the sprint scope to determine which planned tasks may need to be deprioritized or deferred.
   - Ensure that the team is aligned on the adjusted sprint goals.

3. **Handling New Tasks Mid-Sprint**:
   - If a new task is added mid-sprint, evaluate whether it aligns with the sprint goal and can be completed without impacting other work.
   - If it’s critical, adjust the sprint backlog by deferring a lower-priority task to the backlog.

4. **Communicate Changes**:
   - Ensure that any changes to the sprint due to unplanned work or new tasks are communicated to all stakeholders (product owners, team members, and management).
   - Adjust the sprint goals and tracking as necessary to reflect the updated workload.

5. **Documentation of Unplanned Work**:
   - Document all unplanned work that occurs mid-sprint, including the reason for the work, its priority, and the decision-making process.
   - Use this documentation to improve future sprint planning by factoring in recurring types of unplanned work.

### Testing and Validation
- Test the SOP by running a sprint following the guidelines for planning, punting tasks, and handling unplanned work.
- Validate that the procedures reduce the occurrence of tasks being punted repeatedly and ensure better handling of mid-sprint changes.
- Gather feedback from team members after each sprint to improve the SOP.

### External Dependencies
- Product backlog must be maintained and prioritized ahead of each sprint planning meeting.
- Access to tools for task management and tracking (e.g., Jira, Trello).

## Acceptance Criteria
- Should have a clear sprint planning procedure that ensures the sprint scope is realistic and achievable.
- Should have a process for addressing tasks that are consistently punted, either by prioritizing or deprioritizing them.
- Should have a procedure for handling unplanned work and new tasks added mid-sprint, including reassessing sprint scope when necessary.
- Should have documentation of unplanned work and punted tasks to improve future sprint planning.

### Gherkin
```gherkin
Given a task is consistently punted during sprint planning
When the sprint begins
Then the team should review the reasons for punting the task
And ensure a decision is made on its priority for the current sprint.
```
```gherkin
Given unplanned work arises mid-sprint
When the sprint backlog is reassessed
Then the team should adjust the sprint scope if necessary
And ensure communication with all stakeholders about the change.
```

## API
N/A

## External Links
- [Scrum.org – Sprint Planning](https://www.scrum.org/resources/sprint-planning-overview)
- [Atlassian – Managing unplanned work in Agile](https://www.atlassian.com/agile/project-management/unplanned-work)
