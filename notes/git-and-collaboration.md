# Introduction to Git and Collaborative Development in Multi-Team Environments

Git has become the standard for version control in modern software development. Its flexibility, speed, and distributed nature make git ideal for teams of all sizes. In a multi-team environment where multiple developers are working on interconnected services or repositories, Git's features are particularly valuable. This comprehensive guide delves into the industry-standard practices for using Git in a collaborative setting with multiple teams, focusing on proper commit messages, the use of feature branches, and the principle of never force pushing to mainline. The document explores working with multiple connected repositories and microservices, emphasizing the sanctity of the pipeline and the mainline branch.

## What is Git?

Git is a distributed version control system (DVCS) renowned for its ability to manage projects of varying scales with speed and efficiency. The brainchild of Linus Torvalds in 2005, Git quickly rose to prominence as the go-to tool for collaborative software development across the globe. Its distributed nature means that every user possesses a complete copy of the entire repository, fostering independence and flexibility in development workflows. Unlike centralized version control systems, Git allows developers to work offline, commit changes locally, and then synchronize with remote repositories when connected.

This decentralization empowers teams to work seamlessly across geographical boundaries and time zones, making git ideal for projects ranging from single-developer ventures to large-scale, multi-team endeavors. Git's robustness lies in its ability to track changes, maintain a detailed history of edits, and facilitate streamlined collaboration among developers. With Git, teams confidently manage codebases, track changes, and ensure the integrity of their projects, all while adhering to industry-standard practices that promote productive workflows and code quality.

## Key Concepts in Git

### Repositories

A Git repository, or repo, is a collection of files and their history. Each developer working on a project has their copy of the repository, including the complete history of changes. This allows developers to work independently and merge their changes later.

At Amazon, these repositories are regularly referred to as “Packages” or “Brazil Packages”.

### Commits

A commit in Git is a snapshot of the repository at a specific point-in-time. Each commit has a unique identifier (SHA-1 hash) and contains changes made to files. Well-written commit messages are essential for effective communication and understanding the changes made.

**Example:**

```
git commit -m "Added user authentication feature"
```

### Branches

Branches in Git are pointers to a specific commit. They allow developers to work on features or fixes in isolation without affecting the main codebase. Feature branches are a common practice to keep mainline clean and secure.

The "mainline" branch in Git typically refers to the primary branch of development in a repository. This is named `mainline`, or another similar term, depending on the project's convention. The mainline branch serves as the default branch where the project's stable, production-ready code resides. This is the branch from which all other branches originate and into which completed work is eventually merged.

#### Characteristics of the Mainline Branch:

* Production-Ready Code
    * The mainline branch contains the latest stable and tested version of the project.
    * Code on this branch is deployable and represents the current state of the application.
* Centralized Source of Truth:
    * Developers consider the mainline branch as the primary reference for the project's codebase.
    * It acts as the centralized source of truth for the entire team.
* Starting Point for Feature Branches:
    * When developers begin working on a new feature or bug fix, they typically create a new branch off the mainline.
    * This keeps the mainline clean and ensures that only completed and tested changes are merged back.
* Integration Point for Completed Work:
    * When a feature or fix is complete and tested in its feature branch, it is merged back into the mainline.
    * Merging into the mainline integrates the new code with the existing codebase, making it available for others.
* Branches for Releases:
    * Sometimes, specific branches are created from the mainline to prepare for releases.
    * For example, a `release` branch may be branched off the mainline to stabilize and prepare for deployment.
* Protecting Mainline Branch:
    * In some workflows, the mainline branch may be protected to prevent accidental deletion or force pushes.
    * Access controls and branch protection rules can be set up in Git hosting platforms like GitHub or GitLab.

The mainline branch is the backbone of a Git repository


#### **Creating a new branch:**

```
git branch new-feature
```

### Remote Repositories

Remote repositories are copies of the project stored on a server. Developers push their changes to the remote and pull changes from the remote. This is crucial for collaboration, as it allows teams to share code.  The `origin` remote repository in Git is a commonly used convention for referring to the default remote repository where a local repository has been cloned from or where changes are pushed. When you clone a repository from a remote server, Git automatically names that remote repository `origin` by default.


#### **Adding a remote repository:**

```
git remote add origin <remote-url>
```

### Pull

Pulling in Git is the process of fetching changes from a remote repository and merging them into the local repository. This is commonly done to synchronize a local copy of the project with the latest changes made by other team members. It combines the `git fetch` and `git merge` commands into a single operation.


#### **Pulling changes from remote:**

```
git pull origin main
```

### Push

Pushing in Git involves sending local commits to a remote repository. It is used to share the work done locally with others and update the shared repository with new changes. Before pushing, it's essential to ensure that the local repository is up-to-date with the remote to avoid conflicts.


#### **Pushing changes to remote:**

```
git push origin mainline
```

### Merging

Merging is the process of combining changes from one branch into another. When a feature branch is ready, the branch is merged into the mainline, integrating the new code while preserving history. This will happen after a Code Review.


#### **Merging a branch into mainline:**

