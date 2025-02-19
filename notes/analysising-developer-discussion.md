# Analyzing a Developer Discussion:

## Logical Fallacies, Bad Faith Arguments, and Fostering Constructive Dialogue

This paper delves into a detailed analysis of a conversation between two developers, "Developer 1" and "Developer 2", centered around 12 rules governing commit messages in a reviewer tool. The discussion revolves around their differing viewpoints on these rules, each providing arguments to support their positions. The examination focuses on points of agreement, disagreement, logical fallacies, and bad faith arguments employed by each participant. The goal is to understand how these elements shape the discourse, and to explore the importance of approaching discussions in good faith for productive outcomes.

## Analysis of the Discussion

The following analysis is of a conversation between two developers, regarding a tool used to enforce coding standards or guidelines. The full text of the conversation can be found in the Appendix.

In the given text, there is a detailed discussion between "Developer 1" and "Developer 2"  regarding 12 rules related to commit messages in a reviewer tool. The two individuals have different viewpoints on these rules and provide arguments to support their opinions. Let's analyze their discussion based on the content provided:

### Points of Agreement:

* Rule: Does not contain exclusive language:
    * Both "Developer 1" and "Developer 2"  agree that this rule is valuable.
* Rule: Starts with a Capital Letter:
    * Both "Developer 1" and "Developer 2"  agree that commit subjects should start with a capital letter, enhancing readability.
* Rule: Separated from body by a new line:
    * "Developer 1" initially disagreed with this rule, but later accepted it after understanding its relevance to how git log treats commit messages.

### Points of Disagreement:

* Rule: Commit should be at least 3 lines:
    * "Developer 1" is concerned about the rule requiring at least 3 lines, as it might not always be necessary to have a commit message with extensive content.
    * "Developer 2"  argues that following this rule is essential to ensure comprehensive information.
* Rule: Does not exceed 72 characters:
    * "Developer 1" disagrees with the rule that commits should not exceed 72 characters, stating that it may not be applicable to their team's context.
    * "Developer 2"  points out that this is a standard guideline, especially when using the git log command.
* Rule: Does not end in punctuation:
    * "Developer 1" disagrees with the rule that commit subjects should not end in punctuation, asserting that some punctuations might be necessary.
    * "Developer 2"  explains that this guideline is to optimize space and adhere to standard practices.
* Rule: Uses imperative voice:
    * "Developer 1" disagrees with the rule that commit messages should use the imperative voice
    * "Developer 2"  believes it improves readability and consistency.
* Rule: First word in subject and body are not the same:
    * "Developer 1" questions the necessity of this rule
    * "Developer 2"  defends it as a good writing style and industry practice.

### Additional Insights:

* Conventional Commits: "Developer 2"  introduces the concept of conventional commits, which include specific prefixes indicating the type of change. Although this isn't directly related to the original 12 rules, it's highlighted as an alternative approach.
* Opinionated Software: "Developer 2"  emphasizes that the tool is opinionated, and its rules are based on certain principles that he believes should be followed for better development practices.
* Context Matters: "Developer 1" often brings up the point that certain rules might not be applicable to their team's context or the way they work within Amazon.

## Logical Fallacies and Bad Faith Argument

Going through the conversation, we can identify the logical fallacies and bad faith argument types used by each party.

### Logical Fallacies:

Logical fallacies are errors in reasoning that can make an argument invalid, misleading, or unsound. They often involve flaws in the structure of an argument or the use of irrelevant or misleading information. Logical fallacies can manipulate or deceive the audience by appealing to emotions, biases, or other factors rather than relying on solid evidence and sound reasoning. Recognizing and understanding logical fallacies is important for critical thinking and evaluating the validity of arguments.

### Bad Faith Arguments:

A bad faith argument refers to an argument made intending to deceiving, misleading, or arguing dishonestly. It involves using tactics such as misrepresentation, cherry-picking evidence, ignoring counterarguments, or employing logical fallacies to advance a specific agenda or viewpoint. Engaging in bad faith arguments undermines genuine discourse and honest debate, as it prioritizes winning over truth-seeking and rational discussion. It's essential to approach arguments in good faith to promote constructive and meaningful conversations.

### Logical Fallacies and Bad Faith Argument Types Used by "Developer 1":

1. **_Straw Man_:** "Developer 1" misrepresents "Developer 2" 's argument and sets up a weaker version of it to refute.

    * **Misrepresenting an opponent's argument in a way that makes it easier to attack and then attacking the misrepresented argument rather than the actual one**
    * "Developer 1": "If needed, the CR tool will ask for, and ...” and all of its subtree.
    * "Developer 2" : "the CR tool does ask for the SIM, and DOES attach it to the commit...? Your argument is that the tool should do this, and it does."
        * "Developer 1": "When I’m using the tool, it does not. Please have screenshots of how it does."

1. **Cherry-Picking:** "Developer 1" selectively chooses information that supports their point while ignoring relevant counterpoints.

    * **Selectively presenting only those facts or arguments that support your position while ignoring or omitting those that contradict it**
    * "Developer 1": "This is from famous Linus on 2012, with 50 upvote and 8 downvote."
    * "Developer 1": "And I don’t agree that the summary line is a title. I don’t see this in git doc either."

1. **Appeal to Ignorance:** "Developer 1" argues that certain rules should not apply unless "Developer 2"  provides logical proof or sources for those rules.

    * **Claiming that a statement is false because it has not been proven true, or vice versa**
    * "Developer 1": "I won't agree with it, unless there's logic, or reachable trustable source."
    * "Developer 1": "I don’t think a subject saying something is always 20 or more characters long, but I’m OK when it’s triggered, it makes a comment to 'ensure you’ve said something'."

1. **Moving the Goalposts:** "Developer 1" raises new criteria or requirements after "Developer 2"  provides explanations or sources.

    * **Continuously changing the criteria of an argument to make one's position easier to defend**
    * "Developer 1": "As said, not all 12 rules discussed here are from git community."
    * "Developer 1": "If git doesn’t enforce that internally, they must have their reason."
    * "Developer 1": "For these following rules, I think they need to be configurable (if they pass the use/not-use test)"

1. **Hasty Generalization:** "Developer 1" makes broad claims based on anecdotal evidence.

    * **Drawing a broad conclusion based on insufficient or biased evidence**
    * "Developer 1": "As above screenshot, recently in DRBS, no one except "Developer 2"  ever included commit message body."
    * "Developer 1": "There's no chance that you can make this correct with legacy code"

1. **_Appeal to Authority_:** "Developer 1" questions "Developer 2" 's trustworthiness as an authority on certain topics.

    * **Using the opinion of an authority figure, as evidence in support of an argument**
    * "Developer 1": "Let me be clearer: **Amazon** has a status means the context where the rules will be applied, have the status."
    * "Developer 1": "There is no **Amazon** internal page declaring that."
    * "Developer 1": "Outside **Amazon**, there's no chance that any document recommends that because SIM is an **Amazon** internal thing."
    * "Developer 1": "**Amazon** has internal Coverlay and Checkstyle tool. People do that because it’s preferred by **Amazon** workmates."

