
# Migrate Applications to Docker-compose
## Summary
[//]:# (This should be descriptive enough to frame the Story, at a high level, as well as include any additional resources needed to complete the Story.)

**AS a** customer(s)
**I WANT** ...
**SO** ...

## Additional Context
[//]:# (This should be descriptive enough to frame the story as well as include any additional resources needed to accomplish the Story.)

RDE support for ECS applications is on a deprecation path. If you are starting new, do not use RDE to test your ECS service. Start by experimenting with running your application using Docker. If you have any questions, see Support. In 2023, we will release new tools and guidance for testing ECS services.

One time steps pre-docker compose
1. Install docker, docker compose & ada etc. and get your dev desktop ready with all the goodies
2. Run `brazil-build` in all the packages
3. Run `brazil-bootstrap` in your both main service package and image package
4. In your brazil workspace run `bats transform -x DockerImage-1.0 -t <MainServicePackage>-1.0 -p <Image buildPackage>-1.0`

The above steps will give you a docker image, run `docker images` to get the `image-id` of the images as you will need them in docker compose file

Now, when attempting to make changes in your package, Start the service locally

run `docker compose up` from local-setup folder

When making changes to the service locally:

run `bb build` then `docker container restart <name>`

Example CR: https://code.amazon.com/reviews/CR-104803093/revisions/2#/diff

AWS Documentation: https://aws.amazon.com/blogs/compute/a-guide-to-locally-testing-containers-with-amazon-ecs-local-endpoints-and-docker-compose/

## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the story. Each line starts with 'should have'.)
[//]:# (Refer to https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats for more information on Acceptance Criteria formats)

- Should have added a docker-compose file to the package
- Should have run the service locally using docker-compose
- Should have tested that service can still run in ECS from personal account
- Should verify that service can connect to Database and downstream services from local

