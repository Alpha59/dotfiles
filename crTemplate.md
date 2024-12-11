#!/usr/bin/env bash

branch="$(git current-branch)";

if [[ "$branch" != "mainline" ]]; then
    remove=$(git push origin --delete "$branch");
    push=$(git push -u origin "$branch:$branch");
fi

tracking=$(git all branch -u origin/mainline);

echo "
# Description

## Commit Description

$(git show -s --format='* SHA: %H%n* Author: %an%n* Start Date: %ad%n* CRUX Open: %cd%n* Parent: %p%n%n%n%w(72,4,4)%B%n%n%n%w(80,0,0)Notes:%n%n%n%w(72,4,4)%N%n%n%w(80,0,0)')

\`\`\`
$(timeout 10 git show --stat --format="")

---

$(git overwritten)
\`\`\`

$(git neck)
---

## Branch Check

Current Branch: $(timeout 10 git current-branch);
$(git worktree list)
\`\`\`
$(timeout 10 git push)

$(timeout 10 git wtf -r -A -a)

\`\`\`

## Test Cases
How did you test your change?

### Gordian's Knot

\`\`\`
$(timeout 480 gk-analyze-all)
\`\`\`

Some recommended actions:
- Run a local bb server and test API/UI with valid inputs
- Override beta host with changes and test with coral explorer
- Deploy changes to personal/beta stack and test in AWS console

### Test Results

The output from the unit tests and coverage can be seen both here, and in the Coverlay section of the Code Review:

\`\`\`
$(timeout 240 brazil-build coverage | tail -n50 | grep -v "report" | grep -v "echo" | grep -v "copy" | grep -v "coverage-check" | grep -v "standard-coverage")
\`\`\`

---

Git Conflicts that exist: $(git conflicts);

$(git divergance)

\`\`\`
$(git log-graph | head -n5)
\`\`\`

author: $(timeout 5 git whoami);

**Make sure you read and respond to ALL comments before merging**
";
