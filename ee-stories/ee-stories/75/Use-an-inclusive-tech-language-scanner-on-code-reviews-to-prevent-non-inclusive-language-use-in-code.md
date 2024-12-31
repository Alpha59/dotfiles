## Summary
**As a** software engineer or team lead, **I want** to use an **inclusive tech language scanner** on code reviews to prevent non-inclusive language use in code, **so that** we foster an inclusive, respectful, and welcoming environment for all team members and contributors.

Ensuring the use of inclusive language in code comments, variable names, and documentation is important to creating an open and respectful workspace. By implementing a tech language scanner during code reviews, we can automatically detect and replace non-inclusive terms, helping to improve the inclusiveness of our codebase and align with modern industry standards.

### Vision
By integrating an inclusive language scanner into the code review process, the team will ensure that all code contributions are free from non-inclusive language. This will help build an open and diverse development environment, encouraging contributions from people of all backgrounds and reducing the use of outdated or harmful terminology.

### Background
Many common terms used in programming (e.g., "master/slave", "blacklist/whitelist") have harmful historical connotations and may be perceived as exclusionary. The tech community has increasingly adopted more inclusive alternatives (e.g., "primary/secondary", "allowlist/blocklist"). Implementing a scanner will automate the detection of these terms, ensuring they are caught and replaced early in the review process.

### Purpose
The purpose of this story is to integrate an inclusive language scanner into the code review process, automatically flagging any non-inclusive terms and providing suggestions for inclusive alternatives. This will ensure the team adheres to inclusive language guidelines across the codebase and documentation.

## Details

### 1. **Choose an Inclusive Language Scanner**
   - Select a tool or service that can scan code for non-inclusive language. Several options exist:
     - **Linters** with custom rules (e.g., ESLint with plugins).
     - **GitHub Actions** for scanning during pull requests.
     - Standalone tools like **AlexJS**, **Woke**, or **InclusiveLint** that can be integrated into CI/CD pipelines.

   **Example Tools**:
   - **AlexJS**: A tool for catching insensitive language in markdown and comments.
   - **Woke**: A tool that scans code and documentation for non-inclusive language.
   - **InclusiveLint**: A linter that checks code for non-inclusive terms.

### 2. **Integrate the Scanner into the Code Review Process**

#### a. **GitHub Actions Example**:
   - Use **GitHub Actions** to run the inclusive language scanner on every pull request.
   - If non-inclusive language is detected, the action can fail the build and provide suggestions for more inclusive terminology.

   **Example GitHub Action Using Woke**:
   ```yaml
   name: Inclusive Language Check

   on: [pull_request]

   jobs:
     check_language:
       runs-on: ubuntu-latest
       steps:
         - name: Checkout code
           uses: actions/checkout@v2

         - name: Install woke
           run: |
             curl -sSfL https://github.com/get-woke/woke/releases/download/v0.18.0/woke-linux-amd64 -o woke
             chmod +x woke

         - name: Run woke for inclusive language check
           run: |
             ./woke --exit-1
   ```

#### b. **ESLint Plugin for Inclusive Language (JavaScript/TypeScript)**:
   - For JavaScript or TypeScript projects, use an ESLint plugin like **eslint-plugin-inclusive-language** to detect non-inclusive language during development or code reviews.

   **Steps**:
   - Install the plugin:
     ```bash
     npm install eslint-plugin-inclusive-language --save-dev
     ```

   - Configure `.eslintrc.json` to include the plugin:
     ```json
     {
       "plugins": ["inclusive-language"],
       "rules": {
         "inclusive-language/use-inclusive-words": [
           "error",
           {
             "whitelist": {
               "master": ["primary", "main"],
               "slave": ["secondary", "replica"],
               "whitelist": ["allowlist"],
               "blacklist": ["blocklist"]
             }
           }
         ]
       }
     }
     ```

#### c. **CI/CD Integration**:
   - Add the inclusive language scanner to your CI/CD pipeline to run automatically during builds and deployments.
   - Use **Jenkins**, **GitLab CI**, **Travis CI**, or **CircleCI** to fail the pipeline if non-inclusive terms are detected in the code or documentation.

   **Example Using Travis CI**:
   ```yaml
   language: node_js
   node_js:
     - '14'

   script:
     - npm run lint # Include your inclusive language check here
   ```

### 3. **Define Non-Inclusive Terms and Alternatives**
   - Create a list of non-inclusive terms that should be flagged by the scanner and provide recommended alternatives.
   - Examples of non-inclusive terms and alternatives:
     - **master** → primary, main
     - **slave** → secondary, replica
     - **whitelist** → allowlist
     - **blacklist** → blocklist
     - **grandfathered** → legacy

   **Example Woke Configuration (`woke.yaml`)**:
   ```yaml
   terms:
     - word: "master"
       alternatives:
         - "primary"
         - "main"
     - word: "slave"
       alternatives:
         - "secondary"
         - "replica"
     - word: "whitelist"
       alternatives:
         - "allowlist"
     - word: "blacklist"
       alternatives:
         - "blocklist"
   ```

### 4. **Provide Feedback and Suggestions in Code Reviews**
   - When non-inclusive language is detected, provide immediate feedback in code reviews. Include the offending term, its location, and suggestions for inclusive alternatives.
   - For example, if a term like "master" is detected, suggest "primary" or "main" as alternatives.

### 5. **Educate the Team on Inclusive Language**
   - Hold sessions or provide documentation to explain the importance of using inclusive language in code and how the inclusive language scanner works.
   - Encourage team members to actively avoid non-inclusive terms when writing new code or documentation.

### Testing
- Test the inclusive language scanner by creating a pull request or committing code that contains non-inclusive language.
- Verify that the scanner detects the non-inclusive terms and provides appropriate alternatives.
- Ensure the build fails or alerts are triggered if non-inclusive language is detected during code reviews or CI/CD runs.

### Acceptance Criteria
- Should integrate an inclusive language scanner (e.g., Woke, ESLint plugin) into the code review process.
- Should define a list of non-inclusive terms and alternatives and configure the scanner accordingly.
- Should automatically scan for non-inclusive language in pull requests and during CI/CD pipeline runs.
- Should provide actionable feedback with suggested alternatives when non-inclusive language is detected.
- Should educate team members about inclusive language practices.

### External Links
- [AlexJS for Inclusive Language](https://alexjs.com/)
- [Woke Inclusive Language Scanner](https://github.com/get-woke/woke)
- [Inclusive Language in Tech](https://www.inclusivelint.com/)