1. **_Ad Hominem_:** "Developer 1" questions "Developer 2" 's motives or character rather than addressing the argument.

    * **Attacking the character or personal traits of an individual who is making an argument instead of addressing the substance of the argument itself**
    * "Developer 1": "**My trustable source**, please show me how it is good."
    * "Developer 1": "Thanks for your **personal opinion** of SIM."
    * "Developer 1": "**You yourself** has 31% commits that has no commit message body, while **you’re** declaring that they should have."
    * "Developer 1": "This is from **famous** Linus on 2012, with 50 upvote and 8 downvote."

1. **_Appeal to Emotion_:** "Developer 1" uses emotional language to manipulate the reader's feelings, without providing a counter.

    * **Manipulating an emotional response in place of a valid or compelling argument**
    * "Developer 1": "Strongly disagree with it."
    * "Developer 1": "I don’t agree with all of them."
    * "Developer 1": "I don’t see this standard be defined, and I don’t believe it."

1. **_False Dichotomy_:** "Developer 1" presents a situation as having only two possible outcomes, when there may be other options.

    * **Presenting a limited set of options, often two, when there are other possibilities that exist or have not been considered**
    * "Developer 1": "Should it be named 'Contains CR link'?"
    * "Developer 1": "When I’m writing the CR, I think 1 CR can better explain the change, comparing to 2."
    * "Developer 1": "It’s not universality, because Amazon CR provides much more function than commit message could do"

1. **Begging the Question:** "Developer 1" assumes that the conclusion is true without providing supporting evidence.

    * **Assuming the conclusion of an argument is true without providing any real evidence for the conclusion**
    * "Developer 1": "Why is that bad? Although I won’t do, because when I need to do that, I don’t put body."

1. **_Appeal to Tradition_:** "Developer 1" argues that certain practices are valid because they have been used in the past.

    * **Arguing that something is right or acceptable because it has been done a certain way for a long time**
    * "Developer 1": "No one except "Developer 2"  ever included commit message body. Moreover, you yourself has 31% commits that has no commit message body"

1. **Bandwagon Fallacy:** "Developer 1" suggests that because other people have not followed certain rules, those rules are not valid.

    * **Suggesting that an idea or course of action is correct or acceptable because many other people are doing it or agree with it**
    * "Developer 1": "As above screenshot, recently in DRBS, no one except "Developer 2"  ever included commit message body."

1. **_Anecdotal Evidence_:** "Developer 1" relies on isolated examples or personal experiences to support their arguments.

    * **Using personal anecdotes or isolated examples instead of sound reasoning or comprehensive evidence**
    * "Developer 1": "As above screenshot, recently in DRBS, no one except "Developer 2"  ever included commit message body."

1. **_Loaded Question_:** "Developer 1" frames questions in a way that assumes certain facts not yet established.

    * **Asking a question that contains a controversial or unjustified assumption, intended to trap someone into taking a position they didn't intend to take**
    * "Developer 1": "Should it be named 'Contains CR link'?"
    * "Developer 1": "Could we remove this, after having the rule of “validate CR link”?“
    * "Developer 1": "To use a better CR template, we can’t enjoy this fact. Let’s focus on “any items you think better not in CR [Template]”?“

1. **Appeal to Personal Experience:** "Developer 1" uses their personal experiences to dismiss or reject certain rules.

    * **Using one's personal experience as evidence for a claim, ignoring other potentially relevant evidence**
    * "Developer 1": "Here’s my test: ... I don’t accept reading it as 'when applied'."

1. _**Tu Quoque**_: This fallacy attempts to divert attention from the argument by suggesting that “Developer 1'”s actions are inconsistent with their position.

    * **A technique that intends to discredit the opponent's argument by attacking the opponent's own personal behavior and actions as being inconsistent with their argument**
    * "Developer 1": "No one except "Developer 2"  ever included commit message body. Moreover, you yourself has 31% commits that has no commit message body"

### Logical Fallacies and Bad Faith Argument Types Used by "Developer 2" :

1. **_Appeal to Authority_:** "Developer 2"  references well-known figures to support his argument.

    * **Using the opinion of an authority figure, as evidence supporting an argument**
    * "Developer 2" : "As **Linus Torvalds**, the creator of Git, suggests..."
    * "Developer 2" : "From **Chris Beams** (A senior engineer on Java Spring)"
    * "Developer 2" : "Especially if it’s something your **direct manager** has declared usefulness in."
    * "Developer 2" : "If your **management** said “Write good commit messages”, you’d be on-board?“

1. **_Straw Man_:** "Developer 2"  misinterprets "Developer 1"'s argument opposing the use of ticket IDs.

    * **Misrepresenting an opponent's argument in a way that makes it easier to attack and then attacking the misrepresented argument rather than the actual one**
    * "Developer 2" : "your argument is that the tool should do this, and it does."

1. **_Ad Hominem_:** "Developer 2"  submits "Developer 1" is not conforming to team standards.

    * **Attacking the character or personal traits of an individual who is making an argument instead of addressing the substance of the argument itself**
    * "Developer 2" : "It’s your duty to also conform to team standards."
    * "Developer 2" : "You are the only person on the team who was there when we decided as a team"

1. **Appeal to Consequences:** "Developer 2"  argues that adhering to the rules would result in better communication.

    * **Arguing that something must be true or false based on the positive or negative consequences of it being true or false**
    * "Developer 2" : "Tickets are the standard way of communicating changes to developers and non-developers. Commits are the standard way of communicating code changes."

1. **_Appeal to Tradition_:** "Developer 2"  references industry practices to support his viewpoint.

    * **Arguing that something is right or acceptable because it has been done a certain way for a long time**
    * "Developer 2" : "It's a pretty standard practice in the industry to keep commit subjects under 72 characters."

1. **_False Dichotomy_:** "Developer 2"  presents two options as the only choices.

    * **Presenting a limited set of options, often two, when there are other possibilities that exist or have not been considered**
    * "Developer 2" : "The options are to follow the rules or don’t."

1. **Appeal to Practicality:** "Developer 2"  argues for the practical benefits of following certain rules.

    * **Arguing for the validity of a claim based on its practical benefits or consequences**
    * "Developer 2" : "It’s an opinionated tool designed to enforce standards."

1. **Circular Reasoning**: This statement essentially restates the premise without providing any new evidence or justification.

    * **Arguing in a way that both the premise and conclusion rely on the other's truthfulness: A is true because B is true.**
    * "Developer 2": "Commits are the standard way of communicating code changes."

1. _**Appeal to Emotion**_: By appealing to "Developer 1"‘s emotional response to management directives, "Developer 2" is attempting to manipulate "Developer 1"'s feelings rather than addressing the substance of the argument.

    * **Manipulating an emotional response in place of a valid or compelling argument**
    * "Developer 2": "If your management said 'Write good commit messages', you’d be on-board?"

