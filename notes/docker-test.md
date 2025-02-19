# AilorTypescriptDockerTest - @amzn/ailor-typescript-docker-test

## Overview

This project is a test package showcasing a Build system for Typescript with Docker and ECS. It includes the setup for a Typescript API using Node.js and Koa.
This project incorporates Docker into its build structure, leveraging PM2 as a process manager for Node applications. The addition of Docker enables easier deployment and scalability of the Typescript API.

Docker Compose is for simplified container management and incorporates NGINX as a reverse proxy. This enables efficient handling of HTTPS connections and distribution of requests across a cluster of PM2 instances.


## Prerequisites

Before getting started, make sure you have the following installed:


* [Node.js](https://nodejs.org/en/) (including npm)
* [Docker](https://www.docker.com/)
* [Amazon Brazil (brazil-cli)](https://builderhub.corp.amazon.com/tools/brazil/)

## Usage

```
  Available Commands:
    install: install npm from package.json. Does not run docker
    install <pkg>: install npm from package.json. Does not run docker
    start: runs the npm server without docker
           *supports hot reloading
    inspect-brk: runs the npm inspector without docker
           *supports hot reloading
    test: runs the npm build without docker
    test-single <tst>: Runs an npm test in npm-pretty-much
    test-watch <tst>: Runs an npm test in npm-pretty-much
           *supports hot reloading
    coverage: runs the npm build without docker
    typecheck: runs the npm build without docker
    npm <command>: Runs an npm command in npm-pretty-much
        build: Runs an npm build in npm-pretty-much
        inspect: Runs an npm inspect in npm-pretty-much
           *supports hot reloading

    build -d: runs the npm build without docker
    inspect -d: runs the npm inspector without docker
           *supports hot reloading
    release -d:

    build: runs the npm server inside docker
    server: runs the npm server inside docker
    inspect: runs the npm server inside docker

    up: runs the npm server inside docker
           *supports hot reloading
    down: runs the npm server inside docker
    logs: runs the npm server inside docker
    clean

OPTIONS:
        -v First -v will increase verbosity
           Second -v will increase verbosity more

        -d, --no-docker <branch> will prevent docker build from running
        -b, --no-rebuild <branch> will prevent docker build from running
```



## Brazil Build System

The Brazil Build System is a comprehensive code management system and build tool used at Amazon. It incorporates various concepts in the software development realm, such as compiling, versioning, dependency management, build reproducibility, artifact sharing, and artifact storage.

### Dependencies and Workspaces

* **Dependency:** A package that provides functionality required by another package to be compiled, tested, or run.
* **Direct Dependencies:** Dependencies explicitly declared by a package.
* **Transitive Dependencies:** Dependencies of direct dependencies, forming a transitive closure.
* **Workspace:** Associated with a version set determining the versions to use for dependency resolution during builds.

When building with Brazil, the NPMPrettyMuch and DockerFileBuild build systems work together to create a Brazil compatible container. The container has access to npm modules installed through NPMPrettyMuch, and Brazil VS Dependencies.

### Version Sets

* Each workspace is associated with a version set revision.
* During builds, a virtual version set consists of the workspace’s associated version set revision overlaid with the packages built in the workspace.

### Build Systems

* Custom build systems can be found in `build-tools/bin/custom-build`.

This Bash script is designed to manage and execute various development and build commands for a Node.js application within a Brazil build environment. Below is an explanation of key components and functionalities:

#### General Structure

* **Shebang:** `#!/usr/bin/env bash` - Specifies the Bash interpreter path.
* **Error Handling:** `set -ue` and `set -o pipefail` - Configures the script to exit if any command returns a non-zero status, and ensures that the entire pipeline exits if any command fails.
* **Variable Definitions:**
    * `SOURCE`: Path to the source code root directory.
    * `BUILD_TOOLS`: Path to the Brazil runtime farm tools.
    * `BUILD_OUTPUT_DIR`: Path to the build output directory within the Brazil environment.
    * `OUTPUT_DIR`: Current working directory appended with '/build'.
    * `brazil_build_tool_name` and `brazil_build_tool`: Names and paths for the npm build tool.
    * `brazil_sam_tool_name` and `brazil_sam_tool`: Names and paths for the SAM (Serverless Application Model) toolkit.
* **Commands:**
    * `echo "Build output Directory: $BUILD_OUTPUT_DIR"` - Outputs the build output directory.
* **Function Definitions:**
    * `printhelp()`: Prints a help menu explaining available commands and options.
    * `kill_docker_running_latest()`: Stops the latest running Docker container.
* **Logging Functions:**
    * `warn()`, `print()`, `info()`, `debug()`, `pass()`, `error()`: Colored console output functions for different log levels.
* **Trap Signal Definition:**
    * `trap_ctrlc()`: Function called when Ctrl-C is sent to perform cleanup.
* **Options Parsing:**
    * Parses command-line options such as `-v` for verbosity, `-d` or `--no-docker` to skip Docker execution, and `-b` or `--no-rebuild` to skip Docker build.
* **Docker-Related Commands:**
    * Docker commands for `up`, `down`, and `logs` using `docker-compose`.
    * The script checks if Docker-related commands are requested and executes them accordingly.
* **Build and Execution Logic:**
    * Determines the appropriate build tool commands based on user input and executes them.
    * Handles both scenarios where Docker execution is desired (`NO_DOCKER` is not set) and scenarios where Docker should be skipped.
* **Cleanup:**
    * Cleans up artifacts such as directories and Docker containers when necessary.
* **Additional Notes:**
    * The script integrates with Brazil build tools and follows a convention where certain commands can be executed in Docker or without Docker based on user preference.
    * It provides a flexible set of commands for building, testing, inspecting, and managing the Node.js application.

#### Usage

* The script is intended to be executed with various commands and options to perform specific actions related to the development lifecycle of a Node.js application within the Brazil build environment.

# Package Creation:

## Installation

1. Added a TypeScript definition file `tsconfig.json` to the project with the following content:

```
{
    "compilerOptions": {
        // ... (refer to the provided tsconfig.json)
    },
    "include": ["**/*.ts"],
    "exclude": ["build", "node_modules", "dist", "cdk.out"]
}
```



1. Created a new `app.ts` file as the base file to get started.

## Configuration

Updated `package.json` file to include the following server-related attributes:



```
{
  "scripts": {
    "clean": "rm -rf dist && rm -rf node_modules",
    "build": "tsc",
    "server": "tsc && node ./dist/app.js",
    "watch": "tsc -w --preserveWatchOutput",
    "prepublishOnly": "npm run build && npm run test",
    "test": "jest --collectCoverage --collectCoverageFrom=src/**/*.{ts,js} && generate-coverage-data --language typescript"
  },
  // ... (refer to the provided package.json)
}
```



## PM2

Before integrating Docker, PM2, a robust process manager, is configured for enhanced application management. An `pm2.config.js` file has been added to the project root with configurations for the main application and a watcher for development.


```
// pm2.config.js
module.exports = {
  apps: [
    // ... (refer to the provided ecosystem.config.js)
  ]
};
```



## Adding a Docker Container

To facilitate Docker integration, a Dockerfile has been created to build a container based on Amazon Linux. This Dockerfile installs essential dependencies, sets up Node.js with NVM, installs PM2, and copies the project files.


```
# Dockerfile
# ... (refer to the provided Dockerfile)
```



## Docker Compose

1. **Added a Docker Compose File:**

* Create a `docker-compose.yml` file for streamlined container management.

### Docker Compose Commands

Here are some useful Docker Compose commands to manage the containers defined in the `docker-compose.yml` file:


1. **Start Containers:**

```
brazil-build up;
```

* Starts the containers defined in the `docker-compose.yml` file.

1. **Start Containers in Detached Mode:**

```
brazil-build up;
```

* Starts the containers in the background.

1. **Stop Containers:**

```
brazil-build down
```

* Stops and removes the containers.

1. **View Container Logs:**

```
brazil-build logs
```

* Displays the logs from the running containers.

1. **Run a Command Inside a Service:**

```
docker-compose exec <service-name> <command>
```

* Executes a command within a specific service container. For example:

```
docker-compose exec app bash
```



1. **List Running Containers:**

```
docker-compose ps
```

* Lists the containers currently running.

1. **Build Images:**

```
docker-compose build
```

* Builds the images defined in the `docker-compose.yml` file.

1. **Rebuild Images and Force Recreate:**

```
brazil-build up --build --force-recreate
```

* Rebuilds images and forces recreation of containers.

1. **Scale a Service:**

```
brazil-build up --scale <service-name>=<number-of-instances>
```

* Scales the specified service to the specified number of instances.

These commands enhance the development and deployment workflow, providing flexibility and control over the containerized environment.


### NGINX Integration

NGINX has been added as a reverse proxy in the `docker-compose.yml` file to enhance the deployment:


```
version: '3'

services:
  app:
    build: ./
    image: typescript-docker-koa
    restart: always
    volumes:
      - ./:/app
    ports:
      - '3000:3000'
  nginx:
    build: ./nginx
    image: tiotobing/nginx
    container_name: nginx
    ports:
      - 80:80
```


This configuration sets up NGINX to act as a proxy for the application running in PM2, handling HTTPS connections and distributing requests across multiple PM2 instances in production.


## Testing

This project utilizes Jest for unit tests. Run the following command to execute the tests:


```
bb test;
```



## Building and Running

To build the server using Braziil, use the following commands:


```
brazil-build
```


To start the server locally, use:


```
bb server
```

This will start the server inside a docker container.
The server will be accessible at `http://localhost:3000`.

To start the server locally, use:


```
bb start
```

Which will allow hot-reloading, but not run inside the docker container.


### Building the Container

The Docker container can be built using the following command:


```
brazil-build;
OR
brazil-build build;
```


The initial build may take some time as it involves downloading dependencies.


### Running the Container

Once the container is built, it can be run with the following command:


```
brazil-build server;
```


To connect to a running container for further interaction:


```
brazil-build inspect;
```



## Hotswapping Code

For hotswapping code, utilize the following commands:


* Brazil Build and Start:

```
brazil-build build -d;
brazil-build start
```



* Braziil Build and Server:

```
brazil-build build -d;
brazil-build server
```



* Docker Build and Run (No Hot Reloading):

```
brazil-build;
brazil-build server;
```



* Docker Compose Up (Supports Hot Reloading):

```
brazil-build up;
```



## AWS SAM CLI

### Installation

AWS SAM CLI can be installed by following the instructions [here](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html).


### Features

The AWS SAM CLI provides various features for serverless application development:


* **Compile, Build, and Package Lambda Functions:**

```
sam build
```

* Compile, build, and package Lambda functions with provided runtimes or custom Makefile workflows.
* **Local Testing with Docker:**
* Test Lambda functions and API Gateway locally in a Docker container.

```
sam local start-api
```



* **Sync and Test Changes in the Cloud:**

```
sam sync
```

* Sync and test changes in the cloud with the `sam sync` command in your developer environments.
* **Deploy SAM and CloudFormation Templates:**

```
sam deploy
```

* Deploy SAM and CloudFormation templates to AWS.
* **Tail CloudWatch Logs and X-Ray Traces:**

```
sam logs
sam traces
```

* Tail CloudWatch logs and X-Ray traces for deployed applications.

### Local Development

To run the application locally, use the following commands:



```
sam build
sam local start-api
```


This will start the SAM server, and the API can be queried at `http://127.0.0.1:3000/`.

Alternatively, you can invoke the function locally:


```
sam local invoke "FunctionName" -e events/event.json
```



### SAM Package and Deployment

To deploy a SAM application, a combination of the following commands can be used:


```
sam package --s3-bucket "s3-bucket-name" --template-file "template-file" --output-template-file "output-file-name" --profile aws-profile
bats transform -x AWSLambda-1.0 -t $package-1.0 -p $package-1.0
sam deploy --template-file "srcout/template-generated.yml" --stack-name "cf-stack-name" --parameter-overrides "Key1=Value1 Key2=Value2" --capabilities CAPABILITY_IAM --profile aws-profile
```



### Remote Execution

After deploying an application, SAM can be used for remote execution:


```
sam remote invoke arn:aws:lambda:<region>:<account>:function:<function-name>
```


This is useful for executing a Lambda function that is already hosted locally, facilitating testing and data manipulation.


## Deploy the Sample Application

To deploy the sample application for the first time, use the following commands:


```
sam build
sam deploy --guided
```


The first command builds the application source, and the second command packages and deploys the application to AWS. Follow the prompts during the deployment process to customize settings such as stack name, AWS region, and IAM role creation.

After deployment, find the API Gateway Endpoint URL in the output values.


### Emulate API Locally

Run the API locally on port 3000:


```
sam local start-api
```


Query the local API:


```
curl http://localhost:3000/
```



### Logs

Fetch and tail Lambda function logs:


```
sam logs -n <function-name> --stack-name <app-name> --tail
```


For more advanced logging features, refer to the [SAM CLI Documentation](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-logging.html).



### Adding Resources

To add resources to your application, modify the `template.yaml` file using AWS SAM or standard AWS CloudFormation resource types.


### Additional Resources

Explore the [AWS SAM developer guide](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html) for more information on SAM specification, SAM CLI, and serverless application concepts.


## Testing Configuration

### Jest Configuration

To facilitate unit tests and integration tests, this project uses Jest as the testing framework. Here are some important points from the Jest configuration:


* **File Location and Naming:**
* The Jest configuration is stored in `jest.config.js` at the root of the project.
* Test files are expected to follow the naming convention of `*.test.ts` or `*.spec.ts`.
* **TypeScript Transformation:**
* TypeScript files are transformed using `ts-jest`.
* The `transform` section specifies that files with extensions `.ts` and `.tsx` should be transformed using `ts-jest`.
* **Test File Discovery:**
* The `testRegex` field defines the regular expression pattern used to discover test files.
* **Module Aliases:**
* The `moduleNameMapper` section provides aliases for module paths, making it easier to reference files within the project.
* **Code Coverage:**
* The `collectCoverageFrom` field specifies the files for which coverage should be collected.
* Coverage reports are generated in various formats such as JSON, text, HTML, and Cobertura.
* The `coveragePathIgnorePatterns` field excludes specific directories from coverage analysis, such as `node_modules` and `build`.
* **Coverage Thresholds:**
* The `coverageThreshold` section sets global coverage thresholds for branches, functions, lines, and statements.

These configurations can be adjusted based on project requirements, and the provided file is intended to serve as a starting point for testing in a Typescript environment with Jest

Below are explanations and usage details for the added scripts in the `package.json` file:


* **"test":
* **Explanation:** Runs Jest for unit tests and generates code coverage reports for TypeScript and JavaScript files in the `src` directory.
* **Usage:** `brazil-build test`
* **"coverage":
* **Explanation:** Similar to the "test" script but also triggers the generation of coverage data after Jest completes.
* **Usage:** `brazil-build coverage`
* **"test-single":
* **Explanation:** Runs Jest for unit tests without collecting coverage data.
* **Usage:** `brazil-build test-single <test-file>`
* **"test-watch":
* **Explanation:** Runs Jest in watch mode for continuous testing.
* **Usage:** `brazil-build test-watch <test-file>`
* **"typecheck":
* **Explanation:** Runs TypeScript compiler for type checking based on the specified `tsconfig.client.json`.
* **Usage:** `brazil-build typecheck`

## Debugging

Debugging is an essential aspect of the development process, helping identify and fix issues in the application. This section provides guidelines on debugging the Typescript API in Node.js, both locally and within a Dockerized environment.


### Local Debugging

#### Debugging with Braziil

1. Start the debugger:

```
brazil-build inspect-brk;
```


    This command breaks at the first line of the script, allowing you to set breakpoints before code execution starts.


1. Connect to the debugger:
    1. Open Chrome or any Chromium-based browser.
    2. Navigate to `chrome://inspect`.
    3. Under "Remote Target," find your Node.js application and click "inspect" to open the DevTools for debugging.

1. Set breakpoints:
    1. Click on the line number in the DevTools to set breakpoints.
    2. Use `debugger;` in your code or set breakpoints in the CLI using:

```
 break your_script.ts:10
```



1. Stepping through code:
    1. Use `cont` to continue execution until the next breakpoint.
    2. Use `step` to step into a function call.
    3. Use `next` to step over the current function call.

1. Inspecting variables:
    1. In the CLI, use the `repl` command or inspect variables in the DevTools "Scope" panel.
2. Watching expressions:
    1. In the CLI, use the `watch` command:

```
watch('your_variable')
```



1. Exiting the debugger:
2. Type `exit` in the CLI or close the Node.js process in the DevTools.

Brazil can also be used for debugging without a breakpoint at the start.


```
brazil-build inspect -d;
```

Follow the same procedure as described above.


### Dockerized Debugging

1. Start the Docker container in debug mode:

```
docker-compose up -f debug-compose.yml
```



1. Connect to the debugger from your local machine:
2. Follow steps 2-5 from the local debugging section.

### Tips and Tricks

* **Breakpoints:**
    * Place breakpoints directly in the source code.
    * Use conditional breakpoints by adding conditions.
* **Async/Await:**
    * Enable the "Async" checkbox in the Sources panel for tracking promises and async functions.
* **Watch Expressions:**
    * Add expressions to the Watch panel to monitor values.
    * Right-click on a variable in the Scope panel and choose "Add to Watch."
* **Console Statements:**
    * Use `console.log` for quick debugging.
    * The DevTools console is available even during debugging.
* **Step Controls:**
    * Use step buttons in the Call Stack panel to control execution flow.
* **Source Maps:**
    * Ensure source maps are generated for transpiled code.
* **Blackboxing:**
    * Exclude third-party or library code from debugging by blackboxing scripts.
* **XHR/Fetch Breakpoints:**
    * Set breakpoints on XMLHttpRequest or Fetch calls in the "Network" panel.
* **Live Edit:**
    * Make code changes in DevTools with "Live Edit."
* **Performance Profiling:**
    * Use the "Performance" panel to analyze code performance.
* **Memory Profiling:**
    * Utilize the "Memory" panel for identifying memory leaks.
* **Network Throttling:**
    * Simulate different network conditions in the "Network" panel.

### NPM Scripts for Debugging

* `brazil-build inspect -d`: Start the CLI Debugger.
* `brazil-build inspect-brk`: Start the CLI Debugger in a stopped state.

### VS Code Debugger Setup

Refer to [VS Code Node.js Debugging Guide](https://code.visualstudio.com/docs/nodejs/nodejs-debugging) for setting up the debugger in Visual Studio Code.


## How to find the latest image sha?

Guide to get list of images: https://docs.aws.amazon.com/AmazonECR/latest/userguide/amazon_linux_container_image.html


### Amazon Linux

1. Login:

```
   aws ecr get-login-password —region us-west-2 | docker login —username AWS —password-stdin 137112412989.dkr.ecr.us-west-2.amazonaws.com
```

1. Get list of available images:

```
   aws ecr list-images —region us-west-2 —registry-id 137112412989 —repository-name amazonlinux
```

1. Or search specifically for the image with the 'latest' tag

```
   aws ecr list-images —region us-west-2 —registry-id 137112412989 —repository-name amazonlinux | jq '.imageIds[] | select(.imageTag=="latest")'
```

1. Validate the details of the selected image

```
   aws ecr describe-images —region us-west-2 —registry-id 137112412989 —repository-name amazonlinux —image-ids=imageDigest=<imageDigest>
```

1. Check that the image is multiplatform

```
   docker manifest inspect public.ecr.aws/amazonlinux/amazonlinux@<imageDigest>
```

## Errors

If you get `Error saving credentials: error storing credentials - err: exit status 1, out: \`not implemented\``
you need to install and configure https://github.com/awslabs/amazon-ecr-credential-helper

