# Burn-down Retrospective

A burn down chart is a tool in Agile project management, particularly in Scrum frameworks. The burn-down provides a visual representation of work progress over time, helping teams monitor and manage their sprint workloads effectively.
[Image: image.png]
## What is a Burn Down Chart?

A burn down chart is a graphical representation that shows:

* Total work remaining (in hours, tasks, or story points) on the vertical axis.
* Time (typically the sprint duration) on the horizontal axis.

The chart typically includes:

* Ideal Work Line: A straight line indicating the optimal rate of work completion to finish the sprint on time.
    * SIM uses a plateau to represent weekends in their charts. Not all Burn down charts include this.
* Actual Work Line: A line that shows the real progress as tasks are completed.
    * SIM allows users to burn points against a story, so stories do not need to be completed to show “burn”. This is helpful for multi-day stories, but misrepresents “Completed” work.

## Importance of Burn Down Charts

### Tracking Progress

* The chart provides real-time insights into how much work has been completed and how much remains.
* Teams can identify whether they are on track to meet the sprint goal.
* SDMs, Management, and Stakeholders can determine if a Sprint is on Track based on this reporting.

### Transparency and Communication

* Burn down charts offer a shared understanding of progress for all stakeholders, including developers, product owners, and managers.
* They serve as a communication tool, reducing misunderstandings and aligning expectations.

### Early Identification of Issues

* By comparing the actual work line with the ideal work line, teams can quickly detect deviations.
* For example, a flat or upward-trending actual work line signals delays or blockages, prompting timely interventions.

### Promotes Accountability

* Burn down charts encourage team members to take ownership of their tasks by making progress (or lack thereof) visible.
* This fosters a sense of responsibility and collective effort.

### Data-Driven Decision-Making

* By analyzing trends in the burn down chart, teams can make informed adjustments:
* Reassigning tasks.
* Addressing bottlenecks.
* Adjusting sprint scope if necessary.

### Improves Sprint Planning

* Understanding how work was completed in previous sprints helps teams plan future sprints with increasing accuracy.
* Teams can identify patterns in task completion, helping to set realistic goals.

## Interpreting Slope/Velocity

The slope of the burn down chart is a measure of the rate at which work is being completed during a sprint. To calculate the slope, use the rate of change formula from basic mathematics. The slope is typically calculated as the change in work completed (vertical axis) divided by the change in time (horizontal axis). Here’s how it works:

* A negative slope indicates progress as work is completed (work remaining decreases).
* The magnitude of the slope represents the rate of progress, or the number of stories per day.
* If the slope flattens (closer to zero), it indicates slow progress, while a steeper negative slope indicates faster completion.
* Ideal Slope: Represents the planned rate of work completion for the sprint (a straight line from total work to zero).
* Actual Slope: Calculated from the team’s real progress.
* Comparing the ideal slope to the actual slope helps identify discrepancies, allowing for timely interventions to ensure sprint goals are met.

[Image: image.png]This Graph describes a burn down chart that has a more complex pattern, often referred to as an "S-curve" or "sigmoid curve." The burn down starts correctly, indicating proper sprint planning. In the middle of the sprint, the burn down falls behind schedule, showing slower progress than expected. Shortly after, the burn down moves ahead of schedule, demonstrating rapid progress. Finally, the burn down ends correctly, meeting the sprint goal.

### Overall Velocity:

The overall velocity (from start to finish) appears to be on target, as the sprint starts and ends correctly. This suggests that the team has a good understanding of their total capacity for the sprint.


### Point Velocity:

The point velocity (rate of progress at different points in the sprint) varies significantly, revealing potential issues:

Slow Middle Period:

* Indicates: Possible blockers, unexpected complexities, or dependencies that weren't initially apparent.
* Potential issues: Team might be struggling with certain tasks or facing unforeseen challenges.

Rapid Progress Period:

* Indicates: Quick resolution of earlier issues, or completion of preparatory work that enables faster progress.
* Potential issues: Suggest that earlier estimates were off, or that the team is rushing to catch up.

Implications:

1. Task Dependencies: The pattern might reveal hidden dependencies between tasks that weren't accounted for in sprint planning.
2. Estimation Accuracy: The varying progress rates suggest that tasks might be over or underestimated.
3. Work Distribution: The team's workload might not be evenly distributed throughout the sprint.
4. Risk Management: The ability to catch up after falling behind demonstrates team resilience but also highlights potential risks in the process.


By addressing these aspects, the team works towards a more predictable and constant burn down chart, which often indicates a smoother and more streamlined sprint execution. While the overall velocity is crucial for meeting sprint goals, the point velocity provides valuable insights into the team's process and highlights areas for continuous improvement.

## Understanding Burn Down Charts

To effectively use burn down charts, teams must understand key aspects:

### Reading the Chart

* Steady Decline: Indicates consistent progress.
* Flat Line: Suggests stalled progress, possibly due to blockers or underestimated complexity.
* Steep Decline: May indicate excess effort or that simpler tasks are completed first, leaving complex work for later.