1. **_Anecdotal Evidence_:** “Developer 2” relies on his personal experiences as evidence to support his argument.

    * **Using personal anecdotes or isolated examples instead of sound reasoning or comprehensive evidence**
    * “Developer 2”: "I often find that commit messages following these rules are more informative.

1. _**Tu Quoque**_: This fallacy attempts to divert attention from the argument by suggesting that “Developer 1'”s actions are inconsistent with their position.

    * **A technique that intends to discredit the opponent's argument by attacking the opponent's own personal behavior and actions as being inconsistent with their argument**
    * “Developer 2”: "You are the only person on the team who was there when we decided as a team."

1. _**Loaded Question**:_ Attempts to trap “Developer 1” into a position that may not accurately represent their viewpoint.

    * **Asking a question that contains a controversial or unjustified assumption, intended to trap someone into taking a position they didn't intend to take**
    * Jake: "Could you explain why you're against a commit message having a structure?"

1. **Confirmation Bias**: “Devloper 2” selectively presents information that supports his argument, while ignoring potential counterexamples or other studies that might present a different perspective.

    * **Confirmation bias is the tendency to search for, interpret, favor, and recall information in a way that confirms or supports one's prior beliefs or values.**
    * “Developer 2”: "Here's a study that shows teams with standardized commit messages have fewer code defects."

1. **Equivocation**: “Developer 2” uses the term "useless" in two different senses here, making it seem as if "Developer 1" is making an absolute claim when their argument was more about the applicability and necessity of certain rules.

    * **The fallacy of equivocation occurs when a key term or phrase in an argument is used in an ambiguous way**
    * Jake: "You're saying that these rules are useless, but what if they make your life easier?"

1. **Appeal to Popularity**: “Developer 2” implies that because these rules are followed in multiple places, they must be valid or effective.

    * **The appeal to popularity fallacy is made when an argument relies on public opinion to determine what is true, right, or good****.**
    * “Developer 2”: "Everywhere I've worked, these rules are followed."

1. **Red Herring**: By redirecting the discussion away from team practices to industry standards, “Developer 2” introduces a new topic that's tangentially related but doesn't directly address the points being debated.

    * **A red herring fallacy refers to an attempt to change the subject and divert attention from the original issue.**
    * “Developer 2”: "Let's not get bogged down in the specifics of our team's practices. We're discussing industry standards here."

## Respectful Disagree and Commit

Approaching an argument with good faith is essential for fostering constructive and meaningful discussions. Here's how you can do it:


1. **Listen Attentively:** Pay close attention to the other person's perspective, without immediately formulating counterarguments in your mind.
2. **Assume Honesty:** Give the other person the benefit of the doubt. Believe that they are expressing their genuine beliefs and feelings, even if you disagree.
3. **Stay Calm and Respectful:** Keep the tone civil and respectful. Avoid personal attacks, insults, passive-agressiveness, or condescension.
4. **Ask Questions:** Seek clarity by asking open-ended questions about their viewpoint.
5. **Find Common Ground:** Identify areas of agreement or shared concerns. This sets a positive tone for the conversation and can lead to more productive exchanges.
6. **Be Open to Changing Your Mind:** Be willing to adjust your stance if the other person presents compelling evidence or reasoning.
7. **Avoid Trolling or Provoking:** Don't use inflammatory language or tactics to provoke the other person. Focus on the merits rather than trying to "win" the conversation.
8. **Know When to Disengage:** If the discussion becomes unproductive, repetitive, or hostile, it's okay to disengage respectfully.

Engaging in good faith discussions doesn't necessarily mean you have to agree with the other person. It means you're committed to a respectful and open exchange of ideas that promotes understanding and learning, even in the face of disagreement. Avoiding logical fallacies requires careful thinking and communication. Here's how to steer clear of them:


1. **Educate Yourself:** Familiarize yourself with common logical fallacies, so you can recognize them when they occur.
2. **Engage in Self-Reflection:** Regularly evaluate your arguments for any signs of fallacies. Be honest with yourself about your reasoning.
3. **Ask for Clarification:** If someone's argument seems unclear or ambiguous, ask them to clarify their points before responding.
4. **Be Open to Change:** Be willing to change your mind if presented with convincing evidence, even if it means letting go of an argument you previously supported.
5. **Use Counterexamples:** Test your arguments by trying to think of counterexamples that could disprove your point.
6. **Break Down Complex Issues:** Some fallacies thrive in complex, convoluted discussions. Break down the topic to simpler components to prevent fallacious reasoning.
7. **Don't Oversimplify:** Avoid reducing complex issues to black-and-white or overly simplistic terms.
8. **Consider Intent:** Be mindful of whether you're genuinely trying to reach the truth, or if you're more focused on "winning" the argument.

Avoiding logical fallacies takes practice and self-awareness.

## Amazon and Appeal to Ignorance

Over the past 4 years, the team in question has seen many changes. One thing that has not changed, is the use of the "Appeal to Ignorance" argument as a way to disagree without reasoning. This methodology has been utilized as a way to prevent projects moving forward, prevent mechanism changes, or prevent good faith discussions. SDEs, TPMs, and SDMs have used this argument as a way to prevent the opinions of others moving forward.

The "Appeal to Ignorance" is a logical fallacy that occurs when someone argues that a proposition must be false simply because it hasn't been proven true or vice versa. In the context of team discussion, this fallacy is manifested when team members dismiss an argument or position by demanding concrete facts from specific sources and rejecting anything that lacks immediate substantiation. They fundamentally argue that unless something can be proven beyond doubt at that moment, it must be false. This fallacy is often paired with other fallacies (emotion, authority) to stop discussions from happening.

This fallacy is problematic for several reasons:

1. **Burden of Proof Shift:** Appeal to Ignorance shifts this burden unfairly onto the opposing side.

    * This demands that the person with the new idea or argument prove it conclusively, even though the burden of proof should be shared.

1. **Stifling Innovation and Exploration:** Demanding immediate concrete facts can stifle innovative thinking and the exploration of new ideas.

    * Progress often depends on considering and discussing concepts that may not have been fully fleshed out or backed by solid evidence yet.

1. **Complexity of Proof:** Ideas, related to complex topics or future trends, cannot be proven or disproven with immediate concrete facts.

    * Requiring such proof disregards the nuances and intricacies of certain subjects.

1. **Erosion of Trust:** Demanding immediate proof can erode trust within a team.

    * It creates an atmosphere of skepticism and suspicion, making team members hesitant to share novel ideas for fear of being dismissed out of hand.

1. **Slowing Progress:** The insistence on immediate proof leads to analysis paralysis.

    * Valuable time and energy are wasted in trying to provide foolproof evidence rather than focusing on productive discussions and collaborations.

1. **Missed Opportunities:** Breakthroughs and insights emerge from speculative or preliminary discussions.

    * Dismissing ideas too early due to lack of immediate proof can lead to missed opportunities.

