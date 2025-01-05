# Continuous delivery

## What is - Continuous Integration (CI)

Frequently committing small tested releasable changes to master/main

1. Small releasable commits
1. Verified
    - Pass Linting
    - Pass Tests
    - Build image
1. Push to master/main
1. CI Runs

### Why - Continuous Integration

- Work in smaller steps (Less waste)
- Avoid big merge conflicts
- Early commits allows other devs to build upon changes

### What is - Continuous deployment

Automate deployment on every commit

### Why - Continuous deployment

- Manually deploying is error prone and time consuming
- Safer deployments
  - Blue/Green deployments
  - Canary deployments
- Deployment as code (No documentation/context needed)

## What is - Continuous delivery (CD)

`continuous integration + continuous deployment = continuous delivery`

### Why - Continuous delivery

- Quickly and easily deploy new features/fixes with feedback
- Less risky than a big deployment
  - As deployment contains many changes it's difficult to
  identify which change is problematic

### How

- Always releasable
  - Small commits to master that pass linting and tests
- Automate builds
  - Build script that run automatically (e.g. after each commit, new tag)
- Build as code
  - Build scripts in version control
- Use CD service
  - Runs on build server
- Ephemeral environments
  - Fresh build environment and image each run. (Avoid persisted state)

## DORA metrics

- Velocity
  - Deployment frequency (Multiple times a day)
  - Lead time (commit -> production) is less than an hour
- Stability
  - Time to restore service (< One hour)
    - Roll back on breaking release
    - Blue green deployments
    - Canary deployments
  - Change failure rate (< 15%)