For all these scenarios, it's crucial to use the retrospective to foster open discussion, identify root causes, and develop actionable improvements. Regular review of these improvements in subsequent sprints will help the team progress towards ideal burn down patterns and productive sprint execution.
[Image: image.png]
### The Cliff (Dropping at the end)

A sudden, steep drop in remaining work near the sprint's end. The cliff indicates work is being rushed or improperly reported at the last minute. This may mean that stories are too large, and not resolving until the last day of the sprint. To resolve, encourage consistent progress throughout the sprint and accurate daily reporting. During retro, analyze why work is being left until the end and develop strategies for even distribution of effort across the sprint.

### The Lag (No Drop until several days into the sprint)

No visible progress in the early days of the sprint. The lag indicates slow start, poor sprint planning, or inaccurate task breakdown. To resolve, improve sprint planning, break down tasks more effectively, and focus on starting strong. During retro discuss reasons for the slow start and brainstorm ways to hit the ground running in future sprints.

### The Gap (Not reaching 0 at the end of the sprint)

Incomplete work at the sprint's end. The Gap indicates overcommitment or unexpected challenges during the sprint. To resolve, improve capacity planning and leave buffer for unexpected work. During retro, review estimation techniques and discuss how to better align sprint goals with team capacity.

### The Flatline (The end of the sprint showing no additional progress)

Stagnation in progress towards the end of the sprint. The Flatline indicates team burnout, blocked tasks, or poor time management. To resolve, identify and remove blockers early, manage team energy throughout the sprint. During retro, analyze causes of the flatline and develop strategies to maintain momentum until the sprint's end.

### The Bounce (An increase in the burndown starting when the sprint is almost finished)

Increase in workload near the sprint's end. The Bound indicates scope creep, poor estimation, or discovery of hidden work. To resolve, improve sprint planning, estimation, and scope management. During retro, identify sources of late-sprint scope increases and develop processes to prevent them.

### The Wave (continual increase and decrease in the burndown chart)

Inconsistent progress throughout the sprint. The wave indicates poor task breakdown, inconsistent reporting, or frequent scope changes. To resolve, improve task granularity, ensure consistent daily updates, and manage scope strictly. During retro, analyze reasons for the fluctuations and develop strategies for more consistent progress and reporting.

### Interpreting Deviations

* If the actual work line diverges significantly from the ideal work line, teams should investigate:
* Were tasks underestimated or overestimated?
* Are there unexpected dependencies or technical challenges?
* Are priorities shifting mid-sprint?

### Contextual Factors

* Burn down charts should be analyzed alongside other metrics (e.g., velocity, defect rates) for a comprehensive view.
* External factors, such as team member availability or tool failures, may impact progress.


Burn down charts are an indispensable tool for ensuring predictability, accountability, and transparency in Agile sprints. By understanding and leveraging them effectively, teams can identify problems early, adjust their workflows, and improve their sprint planning and execution. This fosters a culture of continuous improvement, ultimately leading to improved product delivery and elevated team performance.

## Example Burn downs

The slope of the burn down chart is the measure of the rate at which work is being completed during the sprint. The Rate of change formula can be used for a basic calculation, but Linear Regression is a more appropriate measure of the slope/velocity.

Fig 1 presents a problematic burn down chart due to its high initial point count, recurring fluctuations, and minimal overall progress. Starting at 200 points and ending at the same value, with peaks reaching 213 points, this pattern indicates poor sprint planning and execution. The flat velocity line emphasizes the team's inconsistent progress. This scenario likely results from inadequate task breakdown, unrealistic goal-setting, and ineffective daily management of sprint activities. Such a pattern can lead to team frustration, stakeholder disappointment, and difficulty in predicting future sprint performance.
[Image: burndown (1).png]Fig 1: Standard Burn down with Fluctuations
Issues:

* High initial point count and fluctuations suggest poor sprint planning
* Little progress made overall (200 to 200 points)
* Flat velocity line indicates inconsistent progress

Solutions:

* Improve sprint planning to set realistic goals
* Break down stories into smaller, manageable tasks

Retro Action:

* Analyze reasons for fluctuations and lack of progress
* Discuss ways to improve estimation and task breakdown

Fig 2 illustrates a severe case of scope creep and overcommitment. The dramatic increase from 140 to 307 points suggests a lack of sprint boundary enforcement and poor capacity planning. With very few stories completed, the team has likely taken on too much work or allowed unplanned tasks to infiltrate the sprint. The misalignment between the velocity line and the remaining points line until mid-sprint highlights the team's struggle to manage their workload effectively. This pattern leads to decreased team morale, missed sprint goals, and eroded stakeholder confidence.
[Image: burndown (4).png]Fig 2: Significant Burn-up
Issues:

* Large increase in points (140 to 307) indicates scope creep
* Few completed stories suggest poor focus or overcommitment
* Misalignment between velocity and remaining points

Solutions:

* Strictly manage scope during sprint
* Improve capacity planning and story point estimation
* Focus on completing stories before adding new ones

