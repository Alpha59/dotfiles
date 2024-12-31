## Summary
**As a** software engineer or team lead, **I want** to apply the **150-150 rule** in code reviews using an **automated reviewer**, **so that** code reviews remain focused, manageable, and timely, improving the quality of feedback and efficiency of the review process.

The **150-150 rule** suggests that pull requests (PRs) should contain no more than **150 lines of code (LOC)** per review and be reviewed within **150 minutes**. This rule helps reduce cognitive load for reviewers, improves the accuracy of reviews, and ensures that feedback is provided promptly.

### Vision
By enforcing the 150-150 rule using an automated reviewer, the team will maintain a steady, focused code review process. It will help keep reviews concise and manageable, resulting in higher-quality feedback and faster turnaround times, without overwhelming the reviewer or delaying the development pipeline.

### Background
Large or overly complex pull requests can make code reviews difficult and time-consuming, leading to missed issues and reduced feedback quality. The 150-150 rule helps set limits to ensure reviews are conducted efficiently and thoroughly. Automated tools can enforce these limits, notifying the team when a PR exceeds the threshold or when reviews take too long.

### Purpose
The purpose of this story is to enforce the 150-150 rule using automated reviewers, ensuring that pull requests are small and reviewed within a reasonable timeframe. This improves review efficiency, feedback quality, and development velocity.

## Details

### 1. **Set Limits on Pull Request Size**
   - Use an automated reviewer (e.g., **GitHub Actions**, **GitLab CI**, **DangerJS**) to enforce a maximum of **150 lines of code** changed per pull request.
   - If a PR exceeds this threshold, the automated reviewer should notify the developer and suggest breaking the changes into smaller, more manageable PRs.

   **Example (GitHub Action for PR Size Check)**:
   ```yaml
   name: PR Size Check
   on: [pull_request]
   jobs:
     check_size:
       runs-on: ubuntu-latest
       steps:
         - name: Checkout code
           uses: actions/checkout@v2
         - name: Check PR size
           run: |
             LOC=$(git diff --stat | tail -1 | grep -o '[0-9]*\s*insertions' | awk '{print $1}')
             if [ "$LOC" -gt 150 ]; then
               echo "::error::PR exceeds 150 lines of code."
               exit 1
             fi
   ```

### 2. **Monitor Code Review Time**
   - Use an automated reviewer or bot to track the time a pull request remains in review. If a PR has been open for more than **150 minutes** without review or resolution, the bot should notify reviewers to prioritize the PR.
   - Integrate with tools like **Slack**, **GitHub Notifications**, or **Jira** to send reminders.

   **Example (GitHub Action to Check Review Time)**:
   ```yaml
   name: Review Time Monitor
   on:
     schedule:
       - cron: '*/30 * * * *'  # Run every 30 minutes
   jobs:
     monitor_review_time:
       runs-on: ubuntu-latest
       steps:
         - name: Check PR age
           run: |
             PR_AGE=$(gh pr view <PR-ID> --json createdAt --jq '.createdAt')
             # Logic to calculate time and notify reviewers
   ```

### 3. **Enforce and Notify Reviewers**
   - Ensure that the automated reviewer notifies the relevant stakeholders (reviewers and PR submitters) when the limits are exceeded. This can be done via GitHub comments, email, or Slack notifications.
   - The system should recommend breaking down large PRs and provide guidance on following the 150-150 rule for future submissions.

### 4. **Encourage Smaller, Incremental Changes**
   - Use automated tools to suggest that developers submit smaller, incremental changes rather than bundling multiple features or fixes into a single large PR.
   - Set guidelines and educate team members on the benefits of the 150-150 rule, including faster reviews, easier testing, and improved quality.

### Testing
- Test that PRs exceeding 150 lines trigger the automated notification.
- Verify that the automated reviewer tracks review times and sends reminders after 150 minutes of inactivity.
- Simulate a large PR and confirm that the automated reviewer suggests breaking it down.

## Acceptance Criteria
- Should enforce a limit of 150 lines of code for each PR using an automated reviewer.
- Should track and monitor code review time, sending alerts if the review exceeds 150 minutes.
- Should notify developers and reviewers when PRs exceed size or time limits.
- Should recommend breaking down large PRs and educate team members on the benefits of the 150-150 rule.

### External Links
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [DangerJS Documentation](https://danger.systems/js/)
