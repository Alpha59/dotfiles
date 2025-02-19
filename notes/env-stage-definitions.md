# Environment/Stage Definitions and Expectations

This document will be used to house definitions and expectations of each of our service environments.


# Use Cases

* Prod
* Prod patching (version set) library
    * This should be caught by functional tests
* PreProd
    * Teams outside our need to connect to a non-Prod version of our services
* Local testing (docker compose)
* Data migration testing
    * Change in schema
    * Should be handled with functional tests or unit tests
    * Shouldn’t require a long-lived environment
    * Should be able to do with an ephemeral environment with a data snapshot from an S3 bucket
* Functional tests
    * Core functionality of the service
    * Should be independent of integration tests
    * Should be capable of being run locally
        * If created with Hydra, can be run locally with Hydra CLI
    * Could be run with reviewers on CRs
        * Currently doesn’t seem to be a way to do this
* Integration tests
    * Persistence layer
    * Dependencies internal and external to our team
    * Shouldn’t go through functional layer to do this
        * Dependency layer, testing that connections are valid
    * This should be able to be run in each environment
        * Does docker connect to database and AFT?
        * Does Prod connect to its dependencies?
* Onebox/Blue-green deployments
* AWS Service changes
    * We need to know if some AWS service change is going to break our services
    * Can be tested by both ephemeral or long-lived environments as long as there are consistent deployments
* Alarms
    * Should be on a dashboard
        * Check dashboard for stages like Beta
        * Having a dashboard with all of our services in one place



# Stages

## Local Environment/Development

* Developer environment, local testing
    * `docker compose`
* Our idea of beta could be replaced with ephemeral environments that are torn down
    * Deploying into existing environments isn’t covered with ephemeral deployments
    * There are some other issues with burner accounts (database issues?)
    * Cuts down on blocking each other with testing
    * Can pull from multiple feature branches
* Where do we test infrastructure changes?
    * We want to be able to test in a lower environment before CR
* Want something that tests database/other services connections
    * Dependencies we don’t own
        * We need CloudAuth connections to call other dependencies
            * This is set up once in a long-lived environment
            * This *might* have to be set up every time for spun-up environments
                * Proxy through a Beta account could get around this, but requires more investigation
                * This Beta account would be long-lived, but it wouldn’t have long-lived stale versions of services
                    * Shut down the cluster when it’s not being used
* Data migration testing
    * Change in schema
    * Should be handled with functional tests or unit tests
    * Shouldn’t require a long-lived environment
    * Should be able to do with an ephemeral environment with a data snapshot from an S3 bucket
* Functional tests
    * Core functionality of the service
    * Should be independent of integration tests
    * Should be capable of being ran locally
        * If created with Hydra, can be ran locally with Hydra CLI
        * Changes to the tests will be present, but changes to the service must be pushed to the AWS account
    * Could be ran with reviewers on CRs
        * Currently doesn’t seem to be a way to do this
* AWS Service changes
    * We need to know if some AWS service change is going to break our services
    * Can be tested by both ephemeral or long-lived environments as long as there are consistent deployments
        * Tested when deployed to burner or personal account

## Version Set

* Prod patching (version set) library
    * This should be caught by functional tests

## Beta

* Alarms
    * Should catch items like “website not loading”
    * Testing business-critical functionality
        * May take the place of “smoke tests”
    * Shouldn’t cut tickets
    * Incorporate a dashboard that should be checked before letting changes move through to Gamma
* Functional tests
    * Core functionality of the service
    * Should be independent of integration tests
    * Used for accountability and transparency
    * Ensures no functionality has been broken
        * Incorporates current changes pulled from live
* Integration tests
    * Persistence layer
    * Dependencies internal and external to our team
    * Shouldn’t go through functional layer to do this
        * Dependency layer, testing that connections are valid
    * This should be able to be run in each environment
        * Does docker connect to database and AFT?
        * Does Prod connect to its dependencies?
* AWS Service changes
    * We need to know if some AWS service change is going to break our services
    * Functional/integration tests run against it

## Gamma

* Holds Production code, acts as a PreProd stage
    * This is Prod code, you’re not going to be breaking Prod
* Final smoke test/more alarms
* Blue/green environment, swap Gamma with Prod when Gamma is fully updated/functional/tested
    * Onebox/Blue-green deployments
* Functional tests
    * Core functionality of the service
    * Should be independent of integration tests
    * CONCERN: Sending out junk data
        * Since this stage is connected to Prod for other services, our tests could cause issues with data sent
        * Could have Gamma use a read replica of the Prod database
            * Refresh once a week
        * Could block write operations
* Integration tests
    * Persistence layer
    * Dependencies internal and external to our team
    * Shouldn’t go through functional layer to do this
        * Dependency layer, testing that connections are valid
    * This should be able to be run in each environment
        * Does docker connect to database and AFT?
        * Does Prod connect to its dependencies?
* Alarms
    * Cut tickets
    * Alarms should block deployments from continuing to Prod

## Prod

* Holds Production code
* Integration tests
    * Persistence layer
    * Dependencies internal and external to our team
    * Shouldn’t go through functional layer to do this
        * Dependency layer, testing that connections are valid
    * This should be able to be run in each environment
        * Does docker connect to database and AFT?
        * Does Prod connect to its dependencies?
* Alarms
    * Cut tickets, higher severity

## Punt

* Smoke tests — PUNT
    * UI Smoke tests
    * Similar to an alarm (might just be things that are alertable)
    * Should be testing business critical functionality
    * Narrow subset of functional tests
        * Ran on CR
        * Also used in Prod as alarms
    * Need to run in Prod
        * Sev2able if running in Prod
    * Once an hour these are ran, one minute to run, cut a sev2 if fail
* Load testing — PUNT
    * Makes sense to run in Prod
    * *Maybe* only need for printing or carrier scan
    * Might not make sense at all
* Chaos testing — PUNT
    * Tested via usage
    * Evaluating fault tolerance, more useful for Tier-1 services


