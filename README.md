# University Computer Science Department Website

A professional, fully containerized, and automatically deployed departmental website implementing complete DevOps practices including Git Flow, CI/CD pipelines, Docker containerization, and multi-environment deployment.

## 📋 Project Overview

This project demonstrates a complete end-to-end DevOps workflow by building a static website for a Computer Science Department. The website is containerized using Docker and automatically deployed to three separate environments (Development, Staging/QA, and Production) using GitHub Actions CI/CD pipelines.

### Key Features
- 🎨 **Responsive Design**: Mobile-friendly, modern UI
- 🐳 **Docker Containerization**: Optimized multi-stage Dockerfile
- 🔄 **Git Flow Workflow**: Proper branching strategy
- 🚀 **CI/CD Pipelines**: Automated testing, building, and deployment
- 🔒 **Secrets Management**: GitHub Environments with protected secrets
- 📦 **Multi-Environment Deployment**: Dev, Staging, and Production
- ✅ **Code Quality**: HTML/CSS linting and validation

## 🏗️ Project Structure

```
University-Department-Website/
├── src/                          # Source files
│   ├── index.html               # Home page
│   ├── courses.html             # Courses page
│   ├── faculty.html             # Faculty page
│   ├── admissions.html          # Admissions page
│   ├── contact.html             # Contact page
│   └── styles/
│       └── style.css            # Shared stylesheet
├── .github/workflows/           # GitHub Actions workflows
│   ├── ci.yml                   # CI pipeline (lint & build)
│   ├── cd-dev.yml              # CD for development
│   ├── cd-staging.yml          # CD for staging/QA
│   └── cd-prod.yml             # CD for production
├── Dockerfile                   # Docker image definition
├── nginx.conf                   # Nginx web server config
├── .gitignore                   # Git ignore rules
└── README.md                    # This file

```

## 📄 Web Pages

### 1. **Home Page** (`index.html`)
- Department overview and mission statement
- Key highlights and achievements
- Quick navigation to other sections
- Hero banner with call-to-action

### 2. **Courses Page** (`courses.html`)
- Core, advanced, and elective courses
- Course descriptions and availability
- Registration information
- Prerequisites and credit hours

### 3. **Faculty Page** (`faculty.html`)
- Faculty member profiles
- Specializations and research areas
- Office hours and contact information
- Research focus areas

### 4. **Admissions Page** (`admissions.html`)
- Bachelor's and Master's programs
- Admission criteria and requirements
- Application process timeline
- Important deadlines
- Tuition and financial aid information

### 5. **Contact Page** (`contact.html`)
- Contact information and office details
- Contact form
- Quick links
- Google Maps integration
- Office hours

## 🐳 Docker Setup

### Dockerfile Features
- Multi-stage build for optimization
- Nginx Alpine base image for minimal size
- Health check implementation
- Gzip compression enabled
- Cache busting for static assets

### Building the Docker Image
```bash
docker build -t university-cs-dept:latest .
```

### Running the Container
```bash
docker run -p 8080:80 university-cs-dept:latest
# Access at http://localhost:8080
```

## 🔄 Git Flow Strategy

### Branch Structure
- **main**: Production-ready code (Protected)
- **release/\***: Release candidates (e.g., release/v1.0.0)
- **develop**: Development branch (Protected)
- **feature/\***: Feature branches (e.g., feature/new-page)
- **bugfix/\***: Bug fix branches (e.g., bugfix/homepage-styling)
- **hotfix/\***: Hotfix branches (e.g., hotfix/critical-bug)

### Branch Workflow
```
feature/new-page → develop → release/v1.0.0 → main (production)
                      ↓
                  [CD to Dev]    [CD to Staging]    [CD to Prod]
```

### Creating a Feature Branch
```bash
git checkout develop
git pull origin develop
git checkout -b feature/your-feature-name
```

### Merging Back to Develop
```bash
git push origin feature/your-feature-name
# Create Pull Request on GitHub
# After review and approval, merge to develop
```

## 🚀 CI/CD Pipelines

### Continuous Integration (CI)
**Trigger**: Push to `develop`, `release/*`, or `main`

**CI Pipeline Steps**:
1. Checkout code
2. Install linting tools
3. Lint HTML files
4. Lint CSS files
5. Build Docker image
6. Cache Docker layers

