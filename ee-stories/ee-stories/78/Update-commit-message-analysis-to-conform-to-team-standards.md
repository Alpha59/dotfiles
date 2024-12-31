## Summary
**As a** software development team member, **I want** to update the **commit message analysis** process to conform to team standards, **so that** all commit messages follow a consistent, clear, and meaningful format, improving code review efficiency, tracking changes, and overall project documentation.

Consistent commit messages help the team understand the purpose of changes, improve collaboration, and ensure that future developers or stakeholders can quickly grasp the context of modifications. By enforcing commit message standards, we can ensure that commit logs are meaningful, well-structured, and easy to read.

### Vision
By enforcing commit message standards, the team will ensure that commit logs are easy to understand, searchable, and consistently formatted. This will streamline the code review process, improve the ability to track issues, and create better historical records of code changes.

### Background
Inconsistent or unclear commit messages make it difficult for developers to track changes or understand the reasoning behind a specific code update. Standardized commit messages that follow a predefined template help ensure clarity, consistency, and relevance in the version control history. Popular conventions such as **Conventional Commits** provide a structured approach that can be integrated with CI/CD processes to automate semantic versioning and changelog generation.

### Purpose
The purpose of this story is to update and enforce the commit message analysis process to ensure it conforms to team standards, providing consistency and clarity in the commit history.

## Details

### 1. **Define Commit Message Standards**
   The team should adopt a consistent format for commit messages that provides context and clarity. A widely adopted format is **Conventional Commits**, which structures commit messages into specific types like "feat," "fix," or "chore." This format helps with changelog generation, release automation, and semantic versioning.

   **Team Standards Example**:
   - Commit messages should be concise but informative.
   - Use present tense in the commit message (e.g., "Add feature," not "Added feature").
   - Structure of a commit message:
     ```
     <type>(<scope>): <short description>

     [optional body]
     [optional footer]
     ```

   **Types of commits**:
   - **feat**: A new feature.
   - **fix**: A bug fix.
   - **chore**: Routine tasks or chores that do not add new functionality.
   - **docs**: Documentation changes.
   - **refactor**: Code refactoring without adding new features or fixing bugs.
   - **test**: Adding or updating tests.

   **Example of a Conventional Commit**:
   ```
   feat(user-service): add password reset functionality
   ```

### 2. **Implement a Commit Message Linter**
   To enforce the team’s commit message standards, integrate a **commit message linter** into the development workflow. A linter will automatically check that all commit messages follow the required structure before they are accepted into the codebase.

   **Example Tool: Commitlint**
   - **Commitlint** is a popular tool for enforcing commit message conventions (e.g., Conventional Commits).
   - **Install Commitlint** and set it up in the project:
     ```bash
     npm install --save-dev @commitlint/config-conventional @commitlint/cli
     ```

   - Create a `commitlint.config.js` file:
     ```javascript
     module.exports = {
       extends: ['@commitlint/config-conventional']
     };
     ```

   - Integrate Commitlint with **Husky** to check commit messages before they are created:
     ```bash
     npx husky install
     npx husky add .husky/commit-msg 'npx --no-install commitlint --edit "$1"'
     ```

### 3. **Add Pre-Commit Hooks to Enforce Standards**
   Pre-commit hooks help ensure that developers follow commit message standards. By integrating tools like **Husky** or **Pre-Commit**, you can automatically enforce commit message guidelines at the time of the commit.

   **Using Husky (JavaScript/TypeScript Projects)**:
   - Add the following command to your **package.json**:
     ```json
     "husky": {
       "hooks": {
         "commit-msg": "commitlint -E HUSKY_GIT_PARAMS"
       }
     }
     ```

   **Using Pre-Commit (Python Projects)**:
   - Install **Pre-Commit**:
     ```bash
     pip install pre-commit
     ```

   - Add a `commit-msg` hook in the `.pre-commit-config.yaml` file:
     ```yaml
     repos:
       - repo: https://github.com/conventional-changelog/commitlint
         rev: v13.2.1
         hooks:
           - id: commitlint
     ```

### 4. **Integrate Commit Message Validation into CI/CD Pipeline**
   Add commit message validation checks into the **CI/CD pipeline** (e.g., **GitHub Actions**, **Jenkins**, **GitLab CI**) to ensure that only valid commit messages are accepted in pull requests or build pipelines.

   **Example: GitHub Actions Commitlint Configuration**:
   ```yaml
   name: Commit Lint

   on:
     pull_request:
       branches:
         - main

   jobs:
     commitlint:
       runs-on: ubuntu-latest
       steps:
         - name: Checkout code
           uses: actions/checkout@v2

         - name: Run Commitlint
           run: |
             npm install
             npx commitlint --from=origin/main --to=HEAD
   ```

### 5. **Provide Documentation and Training on Commit Message Standards**
   Create and share documentation that explains the team’s commit message standards, providing examples of properly formatted messages and instructions on how to use the tools for enforcing the standards. Hold a training session or send a quick reference guide to the team to ensure everyone is aligned.

   **Example Documentation**:
   ```
   ## Commit Message Standards
   - Use the format: `<type>(<scope>): <subject>`
   - Valid types: feat, fix, chore, docs, refactor, test
   - The scope is optional but recommended.
   - The subject should be brief and describe the change concisely.

   ### Examples:
   - feat(auth): add OAuth integration
   - fix(ui): correct alignment issues on login page
   - docs: update README with setup instructions
   ```

### 6. **Monitor Adoption and Compliance**
   - Periodically review the commit history to ensure that developers are adhering to the standards.
   - Provide feedback during code reviews if improper commit messages are observed.
   - Use analytics tools or custom scripts to track compliance over time.

### Testing
- Test the commit message analysis tool by attempting to commit messages that do not conform to the team standards.
- Verify that the linter or pre-commit hook rejects non-compliant messages and provides clear error messages.
- Ensure that the CI/CD pipeline fails or flags pull requests that contain invalid commit messages.

### Acceptance Criteria
- Should define clear commit message standards that align with the team's requirements (e.g., Conventional Commits).
- Should implement a commit message linter to enforce standards across all commits.
- Should set up pre-commit hooks to enforce commit message rules before code is committed.
- Should integrate commit message validation into the CI/CD pipeline.
- Should document the commit message standards and share them with the team.
- Should monitor adoption and provide feedback during code reviews if necessary.

### External Links
- [Conventional Commits Specification](https://www.conventionalcommits.org/)
- [Commitlint Documentation](https://commitlint.js.org/#/)
- [Husky Documentation](https://typicode.github.io/husky/#/)
