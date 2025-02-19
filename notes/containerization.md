# Containerization

Containers from a high level are any system that uses OS-Level virtualization to abstract the kernel layer into an isolated environment. This paradigm has been referred to as Containers, Zones, Virtual Private Servers, partitions, virtual environments, and virtual kernels throughout the development history of computing. Programs running inside of containers are not able to access hardware level resources that have not been assigned to the container. This can include isolation from the hardware (CPU, Network interface), data storage mechanisms, or the peripheral devices. The kernel or operating system can often give access to these resources, but dependent on the container system, there may be additional security mechanisms in place.

## Why use containers?

Containers offer a number of advantages over traditional compute platforms. The most obvious benefit, is the security from a malicious program accessing resources without the knowledge of the executing user. This was the original purpose of many container systems (including the lowest level unix container system: chroot). More modern container systems focus on the advantages of portability, low overhead, and deployment flexibility.

Although containers do not inherently provide a version-able control system to put the containers internal infrastructure into code, this is a growing trend in popularity - as more containers move towards being a deployment mechanism. Containers are a large part of the Cloud Ecosystem, as they allow the seperation of Physical assets (bare metal) and the virtual machine that an end user has access to.

Since containers can be a high level abstraction of operating system level programs, the overhead of a container can be reduced down to only the resources required for that container. This is different from a fully virtual machine, which will still need to manage hardware resources, including CPU execution, RAM, and Storage. Containers benefit from the operating system that they are running on, by utilizing the existing system calls instead of needing to emulate, or reproduce the system calls that would be created in a virtual machine. This makes containers extremely portable, as they are able to run on any hardware system.

A major focus of the modern container ecosystem has been an increased flexibility. Where as virtualization need to be installed separately on each machine, a container infrastructure focuses on the distribution of containerized resources, which can be run on a single application. This also allows a large number of containers to be run and controlled within a single application, or on  a single machine.

## History

Applications are at the heart of most businesses, and nearly all publicly available applications are run off of servers. In the days before cloud computing, it was common for a single application to be deployed to a single server - and the server would not have any additional applications running on it. This was an early solution to many of the persistent problems that containers attempt to resolve. This solution was born from the lack of sandboxing techniques available on the common Windows and Linux server Operating systems of the time.

As a result, every time a new application needed to be deployed, a new physical server needed to be provisioned to contain the code, and deployments needed to be organized for the individual server. Since performance requirements were unknown for many applications prior to launch, it was standard practice to over estimate the computing power, and memory needed for an application. When that application needed to scale, vertical scaling (bigger computer) was the standard solution. Some estimations claim that servers operated at 5-10% of their total capacity due to over estimation.

As “the cloud” became a more prevalent form of computing,  a new form of computing was also born - known as a virtual machine. Virtual Machines offered a mechanism to run multiple applications (and complete Operating systems) on a single physical hardware infrastructure. This allowed both in house IT, and cloud computing technologies, to over provision on the physical hardware, but ensure that 90% of the capacity was not being saved for applications that would not use the entire capacity.

Every Virtual machine required it’s own dedicated operating system. This, in turn, means that each VM consumed a high amount of CPU, RAM, and other resources, to maintain the operating system - opposed to the application. Operating systems are also deployed with a high number of default programs (Internet explorer?) which do not need to be included for most applications to function properly. This led to Virtual machines running slowly, booting slowly, and being difficult to port between Physical Machines.

Containers were designed to address this short coming, by creating an isolated environment on top of the existing Operating system, which could be easily moved between physical hardware, and could consume only the required resources for it’s application interface. Containers are also much faster to provision, and start up, since they do not require installing the entire operating system.

