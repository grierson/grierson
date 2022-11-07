# Continuous Delivery

* Continuous integration - Always releasable
  * Small commits to master
  * Linting
  * Passing tests
  * Builds image

* Continuous deployment - Automate deployment
  * So could deploy on every commit
  * Avoid manual deployment (flakey, time consuming)
  * Builds on ephemeral environments

* Continuous delivery (CD)
  * Continuous integration + Continuous deployment

* DORA metrics
  * Velocity
    * Deployment frequency (Multiple a day)
    * Lead time for change OR Commit -> production time (under 1 hour)
  * Stability
    * Time to restore service
    * Change failure rate

## Steps

* Always releasable
  * Small commits to master that pass linting and tests
* Automate builds
  * Build script that run automatically (e.g. after each commit, new tag)
* Build as code
  * Build scripts in version control
* Use CD service
  * Build on build server
* Ephemeral environments
  * Fresh build environment and image each run. (Avoid persisted state)

## Versioning

* Semantic versioning 1.2.3 (Major.Minor.Patch)
  * Major - Broke stuff since last major version
  * Minor - Added stuff since current major
  * Patch - Fixed stuff since current minor

* Pin version to ensure using working version