**File**: `.github/workflows/ci.yml`

### Continuous Deployment - Development
**Trigger**: Push to `develop`

**CD Dev Pipeline Steps**:
1. Build Docker image
2. Push to GitHub Container Registry
3. Deploy to Render (Development service)
4. Verify deployment

**File**: `.github/workflows/cd-dev.yml`

### Continuous Deployment - Staging
**Trigger**: Push to `release/*`

**CD Staging Pipeline Steps**:
1. Build Docker image with release tag
2. Push to GitHub Container Registry
3. Deploy to Render (Staging service)
4. Run smoke tests
5. Verify staging deployment

**File**: `.github/workflows/cd-staging.yml`

### Continuous Deployment - Production
**Trigger**: Push to `main` or tag creation (v*)

**CD Production Pipeline Steps**:
1. Build optimized Docker image
2. Push to GitHub Container Registry
3. Deploy to Render (Production service)
4. Verify production deployment
5. Run health checks
6. Alert on failure

**File**: `.github/workflows/cd-prod.yml`

## 🔑 GitHub Environments Setup

### Three Protected Environments Required:

#### 1. **Development Environment**
- Environment Name: `development`
- Required Secrets:
  - `DEV_RENDER_SERVICE_ID`: Your Render service ID
  - `DEV_WEBSITE_URL`: Development website URL (e.g., https://cs-dept-dev.onrender.com)
- Deployment branches: `develop`
- No approval required

#### 2. **Staging/QA Environment**
- Environment Name: `staging`
- Required Secrets:
  - `STAGING_RENDER_SERVICE_ID`: Your Render service ID
  - `STAGING_WEBSITE_URL`: Staging website URL (e.g., https://cs-dept-staging.onrender.com)
- Deployment branches: `release/*`
- Optional: Require approvals

#### 3. **Production Environment**
- Environment Name: `production`
- Required Secrets:
  - `PROD_RENDER_SERVICE_ID`: Your Render service ID
  - `PROD_WEBSITE_URL`: Production website URL (e.g., https://cs-dept.onrender.com)
  - `RENDER_API_KEY`: Render API key (shared across all envs)
- Deployment branches: `main`
- **REQUIRED**: Require approval before deployment

### Setting up GitHub Environments

1. Go to Settings → Environments
2. Create three new environments: development, staging, production
3. For each environment:
   - Add required secrets
   - Configure deployment branches
   - For production: Enable "Required reviewers"

## 📦 Render.com Setup

### Creating Three Render Services

1. **Development Service**
   - Name: `cs-dept-dev`
   - Public: Yes
   - Build Command: (Leave empty for static site)
   - Start Command: (Leave empty)
   - Save environment variables

2. **Staging Service**
   - Name: `cs-dept-staging`
   - Public: Yes
   - Same configuration as Dev

3. **Production Service**
   - Name: `cs-dept-prod`
   - Public: Yes
   - Same configuration as Dev

### Required Environment Variables (in Render)
Set these in each Render service:
- `ENVIRONMENT`: development/staging/production

## 👥 Team Member Assignments

| Sr # | Name | Role | Assigned Page | Workflow |
|------|------|------|---|---|
| 1 | [Team Lead Name] | Team Lead | Home Page | CI Pipeline (ci.yml) |
| 2 | [Developer 1] | Developer | Courses Page | CD Dev (cd-dev.yml) |
| 3 | [Developer 2] | Developer | Faculty Page | CD Staging (cd-staging.yml) |
| 4 | [Developer 3] | Developer | Admissions Page | CD Production (cd-prod.yml) |
| 5 | [Developer 4] | Developer | Contact Page | Git Flow Setup |

## 🔐 Secrets Management

### Required GitHub Repository Secrets (Shared across environments)
```
RENDER_API_KEY=<your-render-api-key>
```

### Required Secrets per Environment

**Development Environment**:
```
DEV_RENDER_SERVICE_ID=<service-id>
DEV_WEBSITE_URL=https://cs-dept-dev.onrender.com
```

**Staging Environment**:
```
STAGING_RENDER_SERVICE_ID=<service-id>
STAGING_WEBSITE_URL=https://cs-dept-staging.onrender.com
```

**Production Environment**:
```
PROD_RENDER_SERVICE_ID=<service-id>
PROD_WEBSITE_URL=https://cs-dept.onrender.com
```

## 📋 Getting Started

### Prerequisites
- Git installed
- GitHub account
- Docker installed (for local testing)
- Render.com account

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/University-Department-Website.git
   cd University-Department-Website
   ```

2. **Create a development branch**
   ```bash
   git checkout -b feature/your-feature
   ```

3. **Make your changes**
   - Edit HTML/CSS files in the `src/` directory
   - Test locally by opening `src/index.html` in a browser

4. **Test with Docker**
   ```bash
   docker build -t test-website .
   docker run -p 8080:80 test-website
   # Visit http://localhost:8080
   ```

5. **Push and create Pull Request**
   ```bash
   git add .
   git commit -m "feat: add new feature"
   git push origin feature/your-feature
   # Create PR on GitHub against 'develop' branch
   ```

6. **Merge after approval**
   - Wait for CI pipeline to pass
   - Request review from team members
   - Merge to develop branch
   - CD pipeline automatically deploys to development

## 🔄 Release Process

1. **Create Release Branch**
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b release/v1.0.0
   ```

2. **Update version and prepare release**
   - Update documentation
   - Final testing in release branch
   - Push to GitHub

3. **Create Pull Request to Main**
   - PR from `release/v1.0.0` to `main`
   - CD Staging pipeline runs automatically
   - After testing, merge to main
   - CD Production pipeline runs with approval

4. **Tag the Release**
   ```bash
   git tag -a v1.0.0 -m "Release version 1.0.0"
   git push origin v1.0.0
   ```

## 🧪 Testing

### Local Testing
```bash
# Test HTML/CSS locally
npm install --save-dev html-validate stylelint stylelint-config-standard
npx html-validate 'src/**/*.html'
npx stylelint 'src/**/*.css'

# Test Docker build
docker build -t university-cs-dept:test .
docker run -p 8080:80 university-cs-dept:test
```

### Automated Testing in Pipelines
- HTML validation in CI pipeline
- CSS linting in CI pipeline
- Docker build verification
- Smoke tests in staging
- Health checks in production

## 📝 Contributing Guidelines

### Code Style
- Use semantic HTML5
- Follow CSS naming conventions (BEM methodology)
- Keep lines under 100 characters
- Add comments for complex logic
- Ensure responsive design (mobile-first)

### Commit Messages
```
<type>: <subject>

feat: add new feature
fix: resolve bug
docs: update documentation
style: format code
refactor: restructure code
test: add tests
ci: update CI/CD pipeline
```

### Pull Request Process
1. Create feature branch from develop
2. Make changes and commit
3. Push to remote
4. Create Pull Request
5. Wait for CI pipeline to pass
6. Request review from team members
7. Address feedback
8. Merge after approval

## 🚨 Troubleshooting

### Pipeline Failures
1. Check GitHub Actions logs
2. Verify secrets are set correctly
3. Ensure branch protection rules are configured
4. Check Render service logs

### Deployment Issues
- Verify Render API key is valid
- Check service IDs match Render account
- Ensure environment variables are set
- Review Docker build output

### Docker Build Issues
- Verify nginx.conf syntax
- Check file paths in Dockerfile
- Ensure all required files are present

## 📚 Resources

- [Git Flow Cheat Sheet](https://danielkummer.github.io/git-flow-cheatsheet/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Documentation](https://docs.docker.com/)
- [Render Deployment Guide](https://render.com/docs)
- [Nginx Documentation](https://nginx.org/en/docs/)

## ✅ Evaluation Criteria

- ✅ Repository setup and collaboration (10 marks)
- ✅ HTML/CSS development and page quality (25 marks)
- ✅ Dockerization and CI pipelines (20 marks)
- ✅ Multi-environment CD pipelines (25 marks)
- ✅ Git Flow, branch protection, and documentation (20 marks)

**Total: 100 marks**

## 📞 Support

For questions or issues, please:
1. Check existing GitHub Issues
2. Create a new Issue with detailed description
3. Contact the Team Lead
4. Review troubleshooting section above

## 📄 License

This project is licensed under the MIT License - see LICENSE file for details.

---

**Last Updated**: January 18, 2026
**Project Status**: Active Development
**Team Lead**: [Your Name]