[Timeline Found here: https://blog.aquasec.com/a-brief-history-of-containers-from-1970s-chroot-to-docker-2016](https://blog.aquasec.com/a-brief-history-of-containers-from-1970s-chroot-to-docker-2016)

Although Linux Containers were the original technology used by Google, Amazon, and Yahoo!, these containers faced a number of issues - primarily on the developer front, where they did not duplicate functionality between different host architectures. Eventually, the Docker Technology was born to act as a ubiquitous container solution - and has been adopted by AWS, Google, Microsoft, and 80% of technology development companies as a way to provide an accessible and democratized container solution.

## Brazil

What is brazil? Great question. No one knows. I think it’s a country.

According to builderHub though, Brazil Build System is the code management system and build tool used at Amazon. It encompasses a number of different concepts, including compiling, versioning, dependency management, reproducibility, artifact sharing, and artifact storage. The Brazil build system can be accessed through [build.amazon.com](http://build.amazon.com/).


>The Brazil Build System is the code management system and build tool used at Amazon. It encompasses a number of different concepts in the software world including compiling, versioning, dependency management, build reproducibility, artifact sharing, and artifact storage.


In brazil, the use of a package is the smallest deployable unit. Packages are often grouped together to create a single functional application. Typically a package is created through octane, which is an internal Amazon tool that creates a Git repository, adds some boilerplate code, and registers the package with Brazil’s package version set tooling. Since Brazil Packages are just specially formatted Git repositories, you can also use a Brazil CLI to publish an existing Git repo into Brazil’s package management system: `brazil-octane package promote`

Once a package is created, it can be built into code artifacts using the CLI for Brazil Build. These artifacts are built in a sandboxed environment, and are tagged with information from the Git Repository. Built artifacts are what are eventually released into Version Sets. Once an artifact has been added to a VersionSet, or published in anyway - it is forever accessible to other developers. This allows deprecated packages to remain in use long after they are no longer maintained.

Ultimately, there is only 1 file needed to define a brazil package - the `Config` file, which acts as the version control file, the dependency management file, the consumer definition file, and the build definition file. Inside the Config file (which uses a custom syntax based on perl), a number of directives (or keys) can be defined. These include the `build-system`, which defines which build tools should be used to build the package, and `dependencies`, which defines what other brazil packages your package is dependent on. Once the build system and dependencies are defined, the output of a build must also be defined. The `build-targets` directive specifies the output of the build, and is used when another package requests this package as a dependency to find the executable code in the artifact.

One major concept inside of Brazil’s package management system is the idea of “Never Build Twice”. Packages are always referenced by a specific hash that points to a single artifact (stored by brazil’s artifact repository), and does not need to be rebuilt for each update. This reduces the number of items that need to be rebuilt, especially since brazil will locally cache these package artifacts - but means that a package is never updated automatically, and always points to a single version. It also means, that packages need to be built for the specific environment on which they will be run, since various computer architectures may handle the execution of package code differently. If a package has not been built for a specific architecture, it will not be available. Brazil uses the concept of VersionSets to manage the package dependency tree. This Dependency tree is a structure that defines all of the artifacts which need to be used in a single package revision. The number of dependencies to any Brazil Package will range in the thousands at a minimum, just from the build tools.

### Structure

Brazil build systems are really just other build systems, wrapped in the version set dependency tree. Java Builds still happen using Ant, C builds use Make, Node.js builds occur using NPM (Pretty Much). Only a few build systems are funded projects, and the rest are community managed. Creating a build system is possible, and can be done for any specific tooling requirements, but is normally avoided in favor of expanding the functionality of the build system that brazil is calling.

A combination of packages in Brazil is known as a Workspace. A workspace defines for the brazil build system, which packages are connected together, and how these packages need to be combined to create a working build. Brazil is tightly coupled with the Apollo concept, and utilizes “magic” functionality to pull in overrides from the local build environment. These overrides are defined at the deployment machine level, and function to bypass dependencies within the VersionSet defined dependency tree.

When building a package into your workspace, brazil creates a package cache of all the dependencies on your local machine. This package cache allows you to retain a single version of each dependency in the dependency tree, and is available at a global level in your build environment. The package cache will need to be deleted on a regular basis, since it takes up a large amount of storage space, and is closely tied to the build environment. Dependencies shared across multiple builds will often contain meta data that is not compatible with multiple builds.

In order to make a package dependency available in the VersionSet, you must build it into the Brazil Package VersionSet by accessing the service at build.amazon.com. Once a package is built in, it is likely to be rebuilt multiple times as it is dependent on other packages that may need to be rebuilt. Packages are then deployed to Apollo.

### Strengths of Brazil

Brazil is tightly coupled with other internal Amazon tools - including Coral, Pipelines, GitFarm, and Apollo. This makes brazil irreplaceable. Literally, other tools do not work without brazil, so you need to use Brazil. Technically, Brazil is not coupled to any of these (except Apollo environments), but they are all built on the assumption that a brazil build exists already. Brazil Built tools are also almost always tightly coupled with various internal tools (normally coral specifically) and assume that a system is designed to conform to a specific build structure.

Brazil sees VersionSets as it’s strongest feature, creating a dependency tree with a single source for artifacts to be pulled from, artifact caching, and of course - the Live VersionSet. VersionSets also provide a SnapShot functionality - allowing a user to tie their release to a specific version of the version set, opposed to managing the dependencies. This is seen as a good thing too.

Really, brazil offers only two major strengths compared to any other build system:


1. It’s used across Amazon, so the Live VersionSet contains nearly the entire codebase of the company - making it the source of code.
2. Coral is tightly integrated with Brazil, and the use of Coral is universal to Amazon.

Since the above two things are true (and debatably strengths) it is impossible to move away from Brazil. Consumers can not pull in dependencies in another way, since they are only available in the Live VersionSet, or through Brazil... and you won’t be able to call anyone else if you don’t use Coral RPC protocols.

### Short Comings of Brazil

Brazil pre-dates many other package build systems by several years, and therefore struggles with some of the issues that these systems have resolved. The first weakness of brazil is it’s inability to integrate third party  dependencies, and provide a seamless development environment for systems not built on Brazil. This is seen primarily in libraries being built into specific directories that the library code is unable to find it’s own dependency code within. Another issue this causes, is that all external dependencies need to be integrated with brazil before they can be consumed. This limits access to open source, or free use technologies. This problem leaks into brazil deployment builds, since there is not a consistent path that can be used from build time to consumption time for a given dependency. This prevents easy import management, since there is not known fixed location. It can also lead to inconsistent imports, since multiple build paths may contain different artifacts which will be consumed.

A second short coming is the ability to run multiple versions of the same package in the same dependency tree. Brazil does not support this, and requires that all packages in the tree appear with only one set. This leads to issues around being able to upgrade direct and indirect dependencies anytime a breaking change is introduced. Modern package dependency libraries rely on each dependency to maintain it’s own versioning, so that higher level applications are not dependent on package dependency upgrades in dependent systems.

Brazil differs from a real containerized system in one major way. It does not build into the system-root, or depend on it. This is a complex conceptual difference, but can be broken down by the history. Originally, applications were built on a specific machine - and required the build system to work on that specific machine. Brazil moved away from this concept by wrapping the build system in a kernel free environment that abstracted away the underlying system. Containers solved this problem by creating a sandboxed system environment that virtualized the system-root.

Brazil was ultimately design to work as part of a monolithic structure, which created a single application to be deployed, and was interconnected between all of the packages in that deployment. This led to a series of design decisions that were not present in the design of containerized systems. The largest issue, is the upgrading of consumers, which is a process that can take over a year - because each dependency must be upgraded to the new Major Version from a dependency tree managed manually by developers. This means that a single unmanaged dependency - can halt an entire upgrade. Similarly, since Brazil packages were meant to build on specific systems, it was designed so that all dependencies for the build are part of the VersionSet. Since this is not however enforced in any meaningful way (since Brazil is not a container), many builds are dependent on the local machine libraries to complete. This leads to unpredictable behavior - and the classic “It works on my machine” problem.

Of course, with any internal tool - external tools will not be built to handle, or account for their existence. This can be seen in the complete short coming of IDE support for the build system, and the often broken tooling surrounding the brazil system. Since external tools do not test, or consider Brazil, Brazil continues to require additional work arounds to maintain compatibility. These work arounds are difficult to document, and often completely undocumented, as they quickly become part of the Amazon knowledge base.

Finally, since Brazil deployments are statically linked together, they do not contain the ability to provide dynamic loading of artifacts. This means that artifacts in the brazil environment is always dependent on rebuilding, even in a scripting language.

## Docker

Docker is a software that runs on Linux, Windows, and Mac operating systems. It creates and manages “Docker” containers. The software is build from the various tools developed as part of the predeceasing “Moby” project. Docker Inc is a for profit Platform as a Service Company which invented the open source technology Docker. The Docker technology is composed of three different layers:

* Runtime
    * `containerd`
        * higher level runtime
    * `runc`
        * lower level runtime
* Daemon (engine)
    * Remote API
    * Networking
    * Volumes
    * Image Management
* Orchestrator
    * Cluster management of Docker Nodes

The docker runtime operates at the lowest level, and is responsible for the starting and stopping of docker containers. This includes creating and managing the OS constructs. The low level `runc` manages the lifetime of the container, starting and stopping them. The higher level `containerd`  is in charge of pulling images, creating network interfaces, and managing the lower level operations in `runc`.

The Docker daemon (engine) sits above the runtime, and manages all of the higher level tasks, such as exposing the remote API, managing the images, volumes, and networks. The Daemon’s primary job is to abstract the lower level processes that would typically interact with the operating system, and move them into a standard interface.

Docker natively supports an orchestrator, known as “Docker Swarm”, but this technology is not scalable in real world production environments, and is typically replaced with either Kubernetes or Elastic Container Service.

Docker can be natively installed on nearly any computing machine, and is typically installed directly on a developers machine for testing and development purposes. This works well with docker, since the OS is abstracted, and the runtime environment for all applications running inside of the docker environment will be the same across any hosting OS or machine. This portability ensures that the “It built on my machine” issue is no longer prevalent in the development community.

Docker Images are objects that contain the entire OS filesystem, application, and application dependencies. These are often thought of as “Virtual Machine Templates” defining a base Image, and then all of the application code needed to build and deploy the application that is being run. Docker images can be found in a variety of abstractions - including with entire development or production environments pre-installed. Some Docker images default to having application code pre-deployed, so that developers can avoid any configuration at all.

The typical use of a Docker image though is to start with a Base image representing only the required OS, and then install the dependencies (NPM, Node, Python) inside of the container image. A common image is `ubuntu:latest` which as the name suggests, pulls the latest version of Ubuntu for developers to build on. This image can be pulled into a windows, linux, or mac host - and will operate in an identical manner. Although Windows images do exist, they are generally avoided due to the excessive size of the operating system directives required. A higher level image, such as Nginx will contain the image, and the source information needed to run the default Nginx application that has been installed.

### Usage

The most basic deployment of a container would have no additional setup, and can be run using a command similar to:

`docker container run -it ubuntu:latest /bin/bash`

which will create an ubuntu container, and start the bash shell. A more complex docker container will be configured using a Dockerfile, which will tell docker what commands to run in order to set-up the environment. Docker Compose is a CLI tool used to launch and manage multiple different container types, giving them appropriate access connections between them.

A Dockerfile is a template, extending the IaC concepts, that defines how to create the Image to run the application in. An example can be seen here


```
FROM ubuntu:latest
RUN apt-getnodejs nodejs-npm
COPY . /src
WORKDIR /src
RUN npm install
EXPOSE 8080
ENTRYPOINT ["node", "./app.js"]
```

The above example of a container will create the environment needed to execute `app.js` using node. The exposed port 8080 will be the port that the docker container can be contacted through. The `RUN` command on line 2 is telling the container to run a specific ubuntu command to install the runtime environment. Once a container is running, you can connect and disconnect using the docker CLI tool - allowing you to enter and exit a running container to execute commands. This very simple Dockerfile defines the entire runtime of the application, allowing the node server code to be executed in the container, with all of the information that it needs. Node will not be installed on the local machine by running this Dockerfile.

### Under the hood

The Docker engine is designed to be modulate, and is based heavily on the open source standards created by the Open Container Initiative (OCI). Since docker is compatible with the OCI standard, OCI Compliant containers can be run by the docker engine, even if they are not docker containers. In the same way, the docker engine is not required to run Docker containers, as long as the underlying engine is OCI compliant.

A Docker Image is a packaged unit containing everything required for an application to run. This includes, application code, dependencies, and required OS constructs. If you have a Docker image, then the only thing needed to create a Docker container is a computer running the docker engine.

Images are typically stored in an image registry, so that they can be shared and accessed across an organization (or the public). Images are made of multiple layers that are stacked on top of each other to create a single object. Since containers are intended to be fast and lightweight, images (excluding windows) tend to be small. Images are intended to run a single application, and are therefore intended to be as small and stripped down as possible. Images do not contain a Kernel, and will share the host kernel across all images. The official Alpine Linux image is only 5MB in size, and contains only the bare bones definition of the Alpine linux operating system that is required to run an application.

Containers, opposed to Images, are the runtime instance of an Image definition. Images can be instantiated into containers as many times (including on the same host) as required. Containers are intended to be as fast and lieghtweight as possible, instead of containing a full blown Operating system. Containers can be stopped and started without being destroyed once they are instantiated - and will hold memory between their runtimes. A Docker container will stop once the application has stopped running. This functionality is useful in many cases where the docker container is executing a non-service application.

### Dockerizing an Application

The process of taking an application, and configuring it to run inside of a container is known as “containerizing”. In the Docker spectrum, this requires only 4 steps:


1. Start with Application code and dependencies
2. Create a Dockerfile that describes the app and dependencies
3. Feed the Dockerfile into the docker build command
4. Run the container from the image (Dockerfile).

Just like the “Config” file, the “Dockerfile” must be spelled exactly as that. Dockerfiles can be used to document the application running time, dependencies and dependency decisions. This helps to clarify any information about the runtime environment of the application.

Each command in the application (RUN, COPY, etc) create a new layer - which has access to all the previous layers. This is relatively unimportant, but is notable for debugging purposes, and understanding how caching works when creating the Image (enabling rapid deployments). This layering system allows only the application code to be reloaded when starting or restarting the image. Certain instructions (EXPOSE, WORKDIR) do not create layers, and are simply creating meta data for the container.

Leveraging the build cache means that the first build may take a longer time, but subsequent builds with no changes to the container should happen nearly immediately. The environment is not being re-created, simply re-started. Each layer can be cached separately, so only the modified layers need to be re-built.

The Commands available in Docker are as follows:


* `FROM` the base container to begin building from. A Dockerfile may have multiple `FROM` statements to pull in multiple dependent images - however this is a tricky process since all images must be compatible and built to work together.
* `RUN` will create a new layer, and executes commands (typically bash) directly inside the container. This is where most installation occurs, and where new layers are created
* `COPY` adds files into the image as a new layer. This is typically used to copy your application code into an image
* `EXPOSE` creates a network port for the application to be accessed through
* `ENTRYPOINT` this is the application code that will be run when the image is started as a container

Although there are other commands, these primary commands are used to create any docker image and container. Combined with other IaC tools, the Dockerfile can be a powerful mechanism for creating, managing, and versioning the Runtime environment of an application. The CRUX and Builderhub team both utilize Docker to build brazil hosts.

### Docker Compose

Docker compose is an additional tool provided by the docker community to define a multi-container development environment. a `docker-compose.yml` file is used to define multiple applications that can be created and used together. A compose file can contain any commands that would typically be passed through a CLI, so it works well to simplify the development process and provide a standard set of development tools across a team. Docker Compose can be used to tie a default OS port to the Docker port being exposed, enable live reloading of volumes, and specify the build directory where a DockerFile lives.

Docker compose allows multiple isolated environments to run on a single host (multiple dependent services?)  which can be linked together, and their ports can be changed. A docker-compose file may be integral to the development of a project (Starting a mongoDB instance locally to run against) or may be feature development dependent (starting 2 services to build a single feature).

When working with docker compose, you are able to copy volumes into the container as they are modified (live-reloading) which allows updates to interpreted languages to be immediately reflected upon change. Although this is useless for compiled languages (Java) this feature means that a developer only needs to “Build” an interpreted language once in order to see the changes. In the same way, docker compose will only recreate containers which have changed. When a service is restarted, compose can re-use the existing containers, meaning that there is no need to rebuild each dependency in the workspace.

Since docker compose supports extending, a common development practice is to tie all dependent service layers together in the docker-compose file, and then have a single workspace that imports the required services. Docker compose is also used heavily in integration testing, where multiple changed and unchanged system may need to be loaded into a single environment in order to test their connections and changes.

## ECS

Elastic container service is a highly scalable, fast, container management service that allows the rapid deployment and management of containers onto a cluster. Containers are defined as task definitions, or Docker images, which can be run as individual tasks, or as a service. ECS allows deployment onto either server-less infrastructure through Fargate, or provisioned capacity through an EC2 Cluster.

ECS is available as a regionalized service that is highly available across multiple availability zones within a region. Container images are pulled from the Amazon Elastic Container Registry, which supports a number of container types. In order to prepare an application to run on ECS, you will create a task definition file. This task definition is a JSON file that describes one or more containers that form an application. This can be considered an equivalent to the Production docker-compose file. Within this task definition, you can specify the scaling capabilities, and the number of tasks that will run within a cluster.  Using CDK, this task definition file can be defined directly in the ECS CDK stack.

## Fargate

Fargate is a server-less solution designed to remove the need for provisioned EC2 instances. It is designed to work specifically with ECS, and makes it easy to focus on building applications. Fargate removes the need to provision and manage services - letting you only use the resources needed for an application, and improving application security through containerized isolation.

Fargate scales to use the correct amount of computing resources within a cluster, so there can not be an overloaded application, or an underloaded server running.

## Conclusion

AWS has been building out an impressive resume of Container compatible services, which ease development, and allow much better server-less architecture and deployments. Docker can help developers get the most out of their development environment, and out of their production code scalability. Unfortunately, Amazon’s internal Package management system prevents moving away from their own internal “Container” build system. For the time being, it will continue to be the case that both systems will need to be used in tandem. As the server-less architecture becomes more of a requirements for users, there will be a significant increase in the use of container builds to create complex applications - without needing to manage complex infrastructure. This trend will continue to grow as we move forward with more complex applications, running on simplified infrastructure provisioning needs. Containers continue to provide huge benefits for developers, and server-less environments.

