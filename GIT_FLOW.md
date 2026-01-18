# Git Flow Workflow Guide

## Overview
This project follows the Git Flow branching model. This document explains how to work with branches and contribute to the project.

## Branch Types

### 1. **main** (Production)
- **Purpose**: Production-ready code only
- **Protection**: Yes, requires approval
- **Deploy to**: Production (Render)
- **Who merges**: Team lead only

### 2. **develop** (Development)
- **Purpose**: Integration branch for development
- **Protection**: Yes, requires 1 review
- **Deploy to**: Development (Render)
- **Who merges**: All team members (after review)

### 3. **feature/\*** (Feature Development)
- **Purpose**: New features and enhancements
- **Pattern**: `feature/page-name` or `feature/description`
- **Create from**: `develop`
- **Merge back to**: `develop`
- **Examples**:
  - `feature/courses-page`
  - `feature/improve-navigation`
  - `feature/add-search`

### 4. **bugfix/\*** (Bug Fixes)
- **Purpose**: Bug fixes for features in development
- **Pattern**: `bugfix/issue-description`
- **Create from**: `develop`
- **Merge back to**: `develop`
- **Examples**:
  - `bugfix/homepage-styling`
  - `bugfix/form-validation`

### 5. **release/\*** (Release Preparation)
- **Purpose**: Preparing a new production release
- **Pattern**: `release/v1.0.0` (semantic versioning)
- **Create from**: `develop`
- **Merge back to**: `main` and `develop`
- **Deploy to**: Staging/QA (Render)
- **Examples**:
  - `release/v1.0.0`
  - `release/v1.0.1`

### 6. **hotfix/\*** (Emergency Fixes)
- **Purpose**: Critical production fixes
- **Pattern**: `hotfix/issue-description`
- **Create from**: `main`
- **Merge back to**: `main` and `develop`
- **Deploy to**: Production (Render)
- **Examples**:
  - `hotfix/critical-security-bug`
  - `hotfix/website-down`

## Workflow Examples

### Starting a New Feature

```bash
# Update develop branch
git checkout develop
git pull origin develop

# Create feature branch
git checkout -b feature/new-page-name

# Make changes and commit
git add .
git commit -m "feat: add new page structure"
git commit -m "feat: add styling for new page"

# Push to remote
git push -u origin feature/new-page-name

# Create Pull Request on GitHub
# Title: [FEATURE] New Page Name
# Description: What does this feature do?

# After review and approval, merge to develop
```

### Fixing a Bug

```bash
# Start from develop
git checkout develop
git pull origin develop

# Create bugfix branch
git checkout -b bugfix/fix-homepage-styling

# Fix the bug
git add .
git commit -m "fix: resolve homepage layout issue"

# Push and create Pull Request
git push -u origin bugfix/fix-homepage-styling

# After approval, merge to develop
```

### Preparing a Release

```bash
# Create release branch from develop
git checkout develop
git pull origin develop
git checkout -b release/v1.0.0

# Update version numbers, changelogs, etc.
git add .
git commit -m "chore: bump version to 1.0.0"

# Push release branch
git push -u origin release/v1.0.0

# Create Pull Request from release/v1.0.0 to main
# Title: Release v1.0.0

# After testing in staging and approval, merge to main
git checkout main
git pull origin main
git merge --no-ff release/v1.0.0

# Tag the release
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin main v1.0.0

# Merge back to develop
git checkout develop
git merge --no-ff release/v1.0.0
git push origin develop

# Delete release branch
git push origin --delete release/v1.0.0
git branch -d release/v1.0.0
```

### Emergency Hotfix (Production Issue)

```bash
# Create hotfix from main
git checkout main
git pull origin main
git checkout -b hotfix/critical-bug-fix

# Fix the critical issue
git add .
git commit -m "fix: resolve critical production issue"

# Push and create Pull Request to main
git push -u origin hotfix/critical-bug-fix

# After approval and testing, merge to main
git checkout main
git merge --no-ff hotfix/critical-bug-fix

# Tag the patch
git tag -a v1.0.1 -m "Hotfix version 1.0.1"
git push origin main v1.0.1

# Also merge back to develop
git checkout develop
git merge --no-ff hotfix/critical-bug-fix
git push origin develop

# Delete hotfix branch
git push origin --delete hotfix/critical-bug-fix
git branch -d hotfix/critical-bug-fix
```

## Pull Request Process

### Creating a Pull Request

1. **Push your branch**
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Go to GitHub**
   - Click "Compare & pull request"
   - Or go to Pull Requests → New Pull Request

3. **Fill in PR Details**
   - **Title**: Clear, concise description
   - **Description**: What changes were made and why
   - **Reviewers**: Select team members
   - **Labels**: bug, feature, documentation, etc.

### PR Title Format
```
[TYPE] Brief description

Examples:
[FEATURE] Add courses page
[BUGFIX] Fix responsive design
[DOCS] Update README
[CI/CD] Update GitHub Actions
```

### PR Description Template
```markdown
## Description
Brief explanation of what this PR does.

## Changes Made
- Change 1
- Change 2
- Change 3

## Files Changed
- src/filename.html
- src/styles/filename.css

## Testing
How to test these changes:
1. Step 1
2. Step 2

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex logic
- [ ] No new warnings generated
- [ ] Tested locally
- [ ] Updated documentation

## Related Issues
Closes #123
```

### Review Process

1. **Wait for Automated Checks**
   - CI pipeline must pass
   - All status checks must be green

2. **Request Reviews**
   - Minimum 1 reviewer for develop
   - Minimum 2 reviewers for main
   - Leave constructive comments

3. **Address Feedback**
   - Make requested changes
   - Push additional commits
   - Respond to all comments

4. **Approval and Merge**
   - All reviews approved
   - Ready to merge
   - Click "Merge pull request"

## Commit Message Guidelines

### Format
```
<type>: <subject>

<body>

<footer>
```

### Types
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that don't affect code logic (formatting, missing semicolons, etc.)
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `perf`: Code change that improves performance
- `test`: Adding or updating tests
- `ci`: Changes to CI configuration files
- `chore`: Changes to build process, dependencies, etc.

### Examples
```
feat: add courses page with course listings

fix: resolve responsive design issues on mobile

docs: update README with setup instructions

style: format code according to style guide

ci: add GitHub Actions workflow for staging
```

### Subject Line Rules
- Use imperative mood ("add" not "added" or "adds")
- Don't capitalize first letter
- No period (.) at the end
- Keep under 50 characters
- Be specific and descriptive

## Best Practices

### Before Committing
```bash
# Check what you're about to commit
git status
git diff

# Don't commit unwanted files
git add .gitignore
git add specific-file.js
```

### Write Good Commit Messages
```bash
# Bad
git commit -m "update stuff"
git commit -m "fix"

# Good
git commit -m "feat: add faculty page with profiles"
git commit -m "fix: resolve contact form validation error"
```

### Keep Branches Updated
```bash
# Before creating PR, update with latest develop
git fetch origin
git rebase origin/develop

# Or merge if you prefer
git merge origin/develop
```

### Delete Branches After Merge
```bash
# Delete local branch
git branch -d feature/completed-feature

# Delete remote branch
git push origin --delete feature/completed-feature

# Delete all merged branches
git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
```

## Common Commands

```bash
# List all branches
git branch -a

# Create and switch to new branch
git checkout -b feature/new-feature

# Switch to existing branch
git checkout develop

# Pull latest changes
git pull origin develop

# Push changes
git push origin feature/new-feature

# View commit history
git log --oneline

# View changes before committing
git diff

# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1

# Rebase to clean up commits
git rebase -i develop

# Merge with merge commit
git merge --no-ff feature/new-feature

# Squash commits before merge
git rebase -i develop
# Then mark commits as 'squash' or 's'
```

## Troubleshooting

### Accidentally Committed to Wrong Branch
```bash
# Create correct branch with your commits
git branch feature/correct-branch

# Reset current branch
git reset --hard origin/current-branch

# Switch to correct branch
git checkout feature/correct-branch
```

### Need to Undo a Merge
```bash
# Find the commit before merge
git log --oneline

# Reset to before the merge
git reset --hard <commit-before-merge>
```

### Conflicted Merge
```bash
# Resolve conflicts in your editor
# Then stage resolved files
git add resolved-file.js

# Complete the merge
git commit -m "Resolve merge conflicts"
```

## Team Guidelines

### Code Review Standards
- ✅ Code is clean and readable
- ✅ Follows project style guide
- ✅ No unnecessary code duplication
- ✅ Proper error handling
- ✅ Comments for complex logic
- ✅ Tests pass (if applicable)

### Approval Requirements
- **Feature branches → develop**: 1 approval minimum
- **Develop → release**: 1 approval minimum
- **Release → main**: 2 approvals minimum
- **Hotfix → main**: Team lead approval

### Merge Preferences
- Prefer **squash and merge** for feature branches (keeps history clean)
- Use **merge commit** for releases and hotfixes (preserves branch history)
- Use **rebase and merge** for small fixes to keep linear history

---

**Document Version**: 1.0
**Last Updated**: January 18, 2026
**Project**: University Computer Science Department Website
