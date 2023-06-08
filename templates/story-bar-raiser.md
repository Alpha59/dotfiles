# Story Bar Raiser


## Rubric

### Required:

* Has a template been used, and is the template properly formatted?
* Does the Summary start with As a <role> I want... so that...
	* Is the role "Developer", that is ok if this is an OE Ticket.
	* Is the story written from a user perspective, in order to emphasize how this story effects our users?
	* Is the User specific enough? 
* Does the Motivation answer the question “What Greater goal does this story work towards?”
* Does the background information provide enough detail to understand the current functionality or where the request comes from?
* Do the details give enough information that the story can be completed independent of the creator?
* Does details include at least 1 happy path with Given/When/Then syntax?
* Is this story testable?
* Can this story be completed by the team - or are there external dependencies?

### Proficient:

* Does the summary justify the importance of the story, is the summary indisputable?
* Does the Motivation answer the question “Why is this story important for the greater goal?”
* Do the details give enough information that there are no open questions regarding implementation?
* Do the details include all possible paths, including errors with Given/When/Then syntax?
* Do UI changes include any Wireframe or existing screenshots needed as explanation?
* Are inputs/outputs for new APIs, or changed APIs, clearly defined?
* Does the testing section define requirements and present a checklist for the developer?
* Is this story excessively large/vague?
* Is there enough information to point this story, or too many open questions?

### Excellent:

* Do the external links include reliable information from wiki pages or articles that support the technology decisions?
* Do the Details outline every possible path, including errors, happy paths, and user error paths using Given/When/Then syntax?
* Are the details organized and clear with comprehensive information on the topic?
* Are Wireframes properly labeled and details given describing the functionality?
* Are screenshots attached for UI changes which detail how the system is currently functioning?
* Can the defined input/outputs be directly translated to a coral or swagger model?
* Does the story give enough Vision and paint a clear enough picture that a business user will be able to see the benefit to this story and properly prioritize it?
* Does this story have excessive implementation details that will limit a developers ability to be “Creative” or “Experiment“?

### Wanted:

* Flow diagrams or EM or UML diagrams are added to define complex functionality (These should be pulled from design docs)
* Are all possible sources of errors identified?
* Testing Methods, including setup are documented, making them easy to reproduce.

### Writing:

* No spelling, grammar, capitalization or punctuation errors. Sentences are all well-formed.
* All details were unique, interesting, and related to and supported the main idea.
* All ideas were presented in a logical order.
* Introduction was clear, body included many details, and conclusion summarized main idea.
* Writing flowed smoothly throughout.
* Opinions were clearly defined compared to facts.
* All links in the project are labeled and connect to the right place.

### Given
Given steps are used to describe the initial context of the system - the scene of the scenario. It is typically something that happened in the past.

When Cucumber executes a Given step, it will configure the system to be in a well-defined state, such as creating and configuring objects or adding data to a test database.

The purpose of Given steps is to put the system in a known state before the user (or external system) starts interacting with the system (in the When steps). Avoid talking about user interaction in Given’s. If you were creating use cases, Given’s would be your preconditions.

It’s okay to have several Given steps (use And or But for number 2 and upwards to make it more readable).

### When
When steps are used to describe an event, or an action. This can be a person interacting with the system, or it can be an event triggered by another system.

It’s strongly recommended you only have a single When step per Scenario. If you feel compelled to add more, it’s usually a sign that you should split the scenario up into multiple scenarios.

### Then
Then steps are used to describe an expected outcome, or result.

The step definition of a Then step should use an assertion to compare the actual outcome (what the system actually does) to the expected outcome (what the step says the system is supposed to do).

An outcome should be on an observable output. That is, something that comes out of the system (report, user interface, message), and not a behaviour deeply buried inside the system (like a record in a database).

### And, But, * 
If you have successive Given’s, When’s, or Then’s, you could write subsequent lines starting with one of these keywords

### Background
Occasionally you’ll find yourself repeating the same Given steps in all of the scenarios in a Feature.

Since it is repeated in every scenario, this is an indication that those steps are not essential to describe the scenarios; they are incidental details. You can literally move such Given steps to the background, by grouping them under a Background section.

A Background allows you to add some context to the scenarios that follow it. It can contain one or more Given steps, which are run before each scenario, but after any Before hooks.

### Rule
The purpose of the Rule keyword is to represent one business rule that should be implemented. It provides additional information for a feature. A Rule is used to group together several scenarios that belong to this business rule. A Rule should contain one or more scenarios that illustrate the particular rule.

### Tips for using Background
* Don’t use Background to set up complicated states, unless that state is actually something the client needs to know.
* Keep your Background section short.
* Make your Background section vivid.
* Keep your scenarios short, and don’t have too many.

## Process

* Start with the Required section - and make any notes regarding the questions at the bottom of the Document under the heading `Story Notes/Feeback`.  
    * When addressing each section in the summary, note any questions or unknowns that you see - or that a newer team member may not be fully prepared to handle. 
* Make sure that all references to "Previous SIM" or "Previous CR" have links associated, either inline, or in the "External Links" section.
    * Note those questions in the Feedback/Notes. 
* Validate the Markdown Syntax is rendering as expected.
* At this point, I normally fix minor syntax, grammar, or spelling mistakes.
* Move to Proficient section, following the same process as before.
* If there is no feedback for Required/Proficient, repeat the process with "Excellent" and "Wanted" sections
    * Excellent and Wanted can be considered Above and Beyond - so they should not be considered required for approval.
* If the story Meets all Required/Proficient criteria
    * Add the "SBR Approved" label, and move the story from the "Backlog - input" to the "Backlog" folder.  
* If the story has not met the Required Criteria
    * Add a blocking reason of "SBR FB" (Story Bar Raiser Feedback).