To foster a productive and innovative team environment, it's important to approach discussions in good faith and with an understanding, that not all ideas need to be fully proven at the outset. Instead of defaulting to an **Appeal to Ignorance**, team members should engage in open-minded and respectful exchanges, allowing ideas to be presented, refined, and critiqued over time. This approach encourages the exploration of new concepts, maintains trust among team members, and allows for more comprehensive and forward-thinking discussions.

## Final Thoughts:

Throughout the discussion, both parties engage in various logical fallacies and bad faith argument types to defend their viewpoints. The conversation showcases how biases, emotional responses, and appeals to authority can play a role in shaping arguments. It also demonstrates how differing opinions can lead to a lack of agreement, even when discussing specific standards and practices within a development team.

The discussion revolves around the effectiveness, necessity, and applicability of each rule within the reviewer tool. "Developer 1" is focused on tailoring the rules to their team's specific needs and highlighting instances where certain rules might not be suitable. "Developer 2", on the other hand, argues for standardization and adherence to best practices in commit messages. The discussion reflects the challenges of balancing standardized practices with team-specific workflows and preferences.

In scrutinizing the dialogue between "Developer 1" and "Developer 2", it becomes evident that the use of logical fallacies and bad faith arguments can significantly hinder productive discourse. The conversation highlights the importance of approaching discussions with open-mindedness, respect, and an eagerness to learn. By acknowledging the fallacies and pitfalls that can arise in debates, individuals can work towards fostering an environment where differing opinions can coexist and contribute to meaningful progress. Recognizing the potential biases, emotional responses, and manipulation tactics that can emerge in discussions allows us to engage in healthier and more constructive conversations. As the analysis of the developer discussion illustrates, honest engagement, respectful disagreement, and a commitment to understanding the perspectives of others are essential for productive discourse and collaborative problem-solving.

## Appendix

### Full Conversation

Note: Screenshots and references to the original authors were removed to support anonymity.

# Discussion of 12 rules in Commit Message Analysis

