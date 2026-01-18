# GitHub Environments & Secrets Setup Guide

## Overview
This guide outlines how to set up the three required GitHub Environments with proper branch protection and secrets management for the University Computer Science Department Website project.

## Step 1: Create GitHub Environments

### Navigate to Settings
1. Go to your GitHub repository
2. Click **Settings** (top right)
3. In the left sidebar, click **Environments**

### Create Development Environment
1. Click **New environment**
2. Name: `development`
3. Click **Configure environment**
4. **Environment protection rules**:
   - Deployment branches: `develop`
   - Require reviewers: `No`
5. **Add secrets** (click "Add secret"):
   - Name: `DEV_RENDER_SERVICE_ID`
   - Value: `[Your Render service ID]`
   - Name: `DEV_WEBSITE_URL`
   - Value: `https://cs-dept-dev.onrender.com`
6. Click **Save protection rules**

### Create Staging Environment
1. Click **New environment**
2. Name: `staging`
3. Click **Configure environment**
4. **Environment protection rules**:
   - Deployment branches: `release/**`
   - Require reviewers: `Optional` (recommended)
5. **Add secrets**:
   - Name: `STAGING_RENDER_SERVICE_ID`
   - Value: `[Your Render service ID]`
   - Name: `STAGING_WEBSITE_URL`
   - Value: `https://cs-dept-staging.onrender.com`
6. Click **Save protection rules**

### Create Production Environment
1. Click **New environment**
2. Name: `production`
3. Click **Configure environment**
4. **Environment protection rules**:
   - Deployment branches: `main`
   - **Require reviewers: `Yes`** (IMPORTANT!)
   - Add team members or users who can approve
5. **Add secrets**:
   - Name: `PROD_RENDER_SERVICE_ID`
   - Value: `[Your Render service ID]`
   - Name: `PROD_WEBSITE_URL`
   - Value: `https://cs-dept.onrender.com`
6. Click **Save protection rules**

## Step 2: Add Repository-Level Secrets

1. In Settings, click **Secrets and variables** → **Actions**
2. Click **New repository secret**
3. Add the following secret (shared across all environments):
   - Name: `RENDER_API_KEY`
   - Value: `[Your Render API key from https://dashboard.render.com/account/api-keys]`

## Step 3: Configure Branch Protection Rules

### Protect 'develop' Branch
1. Go to **Settings** → **Branches**
2. Click **Add rule**
3. Branch name pattern: `develop`
4. Enable:
   - ✅ Require a pull request before merging
   - ✅ Require status checks to pass before merging
   - ✅ Require branches to be up to date before merging
   - ✅ Require code reviews before merging (require 1 review)
   - ✅ Dismiss stale pull request approvals when new commits are pushed
   - ✅ Require approval of the latest reviewable push
5. Click **Create**

### Protect 'main' Branch
1. Click **Add rule**
2. Branch name pattern: `main`
3. Enable:
   - ✅ Require a pull request before merging
   - ✅ Require status checks to pass before merging
   - ✅ Require branches to be up to date before merging
   - ✅ Require code reviews before merging (require 2 reviews)
   - ✅ Require approval of the latest reviewable push
   - ✅ Require status checks to pass before merging (require: develop)
   - ✅ Require deployment to successful to environments: `production`
4. Click **Create**

## Step 4: Configure Render Services

### Get Render Service IDs
1. Log in to Render Dashboard: https://dashboard.render.com
2. For each service, find the Service ID:
   - Click on the service
   - Copy the Service ID from the URL or settings

### Get Render API Key
1. Go to Render Dashboard → Account Settings
2. Scroll to "API Keys"
3. Generate or copy your API Key
4. Add to GitHub as `RENDER_API_KEY` secret

### Environment Variables in Render
For each Render service, add:
- Key: `ENVIRONMENT`
- Value: `development` / `staging` / `production` (respectively)

## Step 5: Verify Setup

### Check Workflow Files
Ensure these files exist and are properly configured:
- `.github/workflows/ci.yml` - Triggers on develop, release/*, main
- `.github/workflows/cd-dev.yml` - Triggers on develop branch
- `.github/workflows/cd-staging.yml` - Triggers on release/* branches
- `.github/workflows/cd-prod.yml` - Triggers on main branch

### Test the Pipeline
1. Create a feature branch: `git checkout -b test/setup-verification`
2. Make a small change (e.g., update README)
3. Push and create a Pull Request to develop
4. Verify CI pipeline runs
5. Merge to develop
6. Verify CD Dev pipeline deploys
7. Check Development website is updated

## Troubleshooting

### Pipeline Fails to Deploy
- Check GitHub Actions logs in Settings → Actions
- Verify all secrets are set correctly
- Confirm Render service IDs are correct
- Ensure RENDER_API_KEY has sufficient permissions

### Environment Not Found
- Re-check environment name spelling (case-sensitive)
- Verify environment is properly configured
- Clear GitHub Actions cache if needed

### Branch Protection Blocking Merges
- Ensure all status checks pass
- Get required number of approvals
- Update branch with latest main/develop
- Check protected branch rules in Settings

## Security Best Practices

1. **Never commit secrets** - Use GitHub Secrets exclusively
2. **Rotate API keys regularly** - Update RENDER_API_KEY periodically
3. **Limit reviewer access** - Only add team members who need approval authority
4. **Audit environment changes** - Review who has access to each environment
5. **Use branch protection** - Prevent accidental direct pushes to main/develop
6. **Monitor deployments** - Check Render logs for successful deployments

## Team Member Permissions

### Development Environment (develop branch)
- All team members can push to feature branches
- Merged to develop → Automatic deployment
- No approval needed

### Staging Environment (release/* branches)
- Team leads only
- Merged to release → Automatic deployment
- Optional approval recommended

### Production Environment (main branch)
- Team lead and designated approvers only
- Merge to main → Requires approval
- Requires 2+ approvals before deployment
- Always review before approving

---

**Setup Completed**: Yes ✅
**Date**: January 18, 2026
**Documentation**: Complete