* If the Story has met Required, but not proficient, use discretion.
    * This may mean altering a story to help a newer developer or a ESL employee.
    * This may mean approving due to the nature of the story including ambiguity
    * This may mean requesting additional details. 
* Utilize any knowledge of the design/project to challenge assertions or suggest alternative approaches
* Make sure a follow-up ticket exists and is linked if the ticket is "Experimentation" or "First Step" 

### Story Notes/Feedback
*Remove this section after completing feedback*

* Use the `Given/When/Then` format in the Acceptance Criteria section
* Can the summary be written from a user perspective, in order to emphasize how this story effects our users? In general, OE tasks can be Developer focused, but most tasks should not be.
* Use the `As a... I want... So that...` format in the Summary
    * Can the summary be written from a specific user perspective, in order to emphasize how this story effects our users? 
    * Can you be more specific of the user type, it is unclear who cares about this.
* Acceptance Criteria Should not have an `If` statement, this should be broken into multiple AC statements.
* Use a more specific user in the summary? We have a number of different users, and knowing who this feature is targeted at will help give context. 
* Acceptance Criteria Should either be in `Should have`, `Given/When/Then` syntax or any other [Acceptance Criteria format](https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats)  
* In order to shorten stories, we are trying to remove unused sections - for this story I think [Motivation, Testing, External Links] can be removed unless there are additional details to be added
* It's possible that your templates need to be updated, the most recent templates can always be found at the [create issue page](https://sim.amazon.com/issues/create?template=9cdf8b8e-1d10-43f9-a09e-9b0ca7399442) of the `RL Backlog - Input`

* **Remove backtick marks from around your added content, unless it is appropriate for the formatting**
* **Remove `>` marks from before your added content, unless it is appropriate for the formatting**

For more information on criteria used by SBR, please refer to the [Rubric](https://w.amazon.com/bin/view/KOMPAS/DeviceReverseLogistics/TeamLibrary/StoryTemplate/#HRubric)

SBR FB: For Spikes/Mini-designs, use the [template](https://sim.amazon.com/issues/create?template=2a624758-60d9-44ba-930b-37c703466ee4) in order to maintain consistency across our stories. The information needed is all here. 

SBR Story Notes/Feedback: It is fine if Firebolt wants to use a different set of templates - but please add them to the folder configuration so that they remain consistent.


### Legacy Feedback
*Remove this section after completing feedback*
**Due to the fact this ticket was created before the original SB Templates were enforced, this story is not subject to the same scrutiny of formatting, however some additional questions need to be answered before it is ready for implementation**

*This ticket was created before the original SB Templates were enforced and may therefore lack some details required to complete the story*

## Blocked on:

* SBR FB
* Details Needed


## Labels:

* SBR Approved
* SBR Excused

### User Search:
https://sim.amazon.com/issues/search?q=requester%3A(ailor)+status%3A(Open)+isInSprint%3A(False)+next_step.exceptions%3A(Details+OR+SBR)+containingFolder%3A(642918a1-79eb-4712-89aa-678c53598927)


### Config 
https://sim.amazon.com/folders/Devices%20Reverse%20Logistics%20Tech%20-%20Internal/RL%20Backlog%20-%20Input/642918a1-79eb-4712-89aa-678c53598927


* Use this template and fill out the relevant details: 
> 

[Repo] Functional Tests: <original title> https://issues.amazon.com/issues/create?template=0b4898a6-9d26-48eb-9655-a7f501bd2611

(Mini-)Design: <Title> https://issues.amazon.com/issues/create?template=2a624758-60d9-44ba-930b-37c703466ee4	
[<Repository>] Bug: <Title> https://issues.amazon.com/issues/create?template=f36d05b7-e463-4dc7-acdc-e0cf7748df29	

[<Repository>] Sev2able: <Title> https://issues.amazon.com/issues/create?template=16c45b50-a42d-42c6-b2e1-d20a71acf4af	

[<Repository>] <Title> https://issues.amazon.com/issues/create?template=1a24ed4d-4b01-4f20-99f1-c4574e0d0878	

[<Repository>] Manual Cut: <Title> https://issues.amazon.com/issues/create?template=b23eca49-3464-4f53-930f-fe770f2ec535

[<Repository>] AutoCut <Issue Title> https://issues.amazon.com/issues/create?template=d75206c9-f061-48d3-b87c-be2696d5cfba

## Summary SBR

The position of Story Bar raiser is born from a need to improve the quality of tickets and stories created for completion of development work. The Story Bar Raiser (SBR) works in tandem with managers, business partners, and team members to review stories before they are able to be pointed and pulled into the backlog. The SBR is not solely responsible for writing tickets, and works with all stakeholders (including developers) who share the ticket writing responsibility. It is the stakeholders responsibility to meet the standards of the SBR. In order for any story to move into the backlog, the SBR must have reviewed and approved the story. Together in collaboration with the stakeholders, the SBR, and the developers, the goal of the SBR is to improve the overall cohesion and information presented in stories. This allows each team to “Insist on the Highest Standards” from the very begining of any process. Currently, SBR is unique to the Amazon Device Reverse Logistics Team, although the position can be universally applied across any team. 

The SBR is responsible for reviewing all tickets which are created for input to the backlog, and providing appropriate feedback to allow stakeholders to improve the information requested. The SBR also creates and maintains the available templates, and should work with the team, and team management to establish a process for story submission. The SBR should work with the story creator to ensure that the correct, and all relevant, information is being clearly communicated in the story before it moves forward in the process. Individual requirements for stories should be defined by the SBR, and communicated to the stakeholders. 

For more information, including the rubric used by the Amazon Device Reverse Logistics Team Story Bar Raiser, please view check this wiki: https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets/