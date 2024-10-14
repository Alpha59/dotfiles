
# Docker ECS Container Start-up
## Summary
**As an** RL Developer who is tired of working with Brazil and VersionSets **I want** A docker instance to run that will hold me ECS instances.

## Acceptance Criteria

* Should run a docker instance locally that holds the service and can be hit from PostMan
* Should run a docker instance locally that connects to the Beta Database
* Should run a docker instance locally that can be used with Docker-compose to interact with other services
* Should stand up a basic HTTP service that can return a ping response from PostMan
* Should have no Authorization except SSL enforcement
* Should contain no logic other than a basic Ping and Database Ping
* Should Deploy via CDK to the Pipeline and be accessible via PostMan
* Should Deploy via CDK to the Pipeline and should be able to ping Beta and Prod Envs.
