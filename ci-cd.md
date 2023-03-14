# Continuous Integration and Continuous Delivery

## Continuous integration - Always releasable

Small releasable commits to master
Combining code changes frequently, with each change verified on check-in.

* Small releasable commits
  * Committed to master
  * Passes Linting
  * Passes tests
  * Builds image

### Continuous integration why

* Work in smaller steps (Less waste)
* Avoid big merge conflicts
* Early commits allows other devs to build upon changes

## Continuous deployment - Automate deployment

Releasable software is automatically released on every commit

* Frequent deployments (every commit)
* Automated

## Continuous deployment why

* Release more frequently
  * Get more features/fixes out
  * Get feedback quicker
* Avoids user error
  * error prone
  * time consuming
* Safer deployments
  * Blue Green deployments
  * Canary deployments
* Deployment as code (No documentation/context)

## Continuous delivery (CD)

Continuous integration + Continuous deployment
Add to releasable software quickly + Deploy releasable software quickly

### Continuous delivery why

* Deploying new features/fixes faster so that you can get feedback quicker
* Eases the entire process
* Less risky than a big change and big deployment

### Steps

* Always releasable
  * Small commits to master that pass linting and tests
* Automate builds
  * Build script that run automatically (e.g. after each commit, new tag)
* Build as code
  * Build scripts in version control
* Use CD service
  * Runs on build server
* Ephemeral environments
  * Fresh build environment and image each run. (Avoid persisted state)

## DORA metrics

* Velocity
  * Deployment frequency (Multiple a day)
  * Lead time for change OR Commit -> production time (< One hour)
* Stability
  * Time to restore service (< One hour)
    * Roll back on breaking release
    * Blue green deployments
    * Canary deployments
  * Change failure rate (< 15%)

## Versioning

* Semantic versioning 1.2.3 (Major.Minor.Patch)
  * Major - Broke stuff since last major version
  * Minor - Added stuff since current major
  * Patch - Fixed stuff since current minor

* Pin version to ensure using working version
