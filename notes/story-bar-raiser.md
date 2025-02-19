# Story Bar Raiser

# User Stories and Tickets

## Summary

In agile development there are several different types of tickets or stories which can be defined. The most prominent of which is User Stories. User stories are descriptions of work from the customer perspective. This is a direct correlation to the “Customer Obsession” leadership principle.


>Leaders start with the customer and work backwards. They work vigorously to earn and keep customer trust. Although leaders pay attention to competitors, they obsess over customers. [Learn More](https://w.amazon.com/bin/view/LeadershipPrinciples/CustomerObsession)


For this reason, all stories start with the same syntax in the summary:


>As a [customer type] I want ... So that...


The customer type can be defined in a number of ways - but should be specific to a type of customer. Examples include (but are not limited to) FC Associates, CS Associates, Developers, Lab126 Users, or Team Leadership (Kevin/Jason). Customers may want various things, but it is important that we remember these are Wants, and not Needs. Any customer request can be pushed back on, as long as the pushback is justified.

What drives customer wants may vary, so it is important that we explain “So that” in a way that makes it as difficult as possible to push back against customers. For an FC Associate, their wants may be driven by an operational change - or a desire to simplify a process, and for Team leadership, wants may be derived from organizational changes, or initiatives. The goal of the summary is to help developers (and business users who are prioritizing work) to “Realize the Reward” of this story.

## Purpose

In keeping with the leadership principles, creating good stories, and following standard procedures helps us to “Earn Trust” not only with our customers, but also with our team mates.


>Leaders listen attentively, speak candidly, and treat others respectfully. They are vocally self-critical, even when doing so is awkward or embarrassing. Leaders do not believe their or their team’s body odor smells of perfume. They benchmark themselves and their teams against the best. [Learn More](https://w.amazon.com/bin/view/LeadershipPrinciples/EarnTrust)


For this purpose, we need to provide as much detail as we can in our tickets, mentioning any possible call outs and spreading information to our team members as effectively as possible. Although not all stories will fill all of the same requirements and meet all of the same criteria, adding as much detail as possible to try to convey the information as effectively as possible will never hurt.

Especially on teams where we are permitted to work from home, or communication can be compromised by schedule, information bias, or the [Framing Effect](https://www.sciencedirect.com/topics/medicine-and-dentistry/framing-bias) stories should stand on their own. Although discretion can be used to ensure that time is not wasted adding excessive detail, a reasonable assessment should be made that any new hire should be able to complete any story without help.

## Story Bar Raising

In order to maintain “Insist on the Highest Standards”, the team will use a Story Bar Raiser, and Team leadership sign off on each ticket before pointing.


>Leaders have relentlessly high standards — many people may think these standards are unreasonably high. Leaders are continually raising the bar and drive their teams to deliver high quality products, services, and processes. Leaders ensure that defects do not get sent down the line and that problems are fixed so they stay fixed. [Learn More](https://w.amazon.com/bin/view/LeadershipPrinciples/InsistOnTheHighestStandards)


The Story Bar raiser will be in charge of driving the ticket and story standards to higher and higher levels, introducing new templates in order to better adjust to our work - and working to ensure that all stories are prepared for sprint planning by the time sprint planning happens. Although the burden of reviewing stories will fall on the story bar raiser, ticket creators are allowed to push stories through the process quicker by nagging the story bar raiser. Ultimately, just like CRs, a ticket is owned by the creator, and it’s the creators job to ensure that their stories are completed.

The purpose of including a Team Leader sign off on tickets is to ensure that all tickets are beneficial to leadership goals, or business goals.

### Rubric

Required:

* Has a template been used, and is the template properly formatted?
* Does the Summary start with `As a <role> I want... so that...`
* Does the Purpose answer the question “What Greater goal does this story work towards?”
* Does the background information provide enough detail to understand the current functionality or where the request comes from?
* Do the details give enough information that the story can be completed independent of the creator?
* Does details include at least 1 happy path with Given/When/Then syntax?
* Is this story testable?
* Can this story be completed by the team - or are there external dependencies?

Proficient:

* Does the summary justify the importance of the story, is the summary indisputable?
* Does the Purpose answer the question “Why is this story important for the greater goal?”
* Do the details give enough information that there are no open questions regarding implementation?
* Do the details include all possible paths, including errors with Given/When/Then syntax?
* Do UI changes include any Wireframe or existing screenshots needed as explanation?
* Are inputs/outputs for new APIs, or changed APIs, clearly defined?
* Does the testing section define requirements and present a checklist for the developer?
* Is this story excessively large/vague?
* Is there enough information to point this story, or too many open questions?

Excellent:

* Do the external links include reliable information from wiki pages or articles that support the technology decisions?
* Do the Details outline every possible path, including errors, happy paths, and user error paths using Given/When/Then syntax?
* Are the details organized and clear with comprehensive information on the topic?
* Are Wireframes properly labeled and details given describing the functionality?
* Are screenshots attached for UI changes which detail how the system is currently functioning?
* Can the defined input/outputs be directly translated to a coral or swagger model?
* Does the story give enough Vision and paint a clear enough picture that a business user will be able to see the benefit to this story and properly prioritize it?
* Does this story have excessive implementation details that will limit a developers ability to be “Creative” or “Experiment“?

Wanted:

* Flow diagrams or EM or UML diagrams are added to define complex functionality (These should be pulled from design docs)
* Are all possible sources of errors identified?
* Testing Methods, including setup are documented, making them easy to reproduce.

Writing:

* No spelling, grammar, capitalization or punctuation errors. Sentences are all well-formed.
* All details were unique, interesting, and related to and supported the main idea.
* All ideas were presented in a logical order.
* Introduction was clear, body included many details, and conclusion summarized main idea.
* Writing flowed smoothly throughout.
* Opinions were clearly defined compared to facts.
* All links in the project are labeled and connect to the right place.

## Process

It is proposed that a folder exist for “Backlog - Input“ work, where both the Story Bar Raiser and Team Leadership can manage work which has not yet moved through the process. Once these stories have been reviewed, they will be moved by either the Story Bar Raiser or Team Leadership into the ”Backlog“ folder. Once work is in the Backlog folder, the team’s TPM and Team Leadership will be responsible for organizing work by priority (Rank).

The folders where tickets should be created will be:

* **RL Backlog - Input**
    * This is the folder where Team members should be expected to create stories.
    * These stories or tasks will not be considered for sprint planning until they have been reviewed and approved, which will move them into the “RL Backlog” Folder.
    * Team members, Team Leadership, and Team TPMs will all  be expected to create items in this folder.
    * Stories in this folder will not be considered for sprint planning until they have been moved to “RL Backlog” by either the SBR, or team leadership.
* **RL Backlog**
    * This folder should not have tickets created directly, but instead should have tickets moved into it from other folders.
    * The RL Backlog will be a priority queue of work items.
        * Prioritization is determined by team leadership, Process Owners, and the team TPM.
    * Each process owner (OE/Isley, RACs) should be expected to rank and organize tickets in the ”RL Backlog“ folder, while respecting the importance of other projects.
* **Upcoming Sprint (Not yet Active)**
    * During the pre-planning meeting, items prioritized by process owners should be moved into the upcoming sprint.
        * This is not a final verdict on which items will be pulled into a sprint, just a list of the most likely items to be pulled in for planning purposes.
    * The rankings in the Backlog folder should give a general sense of which items will be pulled in next. Not all items which will be pulled into a sprint need to be added until the Planning meeting.
* **Sprint (Active) **
    * This is the only place where team members should be expected to move stories around
    * The Stand-up presenter will be expected to log effort and burn points against stories during stand-up
    * Team members should not pull stories into the sprint/drop stories from the sprint, without prior consent from the Scrum Master
* **Sprint Retrospective**
    * This folder is where Sprint Retro Items should go. Retro Items will not be considered for a sprint until they are written to use one of the below templates, and moved into the RL Backlog - input queue.
        * This does not apply to non-code tasks, which may be pulled directly into a sprint, or exist only as a reminder.
    * Stories in this folder will not be considered for sprint planning until they have been moved to “RL Backlog”
* **CRET Feature Requests**
    * This folder exists only for away team work, and work which does not fall into our normal job duties within RL-Tech.
    * Stories in this folder will be prioritized and managed outside of the normal process, and may be pulled into a sprint, or assigned by Team Leadership - purely at the discretion of Team Leadership.
* **Feature Requests**
    * This folder is for external feature requests, and should not be filled by RL-Tech Team members. This is the folder where we expect our business partners, and our users to create tickets.
    * Stories in this folder should be moved into the “RL Backlog - Input“ by a team member, and edited to include the appropriate details. If we do not want the ticket creator to see progress/details, a new ticket can be created and linked.
    * Stories in this folder will not be considered for sprint planning until they have been moved to “RL Backlog”
    * **Need a follow up to determine how to force our FC users and Business Users to better use the templates.**
        * Look at past tickets and see what the best template format for them would be.
* **NPI Testing**
    * This folder is only for NPI testing requests.
    * Stories in this folder will not be considered for sprint planning until they have been moved to “RL Backlog”
    * **Need custom template for this that shows the processes and the ASIN being tested**
* **On-Call**
    * This folder exists for general ticket creation. These tickets are any tickets which are created in relation to our CTI, either by auto-cut systems, our own alarms, or customer requests.
    * This folder will not be subject to the story bar raiser system.
    * On-Call tickets should not be moved into a sprint.
    * If an On-call ticket requires further investigation, or should be pulled into a sprint - a team member should create a new story in “RL Backlog - Input” for that purpose (and comment the new ticket onto the on-call ticket.
    * Stories in this folder will not be considered for sprint planning until they have been moved to “RL Backlog”

The existing folders underneath “Backlogs”, "and "Quality Engineering Management" will no longer be utilized by the team, and Team leadership will take on the role of moving all items out of those folders before removing the folders.

During the **Pointing meeting**, items in the “RL Backlog” which are not pointed (or where points may no longer be relevant) will be pointed in order starting with the highest priority items. All developers should be present for this meeting, and any stakeholders who have created tickets which they would like to explain may be invited to the meeting, although attendance is optional. This includes TPM, or PM-T members.

During the **Pre-planning meeting** the Story Bar Raiser, Team Leadership, TPM, and any developers of interest will be expected to review stories in the “RL Backlog” and ensure that they have met the high standards required - and choose which stories will be pulled into the upcoming sprint. Ad-hoc work can be added to the sprint during Pre-planning, with the expectation that it will be pointed during planning.

During the **Planning** meeting, the sprint will be reviewed, ad-hoc work will be pointed, and the number of available points will be allocated based on the teams capacity. This is where members of the team should feel free to disagree with the work allocated for the upcoming sprint, and argue for different work to be pulled into the Sprint.

## Design Reviews

A design should essentially translate to an Epic. Once a design has been reviewed and approved by the team, and a final design has been agreed upon, it is the design authors job to create a series of stories related to the design, which all follow the templates. The ticket summaries should initially be amended to the design, so that there is visibility towards the priority and order of tickets, giving a broad overview of the Epic. Each story should then be created in the “RL Backlog - Input” folder, and return to the standard process.

## Templates:

### Business User Template - Feature Request

>Summary:

>As a `[user/Kevin]` I want... so that...

>

>Purpose:

>`Answer the questions: "What greater goal this story is working towards? Why is this story important for that Goal?" e.g: NA SUS launch`

>

>Background:

>`Any appropriate background information should be filled in here. This should include basic description of existing functionality`

>

>Details:

>`If a wiki is available on how to perform this action, link it here. If code changes with significant business rules are required - explain the business rules here`

>Please use concrete examples when filling in the details section, this means using the Given/When/Then syntax with your examples.

Given: Describes the initial context of the system, typically something which has previously happened.
When: Describes an external action which is applied to the system, either by a person, or another system.
Then: Describes the expected result for the user, or external system.

More information can be found here: https://cucumber.io/docs/gherkin/reference/

>External Links:

>`Link any external tickets/files which may be helpful in this story`

### On-call Autocut - Backlog Input

>Summary:

>As an autocut ticket I alarmed on...

>

>`This section is not meant to be a copy paste of the original autocut ticket, but a new description of the problem in the developers words`

>

>Research

>`Add any notes regarding previously performed research here`

>

>Explanation

>`Add an explination about why this is being moved from on-call to a ticket`

>

>Details:

>`If a wiki is available on how to perform this action, link it here.`

>

>External Links:

>`Link any external tickets/files which may be helpful in this story`

### On-call Manual Ticket  - Backlog Input

>Summary:

>As an [FC/CS/Lab126] user I want.... so that...

>

>`This section is not meant to be a copy paste of the original on-call ticket, but a new description of the problem in the developers words`

>

>Research

>`Add any notes regarding previously performed research here`

>

>Explanation

>`Add an explination about why this is being moved from on-call to a ticket`

>

>Details:

>`If a wiki is available on how to perform this action, link it here. If conversation has happened in the comments section - summarize it here`

>

>External Links:

>`Link any external tickets/files which may be helpful in this story`

>

### Technical Story Template - Backlog Input

>Summary:

>As a `[developer/user/Kevin]` I want... so that...

>

>Purpose:

>`Answer the questions: "What greater goal this story is working towards? Why is this story important for that Goal?" e.g: NA SUS launch`

>

>Background:

>`Any appropriate background information should be filled in here. This should include basic description of the existing code, or system architecture`

>

>Details:

>`If a wiki is available on how to perform this action, link it here. If code changes with significant business rules are required - explain the business rules here`

>

>Acceptance Criteria:

>This story is completed when:

>`Breifly explain how the developer will know when this story is completed. Give specific examples of possible input/output that should be expected from this change`

>

>Testing:

>`How should this story be tested, including if manual/unit or functional tests are required`

>

>External Links:

>`Link any external tickets/files which may be helpful in this story`



### On-call Sev2-able

>Sev2 info:
When will this ticket sev2?
Why can’t this be done now?


>Summary:

>As a sev2-able ticket I alarmed on...

>

>`This section is not meant to be a copy paste of the original autocut ticket, but a new description of the problem in the developers words`

>

>Research

>`Add any notes regarding previously performed research here`

>

>Explanation

>`Add an explination about why this is being moved from on-call to a ticket`

>

>Details:

>`If a wiki is available on how to perform this action, link it here.`

>

>External Links:

>`Link any external tickets/files which may be helpful in this story`

### Bug Ticket - Backlog Input

## Summary:
As a developer I noticed...
>Describe the behavior that is being considered a "bug"
## Research
>Add any notes regarding previously performed research here
## Explanation
Add an explanation about why this may be happening
## Details:
If a wiki is available on how to perform this action, link it here.
## Acceptance Criteria:
This story is completed when:
>Briefly explain how the developer will know when this story is completed. Give specific examples of possible input/output that should be expected from this change
### Current Behavior
>Briefly summarize the current behavior, using Given/When/Then syntax. For each example, ensure that there is a corresponding `Expected` behavior
### Expected
>Give the expected behavior for each of the above current behavior scenarios.
## External Links:
Link any external tickets/files which may be helpful in this story

















* * *
*--wiki-sync: "*[Users/a*ilor/UserStoriesandTickets*](https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets)*"--*

