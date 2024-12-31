## Summary
**As a** project manager or team lead, **I want** to document the duration and number of points estimated to complete each task, **so that** I can track the team's performance, understand project timelines, and identify any reasons why tasks took longer than expected.

Tracking task durations and estimates allows for better planning, more accurate future estimations, and an understanding of bottlenecks. By documenting extenuating reasons for delays, the team can improve processes and avoid similar issues in the future.

### Vision
By documenting the estimated versus actual duration and points of each task, the team will gain visibility into project velocity and areas where improvements can be made. This ensures better forecasting, continuous improvement, and accountability for future sprints or project phases.

### Background
Software development projects often involve tasks that are assigned with estimated durations (in hours or days) and story points to indicate complexity and effort. However, tasks can take longer than expected due to unforeseen blockers, dependencies, or other issues. Without documenting these factors, it becomes difficult to accurately assess the team's velocity or improve estimation accuracy for future projects.

### Purpose
The purpose of this story is to create a process for documenting the estimated duration and story points for each task, tracking actual completion time, and recording any extenuating circumstances that caused delays. This process will enable the team to improve estimation accuracy, adjust timelines, and identify process inefficiencies.

## Details

### 1. **Track Estimated Duration and Points for Each Task**
   - **Estimation Process**:
     - Each task in the sprint or project backlog should have an assigned estimate, both in terms of duration (hours/days) and story points (complexity/effort). These estimates should be discussed and agreed upon during sprint planning or project kickoff.
     - Example:
       - Task: Implement API endpoint
       - Estimated duration: 3 days
       - Estimated points: 5 story points

   - **Record Estimates**:
     - Ensure that all task estimates are recorded in the project management tool (e.g., Jira, Trello, Asana) or documented in the task description.

### 2. **Track Actual Duration and Points**
   - **Start/Completion Dates**:
     - Document the actual start and completion dates of each task. This allows for the comparison of the estimated versus actual duration.
     - Example:
       - Task: Implement API endpoint
       - Estimated duration: 3 days
       - Actual duration: 5 days

   - **Track Points Completion**:
     - Record the number of points completed for each task in the project management tool. This helps track the velocity of the team (e.g., how many points are completed per sprint).

### 3. **Document Extenuating Reasons for Delays**
   - **Identify Delays**:
     - If a task takes longer than expected, document the specific reasons why the task was delayed. Common reasons might include external dependencies, scope changes, team member unavailability, unexpected technical challenges, or other blockers.
     - Example of documented delay:
       - Task: Implement API endpoint
       - Reason for delay: Delay due to external dependency on another team's API that was unavailable for testing.

   - **Types of Delays**:
     - **External Dependencies**: Another team or external service that the task depends on is unavailable or delayed.
     - **Technical Complexity**: The task turned out to be more complex than initially expected due to unforeseen technical challenges.
     - **Scope Creep**: The scope of the task changed mid-sprint, increasing the work required.
     - **Resource Availability**: A key team member was unavailable or experienced downtime (e.g., sickness, vacations).

### 4. **Reporting and Analysis**
   - **Velocity Tracking**:
     - Track the number of story points completed per sprint or project phase. If a significant number of tasks take longer than expected, identify patterns or common causes for delays.

   - **Estimation Accuracy**:
     - After each sprint or project phase, review the accuracy of estimates versus actual task durations. Use this data to improve future estimates by factoring in historical deviations.
     - Example:
       - Over the last 3 sprints, tasks related to API development took 20% longer than expected due to repeated dependency issues.

### 5. **Continuous Improvement**
   - **Adjust Estimation Processes**:
     - Based on the data collected, adjust future estimation processes to account for common delays or blockers. This ensures that future estimates are more realistic and improves planning accuracy.

   - **Address Repeated Blockers**:
     - If certain types of delays (e.g., dependencies on external teams) are recurring, create action items to mitigate these risks in future sprints, such as improving communication with other teams or adjusting dependencies earlier in the process.

### Testing
- **Post-Sprint Review**:
   - Conduct post-sprint reviews to compare estimates versus actual durations for each task and discuss extenuating reasons for any delays.

- **Track Velocity Over Multiple Sprints**:
   - Review team velocity over multiple sprints to identify any trends in under or over-estimation.

### External Dependencies
- Project management tool (e.g., Jira, Asana) to record estimates, durations, and delays.
- Collaboration with other teams or stakeholders to resolve dependencies or blockers.

## Acceptance Criteria
- Should track estimated and actual duration and points for each task in a project management tool.
- Should document any extenuating reasons for delays when tasks take longer than expected.
- Should regularly review and analyze estimation accuracy to improve future sprint or project planning.

### Gherkin
```gherkin
Given a task is completed in the sprint
When the actual duration exceeds the estimated duration
Then the extenuating reasons for the delay should be documented
And the actual points and completion time should be recorded.
```
```gherkin
Given a project or sprint is completed
When reviewing the tasks
Then the estimated versus actual durations and points should be analyzed
And improvements to future estimations should be discussed.
```