```
branch="$(git current-branch)";
git checkout mainline;
git pull;
git checkout ${branch};
git rebase mainline;
git checkout mainline;
git merge ${branch};
git push;
```

## Industry Standard Practices for Multi-Team Collaboration

### Well-Written Commit Messages

Informative and descriptive commit messages are fundamental for understanding changes. Follow these guidelines for efficiently composing commit messages:


* Start with a concise, capitalized summary (50 characters or fewer).
* Use the imperative mood ("Add feature" instead of "Added feature").
* Provide detailed explanations in the body (wrap at 72 characters).
* Reference relevant issues or tickets, if applicable ("Fixes #123").

Example:

```
Add user authentication feature

- Implemented login and registration pages
- Added backend API endpoints for user management

KRL-1234
```

### Feature Branches

Feature branches allow teams to work on different features simultaneously without interfering with each other's code. Follow these practices when working with feature branches:

* Create a new branch for each feature or bug fix (`git checkout -b feature-name`).
* Keep branches concentrated on a single task to simplify code reviews.
* Regularly merge changes from the mainline into feature branches (`git merge main`).

### Never Force Push to Mainline

Force pushing (`git push --force`) overwrites history and leads to loss of work. To maintain the integrity of the mainline branch:

* Avoid force pushing to shared branches, especially `main` or `mainline`.
* If changes conflict with mainline, resolve conflicts locally before merging.
* Use pull requests or merge requests for code review and integration.

### Working with Multiple Teams and Repositories

In a multi-team environment, coordination and communication are key. Here's how to manage multiple teams and repositories effectively:


* Establish straight-forward repository ownership for each team or service.
* Use a branching strategy that fits the project's needs
* Regularly sync repositories to avoid divergence (pull changes frequently).
* Coordinate releases and deployments to ensure compatibility across services.

### Microservices and Dependency Management

When working with microservices, each service has a repository. To manage dependencies and ensure consistency:

* Clearly define service boundaries and interfaces.
* Use versioning for APIs and libraries to handle changes between services.
* Use package managers (NPM, Brazil) for managing dependencies within each service.
* Practice contract testing to validate interactions between microservices.

### Pipeline and Mainline Branch

The pipeline represents the stages through which code passes before deployment (build, test, deploy). To protect the pipeline and mainline branch:

* Implement branch protection rules to prevent direct pushes to mainline.
* Require code reviews and passing tests before merging into mainline.
* Automate testing and deployment processes to maintain a dependable pipeline.

## Best Practices in Git

#### Meaningful Commit Messages

* Write clear and descriptive commit messages that explain the purpose of the changes.
* Follow a consistent format, such as starting with a present-tense verb and providing context.
* `git commit -m "Fix issue with user login validation"`

#### Use Feature Branches

* Create separate branches for each feature, bug fix, or task.
* This keeps the mainline clean and allows for focused development.
* `git checkout -b feature/new-feature`

#### Regularly Pull Changes

* Pull changes from the mainline frequently to stay up-to-date.
* This reduces the chances of conflicts and ensures smoother collaboration.
* `git pull origin main`

#### Avoid Force Pushing

* Never force push (`git push --force`) to mainline or shared branches.
* This can overwrite others' work and lead to data loss.
* Use caution and consider rebasing or merging instead.
* `git push origin main`

#### Use Interactive Rebasing for Clean History

* Interactive rebasing (`git rebase -i`) allows for cleaning up commit history before merging.
* Squash or reword commits to create a clean, logical history.
* This improves readability and helps in code review.
* `git rebase -i HEAD~3  # Rebase last 3 commit`

#### Review Changes Before Committing

* Use `git diff` to review changes before staging them for commit.
* Ensure that only relevant changes are included in each commit.
* `git diff  # Show unstaged changes`

#### Use `git cherry-pick` for Selective Commits

* `git cherry-pick` allows you to apply specific commits from one branch to another.
* Useful for picking individual changes without merging entire branches.
* `git cherry-pick <commit-hash>`

#### Add Files Selectively

* Use `git add -p` to interactively stage parts of a file.
* This allows for selective staging of changes within files.
* `git add -p  # Interactively stage changes`

#### Amend Last Commit for Quick Fixes

* `git commit --amend` allows you to modify the last commit.
* Useful for quick fixes or adding forgotten changes.
* `git commit --amend`

#### Use `.gitignore` for Ignoring Files

* Create a `.gitignore` file to specify files or patterns to be ignored by Git.
* This prevents unwanted files (e.g., temporary files, logs) from being included in commits.

#### Understand `git rebase` versus  `git merge`

* `git rebase` rewrites commit history by moving commits to a new base.
* Use it for linear, clean history but avoid on shared branches.
* `git merge` combines changes from different branches, creating a merge commit.
* Use it for integrating features into the mainline.

#### Use `git log` for History Visualization

* `git log` displays the commit history with options for filtering and formatting.
* Use it to review the history, identify commits, and understand project evolution.
* `git log --oneline --graph --decorate`

#### Document with `git show` and `git blame`