* Rule: Commit should be at least 3 lines
    * "Developer 1" : I won't agree with it, unless there's logic, or reachable trustable source.
    * ~~"Developer 2" : This is documented in the Git Manual as to why.~~
        * "Developer 1" : This is false.
    * "Developer 2" : Ok, you don’t have to do this. But if you follow the rest of the rules - then this will pass.
    * "Developer 1" : Unimportantly, I need reason about why it passes.
        * "Developer 1" : If because of CR tool’s adding CR link, question:
            * "Developer 1" : When having multiple commits, only 1 will have CR link. Will this tool respect the fact that only 1 commit has at least 3 lines?
                * "Developer 2" : You should only have 1 commit per CR. Otherwise it should be multiple CRs
                * "Developer 1" : Here is an example [CR-97472990](https://code.amazon.com/reviews/CR-97472990/) that 2 commits declaring 1 thing. They’re closely related, and making the into 1 CR is better for understanding. In this way, it hides a middle [step](https://code.amazon.com/packages/DeviceReturnsConstructs/commits/cc07b2aaaae988e4c8573604ceca036b3f5addcf#), which does not help understanding the CR, but this step is needed when deploy using CloudFormation.
                * "Developer 2" : This is a matter of opinion, but in my opinion, having those as 2 different commits in the history just makes the commit history harder to follow. You accomplished a single goal with your change.
                * "Developer 1" : The problem is, there is no way no can make it work with 1 commit. You need to deploy 1 commit, then the other. Deploying 2 together will fail.
                * "Developer 2" : Then they should be 2 separate CRs so that they can be merged and pushed separately. And both commit messages should express their dependency on the other.
                * "Developer 1" : Why they should be? When I’m writing the CR, I think 1 CR can better explain the change, comparing to 2. And the CR tool allows my this use-case.
                * "Developer 2" : This doesn’t really matter - since both of the Commits will be looked at separately. So the commits both need to match the criteria. This is a different thing entirely.
                * "Developer 1" : If both commits are looked at separately, the one without CR link will have only 1 line, and this rule will cause problem.
                * "Developer 2" : Both commits should contain the SIM link, Subject, and Body. So this won’t be an issue.
                * "Developer 1" : No, none of them should contain the SIM link. We can discuss this in rule 2.
                * "Developer 1" : This is sometimes an issue when there is no SIM-link, and no commit message body. I usually don’t do, and I don’t believe that a commit message should always contain a body.
                * "Developer 1" : Recently in a package, no one except "Developer 2"  ever included commit message body. Moreover, you yourself has 31% commits that has no commit message body, while you’re declaring that they should have.
            * "Developer 1" : Should it be named “Contains CR link”?
                * "Developer 2" : No, because that’s not what it’s checking.
                * "Developer 1" : With that checked, this rule will be meaningless, and could introduce confusion about why it’s here. Could we remove this, after having the rule of “validate CR link”?
                * "Developer 2" : The rule remains valid, as This enforces that there are at least 3 sections split into different lines.
                    * "Developer 2" : Subject
                    * "Developer 2" : Body
                    * "Developer 2" : Footer (meta-data like links).
                * "Developer 1" : Why does a commit message always need to have body and footer?
                * "Developer 2" : The Body is the description of what the change is - and the footer is the meta data about the commit (like ticket and CR link).
                * "Developer 1" : While I agree 1 of the commit need to have the CR link, I don’t see enough reason why all commit messages must have footer. And I don’t see why any commit message must have body.
                * "Developer 2" : What does [this commit](https://code.amazon.com/packages/DeviceReturnsBorderService/commits/8b83f4ab2dfcfd6717a03043559cac827f3995b0#) do, what is the purpose of it?
                    * "Developer 2" : Was this a bug or a feature?
                    * "Developer 2" : Was this an idea from a developer, or was this something that came from another source?
                        * I"Developer 2" : f from another source, was it because of an ongoing project, or just a feature request?
                    * "Developer 2" : Who is impacted by this change - and are there other related software changes?
                * "Developer 2" : I don’t get any of that information from the Commit - and to understand what it’s doing I would have to read the code.
                * "Developer 1" : actually, for this specific example, it has link to CR. There, some of your questions are answered, including
            * Should it really validate CR link’s format, just as it did to issue ID now?
                * "Developer 2" : This would be a good addition to the tool. I would support adding this as a 13th rule.
* Rule: Contains Ticket/Issue ID
    *  "Developer 1" : strongly disagree with it.
        * "Developer 1" : Many git commits for fix/patches has no tickets, and are just because people observed things to fix.
            * "Developer 2" : They should create a ticket.
            * "Developer 1" : Why is that please?
            * "Developer 2" : Because we are professionals working in a professional industry that need to provide documentation for our actions. Tickets are the standard way of communicating changes to developers and non-developers. Commits are the standard way of communicating code changes. They serve 2 different purposes, and thus have 2 different formats.
            * "Developer 1" : I don’t agree with all of them.
                * "Developer 1" : “Tickets are the standard way of communicating changes to developers and non-developers.”
                    * "Developer 1" : I don’t see this standard be defined, and I don’t believe it. In my understanding:
                        * "Developer 1" : Tickets are the primary way for communication between request requester and request resolvers.
                        * "Developer 1" : When they’re the same person, until explicitly required, there is no need to create a ticket.
                        * "Developer 2" : This is a fundamental documentation thing. It’s the same reason that you name variables with meaningful names - because 2 years later, you may not remember your reasoning or logic. It is also documenting for Business and Management so that If you are not available to explain the change, the Ticket contains that information
                        * "Developer 1" : They are exactly different. The good naming and logic are stored in CR, so that’s why they exactly should not be stored in ticket. There are many examples where a ticket is not needed.
                        * "Developer 2" : All our work should be based on a ticket. Even if that ticket is created just so that you can work on something. That’s the point of the unplanned work. We are a team, not a single person working on a project. We need some way to communicate and track our work.
                * "Developer 1" : “Commits are the standard way of communicating code changes”
                    * It was, but for Amazon’s current status, CR is the standard way for code changes, because it has more support, with its many tabs. Commits can’t support providing that many information as CR does.
                    * "Developer 2" : Every company has some form of CR/PR/Change process. The universality of it is that the change is always documented in git. This allows people to view the changes both in git and in the CR tool.
                    * "Developer 1" : It’s not universality, because Amazon CR provides much more function than commit message could do, and that’s my in Amazon, CR for now in 2023 is still the standard way. There’s no way so far in 2023 for git commits to provide the same supports that Amazon CR does.
                    * "Developer 2" : But Amazon CR is still a git tool. Just like GitHub and GitLab... it’s all just wrappers around Git?
        * "Developer 1" : There is no Amazon internal page declaring that.
            * "Developer 2" : There is no Internal Amazon page declaring that I shouldn’t spit on my coworkers computer - but It’s common sense that I shouldn’t.
            * "Developer 1" : It’s my common sense that we should NOT do that, because as my reasoned later.
            * "Developer 2" : I don’t see any reasoning why we wouldn’t.
            * "Developer 1" : This: “If needed, the CR tool will ask for, and ...” and all its subtree.
            * "Developer 2" : the CR tool does ask for the SIM, and DOES attach it to the commit...? Your argument is that the tool should do this, and it does.
            * "Developer 1" : When I’m using the tool, it does not. Please have screenshots of how it does.
            * "Developer 2" : It asks me for the SIM - appends the SIM and CR link to the commit message, populates the CR description with the Commit Message - and then even attaches a second link to the SIM in the CR Description.
        * "Developer 1" : Outside Amazon, there's no chance that any document recommends that, because SIM is an Amazon internal thing.
            * "Developer 2" : It doesn’t say SIM. It says Ticket/Issue ID. Because almost every company in the world tracks issues/stories/something.
            * "Developer 1" : One of the reason is, they don’t have a better tool. Amazon has.
            * "Developer 2" : SIM is one of the worst ticket tracking tools I have used in my career. Most people want a reference to a ticket or issue in some way so that they can relate the change back to a business purpose.
            * "Developer 1" : Thanks for your personal opinion of SIM. And thanks for your opinion that “other company have better ticketing tools than SIM, so they refer to their ticketing tool in git commit message”. This is off-topic, because I said “SIM”, while the rule does not. So this reason for “git-message should not contain SIM ID” does not hold. Sorry for having raised it, and let’s focus on other reasons.
        * "Developer 1" : If needed, the CR tool will ask for, and append it, but the CR tool is not.
            * "Developer 1" : And the CR tool appends CR link in the commit message. The CR description is the place for SIM ticket link, if exists.
            * "Developer 2" : Why? Is that documented somewhere as being better than having it in the commit message? Because I would disagree that the CR is the place to document anything.
            * "Developer 1" : CR has a description tab, and many other tabs. It is designed to contain all informations. Please list all items that you think better not in CR, and why.
            * "Developer 2" : Fun fact, if you don’t use a CR template when you create a CR, it populates the CR Description with the Commit Body. That’s what I do. Then you can add additional information as needed to the CR Description tab.
            * "Developer 1" : Then what’s your reason of not using a CR template? Mine has many options to check, which can’t fit into git commit message. To use a better CR template, we can’t enjoy this fact.
                Let’s focus on “any items you think better not in CR”?
            * "Developer 2" : The CR template is widely ignored in practice.
                * "Developer 1" : Please prove this with data.
            * "Developer 1" : As said, “Please list all items that you think better not in CR, and why.”
* Rule: Does not contain exclusive language
    * "Developer 1" : Agree
    * "Developer 2" : This has just as much “logic or source” support as anything else. Why agree here.
    * "Developer 1" : Because I know the logic behind it.
    * "Developer 2" : Which is? What is the Logic behind not using exclusive language? Can you provide documentation on why we should not do that in our Commit Messages?
    * I"Developer 1" :  don’t want to spend my time it for now. But if you refuse to have this rule in your tool, I’ll let you do first, and discuss to add it back after your tool is in use.
    * "Developer 2" : That’s not my point. My point is that you are accepting this rule without any logic or reason - you are accepting this because, in your opinion, you agree. That is antithetical to the purpose of this thread.
    * "Developer 1" : OK, my formal reason is, this is lead by our orgs higher management, and I don’t see tech problems in this decision.
    * "Developer 2" : Ok, so... if your management said “Write good commit messages”, you’d be on-board?
    * "Developer 1" : Yes, definitely. Both because it’s from my management, and because it aligned with my many years’ experience as software engineer.
* Rule: All words are spelled correctly
    * "Developer 1" : I strongly disagree with it.
        * "Developer 1" : There's no chance that you can make this correct with legacy code.
            * "Developer 1" : Even with Microsoft Office which is good at text processing, there's option to "add to dict" or "ignore".
            * "Developer 2" : Microsoft Word isn’t a place where I write code - so I wouldn’t know.
            * "Developer 1" : You can know it by trying, or any other editor that you think is professional at text processing. I know none that has a syntax check, and don’t need regular adjustment with exceptions. If you do, let’s research to pick out its dictionary.
            * "Developer 2" : I don’t understand your point here. Why would we NOT want the words spelled correctly. This is just a basic courtesy so that people can understand what is being said.
            * "Developer 1" : If you read the branch carefully, I said “There's no chance that you can make this correct with legacy code”. I suppose you may do that with AI, but not with legacy code. You can wish for it, but you can't achieve it, without blocking others from time to time, if the behavior is blocking the CR.
        * "Developer 1" : Especially in the area of software engineer, where there are many crafted words.
            * "Developer 2" : Spelling is not enforced for non-dictionary words.
            * "Developer 1" : How does it ensure “All words are spelled correctly” please? My assumption is “it checked every word with dictionary. If not in, error”. Do you mean “if a word in dict, OK; otherwise, ignore”?
            * "Developer 2" : If you ever get a spelling violation for a word that you think should not be a violation - I will remove this rule.
            * "Developer 1" : Thank you for having removed it on 2021-09-22 in [0e488a8](https://code.amazon.com/packages/CommitMessageAnalyzer/blobs/6a40c086ef51f932172bcf97db069bc68886f01f/--/src/commit/index.py#L102-L113). Is it better if you remove this from the description, if your program is not actually checking it?
* Rule: Lines do not exceed 72 characters
    * "Developer 1" : I strongly disagree with it.
        * "Developer 1" : (It is really in your provided git link, but its said context is different from Amazon, or our team.)
            * "Developer 2" : Amazon is not special. Amazon does not own Git. Just because Amazon does something doesn’t mean it’s write or good.
            * "Developer 1" : Let me be clearer: Amazon have a status means the context where the rules will be applied, have the status. The word is “Amazon” here, but we can replace it with “where the tool is to be used, and where the people who use the tool stays”.
            * "Developer 1" : Following that, I think the conclusion given in git-doc is not applicable to us, because of these difference:
                * "Developer 1" : The git-doc said “Wrap it to about 72 characters or so.”, which is directly related to 80-char-wide terminals. These is not widely used in Amazon, and is not widely used in team. Many years ago, even for code style, there’s discussion to define long code as “120 chars”, from our team. (Show me 80-char-wide terminals we used if I missed some cases)
                    * "Developer 2" : This is because if you do `git log` it shows it in an 80 character wide terminal. If you are not using `git log` because you have a visual studio tool, then that’s fine - but the standard is still `git log` and other `git cli` tools. This has nothing to do with an older methodology or updated tools.
                    * "Developer 1" : It did not in my test, as screenshots below.
                * "Developer 1" : All tools I know that our team or Amazon used, has auto-line-wrap. Comments, compared to code, is more suitable to auto-line-wrap. (Show me examples of auto-line-wrap not look properly if I missed some cases)
                    * "Developer 2" : Actually, the CR tool cuts off the commit subject at 80 characters in the title.- after prepending the repository name. This does apply.
                    * "Developer 1" : So git log did not have problem with it (as screenshots below), and the CR tool will actively handle it in a way (as you said), then making it as clear as possible the duty of software engineer. This rule should not block that.
        * "Developer 1" : This rule sometimes go against "describe thing clear". If that happened, I'll always prefer make things clearer. (so even in its original context, I still don't agree with it)
            * "Developer 2" : This is the point of the Body
            * "Developer 1" : If the user can make things clear in the title, why do we put unnecessary limitations on title, and encourage the user to make things short in title, and make things clear only in body?
            * "Developer 2" : The same reason that you don’t put your entire email into the subject line? The Subject is the What, the Body is the Why and How.
            * "Developer 1" : Even for “what”, “you can be as descriptive as you want” and “length is limited” are totally different.
    * "Developer 2" : This is because `git log` wraps body the body if it’s too long
        * "Developer 1" : Here’s my test:
        * "Developer 1" : The selection is 88 characters, and it’s not wrapped.
        * "Developer 1" : Please bring me a case that it wrapped, and caused problem.
        * "Developer 1" : Thanks for the screenshot. Please let me know how you triggered this auto-wrap, and how it is a problem.
        * "Developer 2" : Idk, maybe my machine is UNIX based so it uses a different version of Git. Mine just does this.
    * "Developer 2" : From [Chris Beams](https://cbea.ms/git-commit/#seven-rules) (A senior engineer on Java Spring)
        * "Developer 1" : Thanks for the link. What they said is “Git never wraps text automatically. When you write the body of a commit message, you must mind its right margin, and wrap text manually. The recommendation is to do this at 72 characters, so that Git has plenty of room to indent text while still keeping everything under 80 characters overall.”
            So my question: why does git never wrap is a problem? Why does they try to keep everything under 80 characters in 2014?
        * "Developer 2" : Here is some information from [Linus on the subject](https://github.com/torvalds/linux/pull/17#issuecomment-5661185)
        * "Developer 1" : This is from famous Linus on 2012, with 50 upvote and 8 downvote. In the middle he said “Anyway, you are obviously free to do your commit messages any way you”.
        * "Developer 2" : As i’ve said many time. You can do whatever you want.
* Rule: First word in subject and body are not the same
    * "Developer 1" : I won't agree with it, unless there's logic, or reachable trustable source.
    * "Developer 2" : This is to prevent you from putting the subject and body as the same thing.
        * "Developer 1" : Why is that bad? Although I won’t do, because when I need to do that, I don’t put body.
        * "Developer 2" : Because the Commit Subject is the What, the Body is the How and Why. And it’s just a bad writing style.
        * "Developer 1" : I don’t accept a descriptive “bad” without data. With having CR tool in Amazon, I put “how” and “why” in a more displayable format: in CR, where we can use format and image.
        * "Developer 2" : I don’t accept “I won’t agree” unless you can provide data that it is better to not have it that way.
    * "Developer 2" : Am I not a trustable source?
        * "Developer 1" : You are, so if you show me some proving that I don’t understand, I’ll trust you. (If I understand it, I’ll validate it, because it’s my duty to be responsible for company/customer)
        * "Developer 2" : And the team. It’s your duty to also conform to team standards. Especially if it’s something your direct manager has declared usefulness in.
        * "Developer 1" : Sure, manager is a good source that I trust. The reasons I’m here are:
            * "Developer 1" : As one of the team member, I did not approve this. I actually didn’t know this tool or when is it introduced.
                * "Developer 2" : Actually, you did approve this. You are the only person on the team who was there when we decided as a team, under the previous SDM that adding this tool was a good way to increase understanding of what people were doing...
            * "Developer 1" : My manager did not recommend using this.
        * "Developer 1" : My trustable source, please show me how it is good.
* Rule: Subject Line:
    * Rule: Does not exceed 50 characters
        * "Developer 1" : Disagree, unless logic or source.
        * "Developer 2" : This is because `git log` wraps body the body if it’s too long
            * "Developer 1" : As proved above.
        * "Developer 2" : From [Chris Beams](https://cbea.ms/git-commit/#seven-rules) (A senior engineer on Java Spring)
            * "Developer 1" : Thanks for the link. What they said is “50 characters is not a hard limit, just a rule of thumb.”
            * "Developer 1" : I’m OK if this tool will make a comment when it’s triggered, but not blocking the CR approval workflow.
    * Rule: Is at least 20 characters
        * "Developer 2" : This is to enforce that the subject says something.
        * "Developer 1" : I don’t think a subject saying something is always 20 or more characters long, but I’m OK when it’s triggered, it makes a comment to “ensure you’ve said something”.
    * Rule: Uses imperative voice
        * "Developer 1" : Disagree, unless logic.
            * "Developer 1" : Source is your provided git link, but it has no logic.
        * "Developer 2" : This is for readability.
        * ["Developer 2" : Here is a Linus Torvald Source](https://github.com/torvalds/subsurface-for-dirk/blob/a48494d2fbed58c751e9b7e8fbff88582f9b2d02/README#L88)
            * "Developer 1" : Thanks for the link. It really said that. And also said in git doc.
            * "Developer 1" : I don’t see how this improved readability. Do you know why? I tried to find the why for a while, but cannot find. I can accept the rule, as I tried but cannot find how it will break in our context.
            * "Developer 1" : How can you code apply this rule? By checking predefined words? If in this way, I hope if triggered, the result will be in comment, instead of blocking.
            * "Developer 2" : You’re gonna have to trust me on readability here. The best example is adding it to the sentence “When applied this commit will...”
                * "Developer 2" : “When applied, this commit will ‘Fix the UI error that has caused issues’”
                * "Developer 2" : “When applied, this commit will ‘Fixing the UI error that has caused issues”
                * "Developer 2" : I don’t have enough background in English grammatical rules to explain the reasoning.
            * "Developer 2" : There is a pre-defined list, and I have added to that list as requested by other users when there have been words which needed to be added. The list, however, is the ~750 most common imperative words.
            * "Developer 1" : I always read commit message as: “This commit ‘fixed the UI error that has caused issues’.” I can accept reading it as “when applied”.
            * "Developer 1" : However, “using list” is the problem, and “I have added to that list” is the problem. What if you’re on vacation for a week, or be busy for a week? In that case, your tool will block the CR for a week, and I think it’s not good. If you put comment instead of blocking, this problem is avoided.
    * Rule: Starts with a Capital Letter
        * "Developer 1" : Agree
        * "Developer 2" : This has just as much “logic or source” support as anything else. Why agree here.
            * "Developer 1" : Because it intuitively made my reading of git commit message easier. I’m the example. More precisely, most of the English I read, are sentences. By capitalize the first letter, it made the commit message similar to an English sentence.
            * "Developer 2" : But you see how the argument here is “Intuition”..... that’s not a logical reason. For the same reason that a lot of these are “intuition”.
            * "Developer 1" : “intuition” is good and easy when we both have that.
            * "Developer 2" : But this isn’t between just you and me. There are 50K commits a month within Amazon that are analyzed by this software. Maybe 100 come from our team?
        * "Developer 2" : From [Chris Beams](https://cbea.ms/git-commit/#seven-rules) (A senior engineer on Java Spring)
    * Rule: Does not end in punctuation (.?-",!)
        * "Developer 1" : Disagree, unless logic or source.

        * "Developer 2" : [Here is a John Hogberg Source](https://github.com/erlang/otp/wiki/writing-good-commit-messages) (A primary contributor to Erlang)
            * "Developer 1" : Thanks for the link. What they said is “Don't end the summary line with a period - it's a title and titles don't end with a period.” So he is not against other punctuations.
            * "Developer 1" : And I don’t agree that the summary line is a title. I don’t see this in git doc either.
        * "Developer 2" : From [Chris Beams](https://cbea.ms/git-commit/#seven-rules) (A senior engineer on Java Spring)
            * "Developer 1" : Thanks for the link. What they said is “Trailing punctuation is unnecessary in subject lines. Besides, space is precious when you’re trying to keep them to 50 chars or less.”
            * "Developer 1" : Also, without a good reason. If the primary reason is “50 characters”, this rule should go together with that rule.
    * Rule: Separated from body by a new line
        * "Developer 1" : Disagree, unless logic or source.
        * "Developer 2" : This is because git treats the line up until a blank line as the summary of the commit. This is just how git works.
            * "Developer 1" : I found it in the git manual. I tried but cannot find how it will break in our current usage. I agree with it now. (I always followed, and before now I just disagree for it to be a rule. Now I agree)
        * "Developer 2" : These are based on the `git log` command, and cause errors with `git log` .
            * "Developer 1" : While the git manual said “Though not required”. I agree with it in previous step, so I’ll skip this.
        * "Developer 2" : From [Chris Beams](https://cbea.ms/git-commit/#seven-rules) (A senior engineer on Java Spring)
            * "Developer 1" : Thanks for the link. They said “Firstly, not every commit requires both a subject and a body. Sometimes a single line is fine, especially when the change is so simple that no further context is necessary”. I hope this tool will respect this special case (only subject) in this rule, and leave the case to be handled by rule “must have CR link”. (or rule of “at least 3 lines”, if that rule finally remained


"Developer 2" : None of this matters because I’m not changing the tool. It’s an opinionated tool designed to enforce standards. There is no logic behind using Camel Case instead of Snake Case in Java, and no logic behind using Snake Case instead of Camel Case in Python. But people do because ultimately that is the preferred style of the community, and doing something against community guidelines is just poor form.

"Developer 1" : As I’ve listed above: not all of them are “standard”, and some in our context is not applicable.
Our team has internal intelliJ syntax rule configure set, also Amazon has internal coverlay and checkstyle tool. People do that because it’s preferred by Amazon workmates.

"Developer 2" : And just like those are opinionated tools - this one is opinionated too... Someone had to have those opinions. These are mine.

"Developer 2" : This is my reasoning why having a single set of rules that everyone follows - even if they think they are being nice or taking a shortcut by not following them matters: https://www.wheels.ca/news/giving-up-the-right-of-way-generous-drivers-just-cause-confusion By giving up your right of way, you are not being friendly, but instead you are opening up the situation to become more unpredictable and dangerous.

"Developer 1" : I don’t see your reasoning here, and would like to know them, if you can list it clearly.
For these following rules, I think they need to be configurable (if they pass the use/not-use test):

* "Developer 1" : [2] Contains Ticket/Issue ID: different teams has different syntax.
* "Developer 1" : [4] All words are spelled correctly: if it generates blocking, the dictionary must be configurable by the user.
* "Developer 1" : [5] Lines do not exceed 72 characters:
    * "Developer 1" : Some teams may secretly have 80 characters screen
    * "Developer 1" : But for our team, 120.
    * "Developer 1" : As in the screenshot.
* "Developer 1" : [7.1] Subject Line: Does not exceed 50 characters: similar, team specific.
* "Developer 1" : [7.2] Subject Line: Is at least 20 characters: similar, team specific.
* "Developer 1" : [7.3] Subject Line: Uses imperative voice: similar, allow team dictionary.


"Developer 2" : The tool won’t change unless you can convince the git community, and Linus Torvald that they are mistaken: [torvalds@osdl.org](mailto:torvalds@osdl.org) . Until then, the opinionated tool is staying opinionated.

"Developer 1" : As said, first, not all 12 rules discussed here are from git community.
If git doesn’t enforce that internally, they must have their own reason. The reason here is “we are an Amazon team, and must use the software to maximize Amazon’s development”. If every team member is using big screen, well supported editor for auto-line-wrap, adapting to 80-char-wide-screen is a waste of Amazon development power. The tool can stay as it is, or by deleting non-standard rules and offered to git, but I will not agree for it to go into our team’s review blocker process, unless it is adjusted to fits our status, (or in the very least requirement, not bringing extra trouble to our work process).

"Developer 2" : I will not agree to have it removed.


>"Developer 2" : Opinionated software is a software product that believes a certain way of approaching a business process is inherently better and provides software crafted around that approach

## Conventional Commits

"Developer 2" : There is a different way of thinking that includes conventional commits. A different tool at Amazon enforces the use of conventional commits. Conventional commits are not enforced with this tool, but will pass. Conventional commits share many of the attributes above, but with the addition of a pre-fixed string indicating the type of change. It is discussed at length in many of the sources below.

## References

Links to both the industry and internal Amazon write-ups on this topic
https://git-scm.com/docs/git-commit
https://arxiv.org/pdf/2202.02974.pdf
https://medium.com/@hritik.jaiswal/how-to-write-a-good-commit-message-9d2d533b9052
https://wordssaysalot.hashnode.dev/art-of-writing-a-good-commit-message
https://chromatichq.com/insights/how-write-great-commit-message/
https://marketsplash.com/tutorials/git/git-commit/
https://robertcooper.me/post/git-commit-messages
https://unstoppabledomains.com/blog/categories/engineering/article/creating-good-commit-messages
https://developers.google.com/blockly/guides/contribute/get-started/commits
https://make.wordpress.org/core/handbook/best-practices/commit-messages/
https://betterprogramming.pub/how-to-write-good-commit-messages-and-why-is-it-important-18ac406ce33a
https://blog.bolajiayodeji.com/writing-good-commit-messages-a-practical-guide
https://blog.devgenius.io/a-guide-to-writing-good-commit-messages-in-git-4e513e887b6b
https://vicvijayakumar.com/blog/the-art-of-writing-good-commit-messages
https://www.packetcoders.io/tl-dr-writing-good-commit-messages/
https://riptutorial.com/git/example/4729/good-commit-messages
https://paulvanderlaken.com/2020/05/11/how-to-write-git-commit-message-7-steps/
https://sloopstash.com/blog/how-to-write-an-effective-git-commit-message.html
https://tenstars.co/blog/best-practices-on-writing-clean-commit-messages
https://herewecode.io/blog/a-beginners-guide-to-git-how-to-write-a-good-commit-message/
https://altcampus.com/posts/how-to-write-good-git-commit-message
https://devdocs.prestashop-project.org/8/contribute/contribution-guidelines/writing-a-good-commit-message/
https://www.geeksforgeeks.org/how-to-write-good-commit-messages-in-github/
https://juffalow.com/blog/git/write-good-git-commit-message
https://www.toolsqa.com/git/writing-good-commit-messages/
https://www.linkedin.com/pulse/what-makes-good-git-commit-writing-message-omar-ismail/
https://levelup.gitconnected.com/git-commit-messages-the-right-way-724dba78c55f
https://chiamakaikeanyi.dev/how-to-write-good-git-commit-messages/
http://api.coala.io/en/latest/Developers/Writing_Good_Commits.html
https://www.paulsblog.dev/write-better-git-commit-messages-to-increase-your-productivity/
https://dev.blog.documentfoundation.org/2022/05/05/how-to-write-a-good-commit-message/
https://blog.mergify.com/how-to-write-good-commit-messages/
https://literatejava.com/git/how-to-write-a-good-git-commit-message/
https://blog.indrek.io/articles/how-to-write-a-good-commit-message/
https://thoughtbot.com/blog/5-useful-tips-for-a-better-commit-message
https://docs.wpvip.com/how-tos/write-a-good-commit-message/
https://hackernoon.com/7-rules-for-writing-a-good-commit-message
https://www.simplethread.com/git-commit-message-101/
https://skerritt.blog/writing-better-commit-messages/
https://medium.com/swlh/writing-better-commit-messages-9b0b6ff60c67
https://blog.ossph.org/how-to-write-a-good-git-commit-message/
https://dev.to/chrissiemhrk/git-commit-message-5e21
https://dev.to/wordssaysalot/art-of-writing-a-good-commit-message-56o7
https://initialcommit.com/blog/git-commit-messages-best-practices
https://www.git-tower.com/blog/how-to-write-the-perfect-commit-message/
https://github.com/joelparkerhenderson/git-commit-message
https://github.com/erlang/otp/wiki/writing-good-commit-messages
https://www.theodinproject.com/lessons/foundations-commit-messages
https://www.microverse.org/blog/how-writing-meaningful-commit-messages-helps-you-be-a-better-developer
https://reflectoring.io/meaningful-commit-messages/
https://opensource.com/article/22/12/git-commit-message
https://www.gitkraken.com/learn/git/best-practices/git-commit-message
https://cbea.ms/git-commit/
https://www.freecodecamp.org/news/how-to-write-better-git-commit-messages/

https://w.amazon.com/bin/view/Users/nkryan/CommitMsg/
https://w.amazon.com/bin/view/AWS_Training_and_Certification/Product_Development/ILT/Grimsby/Engineering/Development/Commit_Messages/
https://w.amazon.com/bin/view/Goodreads/Engineering/Android/Goodreads_on_Kindle_Tablet/Commit_Message_Format/
https://w.amazon.com/bin/view/Users/nikiamzn/Quip/CommitMessageTemplateforTeam-ProblemSolve/
https://w.amazon.com/bin/view/SFSC/DevOps/ReleaseManagement/CruxAnalyzerForCommitMessages/
https://w.amazon.com/bin/view/NodeExceptions/Commit-Message-Template-for-Team-ProblemSolve/
https://w.amazon.com/bin/view/AWS/Mobile/IoT/EdgeRunner/Engineering/Guidelines/commit-message/
https://w.amazon.com/bin/view/HWEng/MTEBestPractices/GitCommitMessage/
https://w.amazon.com/bin/view/AccessPoint/PartnerExperience/DevResources/Code_Commit/
https://w.amazon.com/bin/view/OptimusMM/AFXShipping/Hamza/BestPractices/CommitMessages/
https://w.amazon.com/bin/view/Sierra-apps/Engineering/Standardizations/CommitMessages/
https://w.amazon.com/bin/view/AWSBrew/PLC/CodeGuidelines/CommitMessages/
https://w.amazon.com/bin/view/Aws-crm/apps-eng/salesforce/sdlc/GIT/CommitMessages/
https://w.amazon.com/bin/view/S3/Teams/Insights/RI/Development/Commit/
https://w.amazon.com/bin/view/AWSBrew/CommitMessages/
https://w.amazon.com/bin/view/Galaxy-apps/Jupiter/Process/CommitMessages/
https://w.amazon.com/bin/view/TechOps/AARG/DUB/CodingStandards/Commit_Message_Template/
https://w.amazon.com/bin/view/ITS-PnD/AMS/Teams/Orca/Guidelines/CommitMessage/
https://w.amazon.com/bin/view/S3Nexus/Developer/CommitMessages/

