# Code Review Tenets

1. Good Code Reviews take time. If you commit to review code, review it thoroughly!
    1. Read the code, look at both logic and style
    2. Aim to have 1 specific code change on every first review
2. Aim to understand every changed line
    1. Lines that you can’t understand, need a comment
    2. In truly beautiful code, simple is better than complex.
    3. Other people need to read this, so if you can’t understand, it needs refactoring, cleaning, or better comments.
    4. You should be able to answer:
        1. What goal does this code accomplish?
        2. How does this code accomplish that goal?
3. Don’t assume code works. Pull it down and test.
    1. If Coverlay passed - you should be able to build it too.
    2. Do not approve if Coverlay failed - look to see why it failed.
4. Insist on Comments
    1. Comments should tell How and Why
    2. Tone should be conversational
    3. Comments should not be vague
    4. Comments should have context
    5. Comments should state Purpose in Plain english
        1. Short and sweet
        2. Comments should read like code, not paragraphs
    6. Code is only self documenting when intent is obvious
    7. https://standards.mousepawmedia.com/
5. Treat Temporary code with the same standards as production code
6. Never merge, approve, or ship broken code
7. Unit tests should cover the new code
8. New code should be documented
9. Markdown files (README.md) Should be up to date with code changes
10. Code should be reviewed in order:
    1. Functionality
    2. Style and maintainability
    3. Optimization
11. If you review code once, be prepared to review it for another revision
    1. Always ask original reviewers to re-review when a change is pushed
    2. You own code that you review as much as you own code you wrote.
12. A code review written by the ego is far worse than no review at all.
13. A critical comment blocks shipment
    1. Critical Commenters become required reviewers
    2. Comments can only be critical if there is a functional problem with the code OR there is a functional concern with the deployment of the code.
14. For each person that reviews your code, you are expected to respond to them, and you should expect a response for every comment you leave.