Retro Action:

* Identify causes of scope creep and develop strategies to prevent it
* Review and refine story point estimation process

Fig 3 showcases an initial spike in the burn down chart, rising from 88 to 141 points at the sprint's start. This pattern is problematic as it indicates incomplete sprint planning or failure to assign points to all stories before the sprint began. While the subsequent smooth burn down is positive, the initial spike suggests that the team may be underestimating work at the sprint's outset or failing to capture all necessary tasks during planning. This can lead to unexpected work emerging during the sprint, potentially disrupting the team's focus and rhythm.
[Image: burndown (5).png]Fig 3: Initial Spike with Smooth Burn down
Issues:

* Initial spike (88 to 141 points) indicates incomplete sprint planning
* Potential underestimation of work at sprint start

Solutions:

* Ensure all stories are pointed before sprint start
* Improve sprint planning process to capture all necessary work

Retro Action:

* Discuss ways to improve sprint planning completeness
* Identify any recurring patterns of missed work in initial planning

Fig 4, while showing consistent burn down, is problematic because 25% of the stories remain unfinished at the sprint's end. This indicates a slight overcommitment by the team. Although the burn down is steady and there's no initial burn-up, the incomplete sprint suggests that the team's capacity planning needs refinement. Consistently failing to complete all committed work can lead to a backlog of unfinished stories, potentially impacting product delivery timelines and team motivation.
[Image: burndown (9).png]Fig 4: Consistent Burn down with Incomplete Sprint
Issues:

* 25% of stories remain unfinished, indicating slight overcommitment

Solutions:

* Fine-tune sprint capacity planning
* Consider using buffers for unexpected work

Retro Action:

* Analyze reasons for unfinished stories
* Discuss ways to improve capacity estimation

Fig 5 presents a more severe case of overcommitment than Fig 4. Despite showing a consistent, linear burn down throughout the sprint, only 65% of the points are completed. This significant shortfall in completed work indicates that the team has substantially overestimated their capacity or underestimated the complexity of the stories. While the steady progress is commendable, repeatedly failing to complete a large portion of the sprint backlog can lead to accumulating technical debt, delayed feature delivery, and decreased stakeholder trust.

[Image: burndown (10).png]Fig 5: Linear Burn down with Incomplete Sprint
Issues:

* Only 65% of points completed, indicating significant overcommitment

Solutions:

* Reduce sprint scope to match team capacity
* Improve story point estimation accuracy

Retro Action:

* Review capacity planning process
* Discuss ways to better align sprint goals with team capacity

Fig 6 displays a problematic "mountain" pattern, with a marked spike in points at the beginning and a drastic drop at the end. This pattern suggests poor sprint planning, with significant scope creep early in the sprint, followed by either a rush to complete work or inaccurate reporting at the sprint's conclusion. The velocity line's complete separation from the actual sprint progress further highlights the team's inability to maintain consistent productivity. This erratic pattern can lead to quality issues, team burnout, and difficulty in sprint planning and estimation for future iterations.
[Image: burndown (14).png]Fig 6 Mountain Pattern with Drastic Drop
Issues:

* Large initial spike indicates poor sprint planning
* Drastic drop at end suggests rushed work or inaccurate reporting
* Velocity line disconnected from actual progress

Solutions:

* Improve sprint planning to avoid large scope changes
* Ensure consistent progress tracking throughout sprint
* Address any end-of-sprint rush tendencies

Retro Action:

* Analyze reasons for initial spike and end rush
* Develop strategies for more consistent progress throughout sprint

Fig 8 also shows a mountain pattern, but with a relatively smooth middle section. While the consistent burn down in the middle of the sprint is positive, the initial climb and end cliff are problematic. The early increase in points suggests incomplete sprint planning or scope creep, while the sharp drop at the end may indicate a rush to complete work, potentially compromising quality. This pattern, although showing some consistency, still reflects issues with sprint planning and execution that need to be addressed to achieve more predictable and effective sprints.
[Image: burndown (15).png]Fig 7: Mountain Pattern with Smooth Middle
Issues:

* Initial climb and end cliff indicate poor sprint planning and execution
* Middle portion shows consistency but overall pattern is problematic

Solutions:

* Improve sprint planning to avoid initial scope creep
* Focus on maintaining the consistency seen in the middle portion
* Address end-of-sprint cliff by spreading work more evenly

Retro Action:

* Identify factors contributing to initial climb and end cliff
* Discuss how to replicate the consistency seen in the middle portion throughout the entire sprint

In all cases, a thorough retrospective meeting can help prevent these issues in future sprints by:

1. Encouraging open discussion about the sprint's challenges
2. Identifying root causes of burn down chart anomalies
3. Developing actionable improvements for sprint planning and execution
4. Setting specific goals for the next sprint to address identified issues
5. Regularly reviewing progress on implemented changes in subsequent retrospectives

By consistently addressing these issues and implementing improvements, teams can work towards more predictable and effective sprints, resulting in smoother burn down charts and better overall performance.