* `git show` displays information regarding a commit, including changes.
* `git blame` shows who last modified each

### Using Feature Branches

Feature branches allow developers to work on new features or bug fixes without disrupting the main codebase. Here's how to create and work with feature branches:


#### Creating a Feature Branch

```
# Create a new branch
git checkout -b feature/new-feature
```

#### Making Changes and Committing

```
# Make changes to files
git add .
git commit -m "Add new feature"

# Continue making changes and committing as needed
```

#### Pushing Changes to Remote

```
# Push the branch to the remote repository
git push origin feature/new-feature
```

### Never Force Pushing to Mainline

Force-pushing (`git push --force`) should be avoided, especially on shared branches like `main` or `master`. It can overwrite changes and cause confusion for other team members. Instead, use safer methods like rebasing or merging.

#### Reverting a Commit

If you need to undo a commit that has already been pushed:

```
# Revert the commit
git revert <commit-hash>

# Push the reverted changes
git push origin <branch-name>
```

### Git Commands for Various Workflows

#### Creating a Branch

```
# Create a new branch
git branch <branch-name>
```

#### Switching Branches

```
# Switch to an existing branch
git checkout <branch-name>
```

#### Cherry-picking a Commit

```
# Cherry-pick a commit from another branch
git cherry-pick <commit-hash>
```

#### Staging Changes

```
# Add changes to the staging area
git add <file1> <file2>
```

#### Committing Changes

```
# Commit with a verbose message
git commit -v
```

#### Amending the Last Commit

```
# Amend the last commit without changing the message
git commit --amend --no-edit
```

#### Adding Files Excluding Whitespace Changes

```
# Add files excluding whitespace changes
git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -
```

#### Viewing Unstaged Changes

```
# View unstaged changes
git diff
```

#### Rebasing Branches

```
# Rebase the current branch onto <base-branch>
git rebase <base-branch>
```

#### Merging Branches

```
# Merge <branch-name> into the current branch
git merge <branch-name>
```

#### Checking Remote Repositories

```
# List remote repositories
git remote -v
```

#### Pulling Changes from Remote

```
# Pull changes from the remote repository
git pull origin <branch-name>
```

## Working in a Multi-Team Environment

In a multi-team environment with multiple services or repositories, it's crucial to establish clear guidelines and workflows to ensure smooth collaboration. Here are some best practices:

### Repository Structure

* **Separate Repositories:** Each service or microservice should have its own repository to manage code changes independently.
* **Mainline Branch:** Use a designated `main` or `master` branch as the primary branch for production-ready code.

### Collaborative Workflow

* **Feature Branches:** Encourage each team to work on feature branches specific to their service.
* **Pull Requests:** Require code reviews and approvals before merging feature branches into `mainline`.
* **Cross-Team Communication:** Foster communication between teams to avoid conflicts and ensure compatibility between services.

### Git Workflows

#### Workflow for Team A

```
# Clone the repository
git clone <repository-url>

# Create a new feature branch
git checkout -b feature/new-feature

# Make changes, stage, and commit
git add .
git commit -m "Add new feature"

# Push the branch to remote
git push origin feature/new-feature

# Create a pull request for code review
```

#### Workflow for Team B

```
# Clone the repository
git clone <repository-url>

# Create a new feature branch
git checkout -b feature/another-feature

# Make changes, stage, and commit
git add .
git commit -m "Implement another feature"

# Push the branch to remote
git push origin feature/another-feature

# Create a pull request for code review
```

### Pipeline and Mainline Branch

* **Pipeline Safety:** Ensure that the `mainline` branch is always stable and deployable.
* **Continuous Integration (CI):** Set up automated tests and checks to validate changes before merging into `mainline`.
* **Branch Protection:** Use branch protection rules to prevent direct pushes to `mainline` and require pull requests for all changes.

### Example Workflow for Multi-Team Environment

#### Repository A (Service A)

```
# Clone Repository A
git clone <repository-a-url>

# Create a new feature branch for Service A
git checkout -b feature/service-a-feature

# Make changes, stage, and commit
git add .
git commit -m "Implement feature for Service A"

# Push the branch to remote
git push origin feature/service-a-feature

# Create a pull request for code review
```

#### Repository B (Service B)

```
# Clone Repository B
git clone <repository-b-url>

# Create a new feature branch for Service B
git checkout -b feature/service-b-feature

# Make changes, stage, and commit
git add .
git commit -m "Implement feature for Service B"

# Push the branch to remote
git push origin feature/service-b-feature

# Create a pull request for code review
```


Git offers powerful tools and workflows for collaborative development in multi-team environments. By adhering to best practices such as good commit messages, feature branches, and avoiding force pushes to mainline, teams can maintain a clean and stable codebase. Working with multiple teams across interconnected repositories or microservices requires clear communication, coordinated releases, and careful dependency management. Protecting the pipeline and mainline branch ensures the reliability and integrity of the codebase throughout development. With these practices in place, teams can leverage Git's capabilities to streamline development and deliver high-quality software efficiently.



