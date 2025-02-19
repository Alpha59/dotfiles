# Typescript vs Java for Device Returns ECS Service

Let's outline the pros and cons of both TypeScript (an interpreted language) and Java (a compiled/JVM language) for the specific use case we face, considering factors such as technical abilities, development speed, and interaction with the AWS environments utilized by the team. Many of the arguments can be applied to multiple languages that are either JVM based, or Interpreted. This paper focuses on Java and Typescript because the team has experience in both - and has narrowed the field of possible languages choices for the upcoming project to these 2.

When choosing a programming language for a microservice, several factors specific to microservices architecture should be considered. Here are some key items relevant to language choice for a microservice:

## MicroService General

Microservices architecture is an approach to building software applications as a collection of loosely coupled, independently deployable services. Here's how microservices work from a technical perspective:

1. **Runtime Environment**:
    1. Each microservice typically runs within a runtime environment, which could be a container, a virtual machine, or a serverless platform.
    2. Microservices communicate with each other over the network, usually using lightweight protocols such as HTTP, REST, gRPC, or messaging queues.
2. **Invocation**:
    1. Microservices are invoked by other services, clients, or events in the system.
    2. When an event occurs that requires the functionality provided by a microservice, a request is sent to the microservice over the network.
3. **Cold Starts**:
    1. Cold starts in microservices typically occur when a new instance of a service needs to be initialized to handle incoming requests.
    2. Factors contributing to cold starts include container provisioning (if using containers), runtime initialization, and application startup tasks.
    3. Cold starts can also occur when scaling up or down the number of instances of a service in response to changes in demand.
4. **Memory Allocation**:
    1. Each instance of a microservice may have memory allocation, depending on the runtime environment and deployment configuration.
    2. Memory allocation affects the performance and resource utilization of the microservice. Allocating more memory can improve performance, but may also increase costs.
5. **State Management**:
    1. Microservices can be designed to be stateless or stateful, depending on the requirements of the application.
        1. The code in our Microservices is always Stateless. State is provided by Databases.
            1. By Definition, a Microservice with a persistence layer is Stateful.
            2. A microservice with in-memory state provided by the code would also be stateful.
        2. Stateless microservices do not maintain any state between invocations and rely on external data stores or services for persistence.
            1. These Microservices are typically orchestrators or proxy services.
        3. Stateful microservices maintain state between invocations, either in memory or using external storage solutions such as databases or caches.
6. **Threading and Concurrency**:
    1. Threading and concurrency models vary depending on the programming language, runtime environment, and framework used to implement the microservice.
    2. Many modern programming languages and frameworks support asynchronous programming and concurrency primitives to handle multiple concurrent requests efficiently.
        1. Typically, the web-server being utilized provides the primary threading in a Microservice.

**Impact on Language Choice**:

* **Cold Starts**: Languages with faster startup times and lower initialization overhead, such as interpreted languages like Node.js, Python, or Go, may be preferred for microservices where minimizing cold start latency is critical.
* **Memory Allocation**: Languages that can efficiently utilize memory resources and optimize memory usage are advantageous for microservices to maximize performance and minimize costs.
* **State Management**: Languages with strong support for integrating with external data stores and services are beneficial for implementing microservices that require persistence of state.
* **Threading and Concurrency**: Languages with built-in support for asynchronous programming and lightweight concurrency models can handle multiple concurrent requests effectively, making them suitable for high-throughput microservices.

The language choice for microservices should consider factors such as cold start performance, memory utilization, state management capabilities, and concurrency support to optimize performance, scalability, and resource efficiency in a microservices’ architecture.

### **Service Granularity**

Microservices are designed to be small, focused, and independently deployable. The team must first consider how well-suited a language is for building small, cohesive services that encapsulate specific functionality. Languages that offer lightweight frameworks, modular design patterns, and minimal boilerplate code can facilitate the development of microservices with the appropriate level of granularity.

* **Typescript**
    * Dynamic ecosystem and flexibility make it suitable for rapid prototyping and lightweight microservices.
* Java
    * Prioritizes robustness and enterprise-grade features.
    * Mature ecosystem and strong typing provide efficient vertical scalability for large-scale, compute heavy, microservice architectures.


### **Resource Efficiency**

Microservices run in containerized environments with limited resources. Evaluating how efficiently a language uses system resources, including memory, CPU, and disk space, will inform the language choice. Languages with lightweight runtimes, efficient memory management, and minimal overhead can help optimize resource utilization and reduce operational expenses in a microservices’ architecture.

* **TypeScript**
    * Lightweight runtime and event-driven architecture make it well-suited for microservices requiring efficient memory management and handling of asynchronous I/O operations.
    * Excels in scenarios with high concurrency and I/O-bound workloads, where minimizing resource usage is critical.
* Java
    * Robust virtual machine, mature JIT compilation, and strong typing provide scalability and performance optimization for CPU-intensive tasks and long-running computational tasks.
    * Java applications may have higher initial resource overhead, they can achieve efficient resource utilization over long periods of time, especially for compute-intensive workloads.

>In a [Benchmark](https://programming-language-benchmarks.vercel.app/java-vs-typescript): Java utilized 2.8 times more Memory on average for computational programs. In the same benchmark, Rust consistently utilized the smallest amount of memory.



### **Scalability**

Our microservices’ architectures rely on horizontal scalability to handle varying workloads and accommodate growth. Considering factors such as concurrency models, parallel processing capabilities, and support for asynchronous programming, which can enable microservices to scale horizontally and handle concurrent requests effectively.


* **TypeScript**
    * Event-driven, non-blocking I/O model and lightweight concurrency facilitate scalability in scenarios with high concurrency and I/O-bound workloads.
    * Excels in handling large numbers of concurrent connections efficiently without the overhead of traditional thread-based concurrency models.
* Java
    * Robust concurrency utilities and thread-based concurrency model provide scalability and parallelism for both I/O-bound and compute-bound microservices.
    * Java incurs overhead in managing thread lifecycles and synchronization, its comprehensive threading mechanisms enable efficient resource utilization and parallel processing.
        * Java threading requires explicit design choice to be utilized.

A Robust explanation of Threading in Java and Node.js can be found in this [Medium Article](https://medium.com/modern-mainframe/multithreading-in-java-vs-node-js-c558d59050c9).


>On a single core, Java took an average of 14 times longer to make 10 localhost http requests.
Spread across 4 cores, Java took an average of 2.2 times longer.



### **Fault Isolation and Resilience**

Microservices need to be resilient to failures and capable of isolating faults to prevent cascading failures across the system. A language facilitates fault isolation and resilience through features such as fault-tolerant programming constructs, retry strategies, and distributed tracing. Languages with built-in support for resilience patterns or libraries/frameworks that simplify fault tolerance can help improve the robustness of microservices.

* TypeScript
    * Event-driven, non-blocking I/O model and lightweight concurrency facilitate fault isolation and resilience in asynchronous and I/O-bound microservices.
    * Flexible error handling mechanisms and integration with modern JavaScript frameworks enable developers to implement fault-tolerant patterns effectively.
* Java
    * Robust exception handling mechanisms, comprehensive concurrency utilities, and mature ecosystem of resilience libraries offer resilience and fault tolerance for a wide range of microservices architectures.
    * Java’s strong typing and static analysis capabilities promote error handling and fault isolation practices.


### **Inter-Service Communication**

Microservices often communicate with each other over the network using lightweight protocols such as HTTP. Each option must consider how well a language supports building and consuming web services and APIs. This includes evaluating the availability of libraries, frameworks, and tooling for implementing communication patterns like request-response, pub-sub, and event-driven architectures. Additionally, assessments of the language's performance, reliability, and ease of integration with service discovery, load balancing, and message queuing systems.

* **TypeScript**
    * Event-driven, non-blocking I/O model and lightweight runtime make it well-suited for asynchronous communication patterns over HTTP, such as RESTful APIs and pub-sub messaging.
* Java
    * Mature ecosystem and strong typing support enable developers to build scalable and reliable microservices with extensive support for HTTP communication using frameworks like Coral.


### **Developer Productivity**

Microservices development involves frequent iteration, testing, and deployment cycles. Choosing a language that promotes developer productivity and agility is crucial to continued success. Considering factors such as language syntax, tooling support, debugging capabilities, testing frameworks, and documentation quality. Languages with expressive syntax, a rich ecosystem of libraries, and strong community support can help developers iterate quickly and maintain code quality in a microservices’ environment.

* **TypeScript**
    * Dynamic typing, concise syntax, and modern language features promote rapid prototyping and iterative development, making it well-suited for scenarios emphasizing development speed and agility.
    * Strong typing, static analysis, and comprehensive tooling support enable developers to build scalable and maintainable microservices efficiently.
* Java
    * Strong typing, static analysis, and comprehensive tooling support enable developers to build scalable and maintainable microservices efficiently.
    * Less syntax sugars or possibilities, so less possible to read hard-to-understand code written by teammates.
    * It’s supported well in Amazon community (sage etc.) and we will find relatively more help for existing docs.


### **Operational Overhead**

The operational overhead associated with managing microservices written in a particular language includes factors such as deployment complexity, monitoring requirements, logging standards, and observability capabilities. When assessing operational overhead in managing microservices, both TypeScript and Java present different considerations:

* **TypeScript**
    * Microservices typically have lower operational overhead in terms of deployment complexity, as they are often lightweight and straightforward to deploy.
* Java
    * Microservices, while having higher deployment complexity, benefit from an ecosystem of monitoring, logging, and observability tools tailored for Java applications, reducing operational overhead in these areas.


### Data Marshalling

When considering data marshalling in the context of microservices, both TypeScript and Java provide mechanisms for serializing and deserializing data to facilitate communication between services:


* **TypeScript:**
    * **Serialization Libraries**: TypeScript offers various built-in libraries for data marshalling, with JSON being the most common format. Functions like `JSON.stringify()` and `JSON.parse()` built into JavaScript allow for straightforward serialization and de-serialization of JSON data.
    * **Type Safety**: TypeScript's static typing provides a level of safety during data marshalling. TypeScript's interface definitions can enforce data structures, ensuring that serialized data conforms to expected schemas.
* Java:
    * **Serialization Frameworks**: Java provides serialization mechanisms through frameworks like Jackson, Gson, and JAXB offer support for JSON and XML marshalling, providing flexibility in choosing serialization formats.
    * **Annotation-based Mapping**: Java frameworks like Jackson and Gson offer annotation-based mapping to serialize Java objects to JSON and vice versa. Annotations like `@JsonProperty` and `@SerializedName` allow developers to customize serialization and de-serialization behavior.


### Hot Reloading

When it comes to hot reloading code during development, TypeScript provides built in support due to being an interpreted language.

* **TypeScript**:
    * Offers seamless hot reloading in Node.js and frontend development environments.
    * Requires minimal setup with tools like `nodemon` or HMR-enabled bundlers.
    * Provides a fast feedback loop during development, enhancing developer productivity.

TypeScripts out-of-the-box support for hot reloading in Node.js and frontend development environments is not comparable to any Java standards or practices.

* **Java**
    * Support in different ways, such as JSP.
    * Not well-known to all our current team members.


## ECS Fargate

When considering a programming language for microservices running in an AWS ECS Fargate environment, several factors specific to ECS Fargate should be considered.

AWS ECS (Elastic Container Service) Fargate is a serverless container orchestration service provided by Amazon Web Services (AWS) that allows running containers without managing the underlying infrastructure. Here's how AWS ECS Fargate works from a technical perspective:


1. **Containerized Environment**:
    1. ECS Fargate enables deploying and managing containerized applications without provisioning or managing servers.
    2. Define application architecture using tasks and services, where each task specifies the containers to run and their configurations.
    3. Fargate handles the underlying infrastructure, including server provisioning, scaling, and maintenance, allowing a focus on building and running applications.
2. **Runtime Environment**:
    1. ECS Fargate supports containers based on Docker images, allowing any programming language or framework supported by Docker.
    2. Each container runs within its own isolated environment, ensuring resource isolation and security between containers.
3. **Cold Starts**:
    1. Unlike serverless compute services like AWS Lambda, ECS Fargate does not have cold start issues in the same way.
    2. Containers in ECS Fargate are scheduled and run as long-running tasks, so there's no delay in container startup when handling incoming requests.
    3. When scaling up or down the number of tasks or services, there may be a brief delay as new containers are provisioned, or existing containers are terminated.
4. **Memory Allocation**:
    1. Specific memory and CPU resources are allocated to each container in the ECS task definition.
    2. Memory allocation affects the container's performance and resource utilization. Allocating more memory can improve container performance, but will also increase costs.
5. **State Management**:
    1. ECS Fargate containers are stateless intentionally, similar to AWS Lambda functions. Each container instance is independent and isolated from other instances.
    2. If you need to maintain state between container invocations, you can use external storage solutions such as Amazon DynamoDB, Amazon RDS, or other databases.
6. **Threading and Concurrency**:
    1. ECS Fargate containers can leverage the threading and concurrency capabilities provided by the programming language or framework used to build the containerized application.
    2. Each container instance runs in its own isolated environment, allowing for parallel execution of multiple containers without concerns about thread safety or resource contention.

**Impact on Language Choice**:

* **Memory Allocation**: Languages that can efficiently utilize memory resources and optimize memory usage are advantageous in ECS Fargate. Choosing an appropriate memory allocation based on the memory requirements of your containerized application can impact performance and cost.
* **State Management**: Languages that support seamless integration with external storage solutions for state management, such as databases or object storage services, are beneficial for maintaining state between container invocations in ECS Fargate.
* **Threading and Concurrency**: Languages that support lightweight concurrency models and asynchronous programming paradigms can effectively handle multiple concurrent requests within a containerized application in ECS Fargate.

Overall, the language choice for containerized applications in ECS Fargate should consider factors such as memory utilization, state management capabilities, threading and concurrency support, and compatibility with external services to optimize performance, scalability, and resource utilization in the containerized environment.

### **Containerization Compatibility**:

ECS Fargate runs microservices within containers, which encapsulate the application code, dependencies, and runtime environment. The team must choose a programming language and runtime that are compatible with containerization technologies like Docker.

* TypeScript:
    * Offers straightforward containerization compatibility with Docker, leveraging Node.js runtime environments.
    * Follows a single-threaded event-loop model, suitable for handling concurrent I/O operations efficiently in containerized environments like ECS Fargate.
* Java:
    * Provides robust containerization compatibility with Docker, supporting various Java runtime environments and frameworks.
    * Supports multi-threading and concurrency through its native threading model, enabling efficient utilization of resources in containerized environments.


### **Resource Allocation**:

ECS Fargate allows specification of the CPU and memory resources allocated to each task (container). Some languages may require more memory or CPU resources to execute the same workload efficiently. A language that can make efficient use of the allocated resources to optimize cost and performance in the ECS Fargate environment, will reduce cost and ensure ideal performance.

* **TypeScript**:
    * Offers efficient resource utilization with its lightweight runtime environment and event-driven architecture.
    * Follows a single-threaded event-loop concurrency model, minimizing CPU and memory overhead in ECS Fargate environments.
    * Typically has lower resource consumption and optimized garbage collection compared to Java.
* Java:
    * Provides sophisticated resource management capabilities through JVMs, enabling efficient utilization of allocated CPU and memory resources.
    * Supports multi-threading and concurrency, making it suitable for ECS Fargate environments with high concurrency requirements.
    * May have higher resource consumption compared to TypeScript due to JVM overhead, but offers advanced garbage collection mechanisms for optimized long-term memory management.


### **Cost Optimization**:

ECS Fargate charges based on the CPU and memory resources allocated to each task and the duration of task execution. The cost implications of using each programming language and runtime in terms of resource utilization and execution time are an important metric for understanding the compatibility of the language. Evaluating the performance characteristics, memory footprint, and scalability of each runtime to optimize cost-effectiveness in the ECS Fargate environment informs the choice.


* **TypeScript**:
    * Offers lightweight middleware and libraries for implementing graceful shutdown, health checks, and auto-scaling mechanisms in ECS Fargate environments.
    * Provides flexibility in defining health check endpoints and handling lifecycle events, enabling efficient task management in ECS Fargate.
* Java:
    * Provides robust frameworks and libraries like Spring Boot Actuator for implementing advanced lifecycle management features such as graceful shutdown, health checks, and auto-scaling in ECS Fargate environments.
    * Offers extensive configuration options and integration points for defining health indicators, managing lifecycle events, and orchestrating auto-scaling activities in ECS Fargate.


## Lambda Nano-services

When choosing a programming language for AWS Lambda functions, which will be part of your microservices architecture alongside AWS ECS Fargate, there are several considerations specific to the AWS Lambda execution environment that should be considered.

AWS Lambda is a serverless computing service provided by Amazon Web Services (AWS) that allows running code without provisioning or managing servers. Here's how AWS Lambda works from a technical perspective:


1. **Runtime Environment**:
    1. AWS Lambda supports multiple programming languages, including Node.js (JavaScript/TypeScript), Python, Java, Ruby, Go, .NET Core (C#), and custom runtimes.
    2. Each Lambda function runs within a containerized environment managed by AWS Lambda.
    3. AWS Lambda automatically manages the deployment and scaling of containers based on incoming requests.
2. **Invocation**:
    1. Lambda functions are triggered in response to events such as HTTP requests via API Gateway, file uploads to Amazon S3, messages in Amazon SQS, or scheduled events from Amazon CloudWatch.
    2. When an event occurs, AWS Lambda spins up a container with the appropriate runtime environment and executes the corresponding Lambda function.
3. **Cold Starts**:
    1. Cold starts occur when a Lambda function is invoked for the first time or after a period of inactivity.
    2. During a cold start, AWS Lambda initializes a new container, loads the runtime environment, and initializes any dependencies required by the function.
    3. Factors contributing to cold starts include provisioning a new container, downloading and loading the runtime environment, and initializing any dependencies.
4. **Memory Allocation**:
    1. AWS Lambda allows you to specify the amount of memory allocated to each function (ranging from 128 MB to 10,240 MB in 64 MB increments).
    2. The allocated memory directly affects CPU allocation and performance. More memory typically results in higher CPU allocation and faster execution times.
5. **State Management**:
    1. AWS Lambda functions are intentionally stateless. Each invocation of a Lambda function is independent and isolated from previous invocations.
    2. If you need to maintain state between invocations, you can use external storage solutions such as Amazon DynamoDB, Amazon RDS, or other databases.
6. **Threading and Concurrency**:
    1. AWS Lambda manages concurrency by spinning up multiple instances of the same function to handle concurrent requests.
    2. Each instance of a Lambda function runs in its own isolated environment, allowing for parallel execution without worrying about thread safety or resource contention.
    3. Languages like Node.js and Python inherently support asynchronous programming, making them well-suited for handling multiple concurrent requests in a single Lambda function instance.

**Impact on Language Choice**:

* **Cold Starts**: Languages with faster startup times and lower initialization overhead, such as Node.js and Python, are preferred for applications with strict latency requirements to minimize the impact of cold starts.
* **Memory Allocation**: Languages that can efficiently utilize memory and CPU resources can optimize cost and performance in AWS Lambda. Choosing an appropriate memory allocation based on the memory requirements of your function can impact performance.
* **State Management**: Languages that support seamless integration with external storage solutions for state management, such as DynamoDB or S3, are advantageous for maintaining state between invocations.
* **Threading and Concurrency**: Languages that support lightweight concurrency models and asynchronous programming paradigms, such as Node.js and Python, are well-suited for handling multiple concurrent requests effectively in the AWS Lambda environment.

Overall, the language choice for AWS Lambda functions should consider factors such as cold start performance, memory utilization, state management, and concurrency support to optimize cost, performance, and scalability in serverless applications.

### **Supported Runtimes**:

AWS Lambda supports multiple programming languages and runtimes, including Node.js (JavaScript/TypeScript), Python, Java, Ruby, Go, .NET Core (C#), and custom runtimes. Consider which runtime is officially supported and best suited for your Microservices architecture. The performance, ecosystem, and community support for each supported runtime are important factors to consider.


* **Node.js (JavaScript/TypeScript):**
    * Offers fast startup times and efficient event-driven concurrency.
    * Rich ecosystem and strong community support.
* Python:
    * Versatile runtime with moderate startup times.
    * Comprehensive standard library and vibrant developer community.
* Java:
    * Vast ecosystem of libraries and tools, backed by a strong developer community.
* Ruby, Go, .NET Core (C#), and Custom Runtimes:
    * Provide additional language options for developers with specific preferences or requirements.
    * Offer varying levels of ecosystem and community support, which should be considered based on individual needs.


### **Cold Start Performance**:

AWS Lambda functions experience cold starts when they are invoked for the first time or after being idle for a period. Cold starts can introduce latency and impact the responsiveness of your microservices. Consider the cold start performance characteristics of each runtime and language. Languages with faster startup times and lower initialization overhead, such as Node.js and Python, may be preferred for applications with strict latency requirements.


* Node.js (JavaScript/TypeScript):
    * Offers fast cold start times due to its lightweight runtime and event-driven architecture.
    * Minimal initialization overhead contributes to low latency impact during cold starts.
* **Python:**
    * Exhibits fast cold start times, similar to Node.js, owing to its lightweight nature and efficient interpreter initialization.
    * Low initialization overhead helps minimize latency impact during cold starts.
* Java:
    * Typically has longer cold start times compared to Node.js and Python due to JVM initialization and class loading overhead.
    * Higher initialization overhead may result in slightly higher latency during cold starts, especially for larger applications.
* Ruby, Go, .NET Core (C#), and Custom Runtimes:
    * Cold start performance varies based on runtime implementation and initialization characteristics.
    * Offer moderate to fast cold start times, suitable for microservices with latency requirements aligned with their performance characteristics.


### **Memory and CPU Allocation**:

AWS Lambda allows you to configure the amount of memory and CPU allocated to each function. Consider how well each programming language and runtime utilize the allocated resources. Some languages may require more memory or CPU resources to execute the same workload efficiently.


* **Node.js (JavaScript/TypeScript):**
    * Efficiently utilizes memory and CPU resources with low overhead.
    * Well-suited for workloads with moderate resource requirements and optimization potential.
* Python:
    * Moderate memory and CPU utilization, with optimization potential through code optimization and library selection.
    * Suitable for a wide range of workloads, but requires careful resource management for optimal performance.
* Java:
    * Higher memory and CPU utilization due to JVM overhead.
    * Suitable for resource-intensive workloads where performance and scalability are critical, with potential for fine-tuning and optimization.
* Ruby, Go, .NET Core (C#), and Custom Runtimes:
    * Resource utilization varies based on runtime characteristics and workload requirements.
    * Can be optimized for efficient resource usage, but optimization strategies may differ from other runtimes.


### **Concurrency and Scaling**:

AWS Lambda automatically scales functions to handle incoming requests based on demand. How well each programming language and runtime support concurrent execution and scaling determines overall Lambda performance. Languages with lightweight concurrency models, asynchronous programming paradigms, and efficient resource utilization scale more effectively in the AWS Lambda environment.

* **Node.js (JavaScript/TypeScript):**
    * Lightweight concurrency model and asynchronous programming paradigm facilitate efficient handling of concurrent requests in Lambda.
    * Suitable for event-driven and I/O-bound workloads requiring rapid scaling and efficient resource utilization.
* Python:
    * Supports asynchronous programming and efficient concurrency, although with some limitations due to the Global Interpreter Lock (GIL).
    * Well-suited for I/O-bound tasks and concurrent workloads in Lambda environments.
* Java:
    * Strong support for multithreading and concurrency, efficient handling of concurrent requests in Lambda.
    * Suitable for CPU-bound and compute-intensive workloads requiring robust concurrency and parallelism.
* Ruby, Go, .NET Core (C#), and Custom Runtimes:
    * Offer concurrency features and asynchronous programming paradigms to handle concurrent requests in Lambda effectively.
    * Suitable for various workloads, with resource utilization and scalability depending on specific runtime characteristics and optimizations.


### **Execution Environment Limitations**:

AWS Lambda imposes certain limitations on the execution environment, such as execution time limits, disk space constraints, and restrictions on external dependencies. How well each programming language and runtime comply with these limitations can eliminate the possibility of a language for the Lambda. Languages that have minimal external dependencies, lightweight runtimes, and efficient execution models are better suited for the AWS Lambda environment.

* **Node.js (JavaScript/TypeScript):**
    * Well-suited for short-lived executions and minimal disk space usage, with efficient management of external dependencies using npm.
* Python:
    * Efficient execution within time constraints and minimal disk space usage, with control over external dependencies through pip.
* Java:
    * Capable of handling longer-running tasks within execution time limits, with higher disk space requirements due to the JVM and dependencies.
* Ruby, Go, .NET Core (C#), and Custom Runtimes:
    * Comply with execution time limits and disk space constraints, with dependency management tailored to each language's ecosystem.


### **Billing and Cost Considerations**:

AWS Lambda charges based on the number of requests and the duration of execution. Consider the billing implications of using each programming language and runtime. The execution time, memory usage, and performance characteristics of each runtime can be used to optimize cost-effectiveness. A language that can execute workloads efficiently within the constraints of budget and usage patterns is required for all Lambda executions.

* **Node.js (JavaScript/TypeScript):**
    * Offers fast startup times, efficient execution, and lower memory usage, contributing to cost-effective Lambda functions for event-driven workloads.
* Python:
    * Provides fast startup times, efficient execution, and moderate memory usage, making it cost-effective for short-lived invocations and data processing tasks.
* Java:
    * Offers efficient execution for longer-running tasks and complex computations, with higher memory usage, but optimized resource utilization for CPU-bound workloads.
* Ruby, Go, .NET Core (C#), and Custom Runtimes:
    * Offer varying performance characteristics and resource usage profiles, with cost-effectiveness depending on workload requirements and runtime optimizations.


## Ticket Analysis

The statistics regarding the Sev2 tickets cut to our team since the original Pedigree Software launch (Lumen) provide valuable insights into the challenges associated with using Java in our development environment. The high number of tickets related to Java usage, especially concerning escaped defects and software updates, indicates potential issues that could be mitigated by transitioning to TypeScript.

1. **Java Software Updates (24%):** The substantial number of Sev2 tickets related to Java software updates highlights the challenges associated with managing Java dependencies and maintaining compatibility with the latest versions. Java's frequent updates and backward compatibility issues can disrupt development workflows and introduce risks of compatibility issues or regressions. By transitioning to TypeScript, which relies on JavaScript runtimes like Node.js with more stable and predictable release cycles, we can potentially reduce the frequency and impact of software update-related tickets.
2. **Escaped Defects (16.4%):** The significant percentage of Sev2 tickets attributed to escaped defects suggests a challenge in identifying and resolving bugs in Java code. Escaped defects impact product quality and lead to customer dissatisfaction and increased support overhead. Transitioning to TypeScript, with its strong typing and modern development practices, will reduce the occurrence of escaped defects by providing better type handling and more robust error handling mechanisms.
3. **High Latency (5%):** High latency issues can have severe consequences, including degraded user experience and performance bottlenecks. While the cause of high latency may vary, Java's memory-intensive runtime and overhead contribute to performance issues, especially in microservices architectures where low latency is critical. TypeScript, with its lightweight runtime and asynchronous programming model, offers better performance optimization opportunities, leading to reduced latency and improved overall system responsiveness.

The prevalence of Sev2 tickets related to Java usage, particularly concerning escaped defects, high latency, and software updates, underscores the potential benefits of adopting TypeScript for our development efforts. By leveraging TypeScript's strong typing, modern development practices, and lightweight runtime, we can mitigate the identified challenges associated with Java and enhance the overall quality, performance, and maintainability of software products.

## Developer Preference

### **Team Skills and Preferences:**

Java:

* Java has been a dominant force in enterprise software development for decades. Many developers are familiar with its syntax, ecosystem, and best practices.
* Java's statically typed nature can provide a sense of security and confidence in large codebases, especially for teams accustomed to strong type systems.
* Java’s proven track record with embedded programs and Monolithic services is unmatched in enterprise software.

TypeScript:

* TypeScript, being a superset of JavaScript, inherits its massive developer base. With the rise of web development and Node.js, many developers are already proficient in JavaScript.
* Developers transitioning from JavaScript to TypeScript find it relatively easy due to its gradual typing feature, allowing them to gradually add type annotations to existing code.
* TypeScript's modern syntax and features, such as optional static typing and ECMAScript support, attract developers looking for a more flexible and expressive language.


### **Developer Productivity and Experience:**

Java:

* Java's maturity means extensive tooling support, including robust IDEs like IntelliJ IDEA and Eclipse. These IDEs offer features like code completion, refactoring tools, and built-in debugging support.
* Java's verbosity leads to more boilerplate code, which slows down development compared to more concise languages.

**TypeScript:**

* TypeScript offers a balance between the dynamic nature of JavaScript and the safety of static typing, leading to fewer runtime errors and better code quality.
* Modern development workflows, such as hot module reloading and TypeScript's language server protocol, enhance developer productivity by providing instant feedback and real-time error detection.
* The TypeScript ecosystem includes powerful tools like Visual Studio Code with excellent TypeScript support, enhancing developer experience and productivity.


### **Community Support and Documentation:**

**Java:**

* Java benefits from a vast and mature ecosystem, with comprehensive documentation, tutorials, and community forums available for almost every aspect of Java development.
    * This is especially true within Amazon.
* Due to its long-standing presence, finding solutions to common problems or debugging issues in Java is *relatively* straightforward, thanks to the extensive resources and community support available.

TypeScript:

* TypeScript, being a younger language, has a vibrant and rapidly growing community. Its documentation is thorough and continuously updated, supported by resources like the TypeScript handbook and online forums.
* The TypeScript community is known for its helpfulness and responsiveness, with active discussions on platforms like GitHub, Stack Overflow, and Sage, making it easy to find assistance and share knowledge.


### **Legacy Systems and Interoperability:**

**Java:**

* Java has a long history of interoperability with legacy systems, enterprise databases, and middleware technologies.
* The mature ecosystem includes libraries and frameworks for integrating with a wide range of systems and protocols.
* Enterprises with existing Java codebases or investments in Java-based infrastructure find it more cost-effective to continue using Java for new projects to leverage existing expertise and resources.

TypeScript:

* TypeScript's primary focus is on frontend and server-side JavaScript development, rather than legacy system integration. While it can interact with backend systems via APIs, its strengths lie in modern development.


### **Type Systems / Strongly Typed:**

Java:

* Java is statically typed, meaning type checking is performed at compile time, providing early detection of type-related errors and ensuring type safety.
    * Type Checking catches 2% of escaped defects on average.
* Strong typing can help prevent runtime errors and improve code robustness, particularly in large codebases where maintaining consistency and correctness is crucial.

TypeScript:

* TypeScript combines static typing with the flexibility of JavaScript's dynamic typing, allowing developers to opt into stronger type checking where needed.
* TypeScript's gradual typing approach allows developers to incrementally add type annotations to existing JavaScript codebases, making it easier to adopt in projects with varying levels of type safety.


### **Tooling and Ecosystem:**

Java:

* Java benefits from a vast ecosystem of libraries, frameworks, and tools for almost every use case, including web development, enterprise applications, mobile apps, and more.
* Tools like Brazil simplify dependency management and project build processes.

TypeScript:

* TypeScript's ecosystem is closely tied to the JavaScript ecosystem, allowing developers to leverage existing JavaScript libraries and frameworks seamlessly.
* Tools like NpmPrettyMuch provide package management, while frameworks like React, and Node.js offer powerful solutions for frontend and server-side development in TypeScript.


## **Conclusion:**

Both TypeScript and Java have their strengths and are suitable for a wide range of applications. The choice between them depends on factors such as team preferences, project requirements, existing infrastructure, and development goals. Java's maturity, strong typing, and extensive ecosystem make it a solid choice for enterprise monolith applications and backend systems, while TypeScript's modern syntax, developer-friendly features, and growing community appeal to web developers looking for flexibility and productivity.

For a service primarily focused on database connectivity and orchestrating simple state-based interactions with other services running in ECS Fargate, TypeScript presents several advantages over Java:

1. **Developer Productivity:** TypeScript's modern syntax, powerful tooling (e.g., Visual Studio Code), and strong ecosystem of libraries and frameworks (such as NestJS or Express.js) facilitate rapid development. Its dynamic nature allows developers to iterate quickly and maintain codebase agility, which is crucial for projects with evolving requirements.
2. **Integration with JavaScript Ecosystem:** TypeScript seamlessly integrates with the vast JavaScript ecosystem, providing access to a wide range of libraries and tools. This interoperability simplifies the integration with frontend applications, allows for the reuse of existing JavaScript components, and fosters a more cohesive development environment across the stack.
3. **Concurrency and Scaling:** While both Java and TypeScript can handle concurrency, TypeScript's asynchronous programming model and lightweight runtime make it well-suited for handling concurrent requests in a containerized environment like ECS Fargate. Its event-driven architecture aligns naturally with microservices patterns, enabling efficient scaling and resource utilization.
4. **Resource Efficiency:** TypeScript's lightweight runtime and efficient memory management make it a more resource-efficient choice compared to Java. In ECS Fargate, where resource allocation is critical for optimizing costs and performance, TypeScript's ability to make efficient use of allocated resources can lead to better scalability and lower operational overhead.
5. **Community Support and Trends:** TypeScript's growing popularity in the web development community translates into a vibrant ecosystem, active community forums, and extensive documentation. This broad support ensures access to resources, expertise, and best practices, facilitating smoother development and troubleshooting processes.
6. **Ease of Deployment:** TypeScript's flexibility and compatibility with containerization technologies like Docker make it easy to package and deploy microservices in ECS Fargate. Its lightweight footprint and minimal dependencies contribute to faster deployment times and simpler infrastructure management, reducing operational complexity.

Overall, TypeScript's combination of developer-friendly features, seamless integration with the JavaScript ecosystem, scalability, resource efficiency, and strong community support makes it a compelling choice for building database-driven microservices in ECS Fargate, particularly for projects focused on agility, scalability, and rapid development cycles.

While TypeScript offers several advantages for the described service, Java also provides compelling benefits:

1. **Robust Ecosystem and Enterprise Support:** Java boasts a mature ecosystem with a vast array of libraries, frameworks, and tools tailored for enterprise-grade development. Enterprise Java frameworks like Coral provide comprehensive solutions for building microservices, offering features such as dependency injection, and aspect-oriented programming.
2. **Performance and Scalability:** Java's efficient runtime environment, Just-In-Time (JIT) compilation, and sophisticated memory management (via garbage collection) contribute to high performance and scalability. In scenarios where the service experiences heavy workloads or requires intensive computational tasks, Java's performance optimizations can lead to better overall system efficiency.
3. **Tooling and Development Environment:** Java benefits from mature development environments (IDEs) like IntelliJ IDEA and Eclipse, offering robust features for code navigation, refactoring, and debugging. Additionally, Java's comprehensive build tools (e.g., Brazil) streamline project configuration, dependency management, and automated builds, enhancing developer productivity and workflow efficiency.
4. **Interoperability and Legacy Integration:** Java's broad compatibility and extensive support for industry standards make it well-suited for integrating with legacy systems and third-party services. Java's long-standing presence in the enterprise space ensures compatibility with existing infrastructure, databases, and middleware, simplifying the integration process for organizations with established Java-based ecosystems.
5. **Runtime Performance:** While Java may have a higher memory footprint compared to TypeScript, its runtime performance is generally optimized for long-running services. Once warmed up, Java applications typically exhibit stable performance characteristics, minimizing the impact of cold starts and providing consistent response times, which can be advantageous for services with sustained workloads.

In summary, Java offers a robust, mature ecosystem, strong performance characteristics, and extensive tooling support, making it well-suited for building resilient, scalable microservices, particularly in enterprise environments or scenarios where performance optimization and interoperability with legacy systems are paramount.

# Appendix

What is most important to you as a developer:

|	|Typescript	|Java	|Note	|
|---	|---	|---	|---	|
|Service Granularity	|1	|0	|Java uses 33% more code on average	|
|Resource Efficiency	|1	|0	|Rust is a stand-out winner here. 	|
|Scalability	|1	|0	|	|
|Fault Isolation and Resilience	|0	|0	|	|
|Inter-Service Communication	|1	|0	|	|
|Developer Productivity	|1	|0	|	|
|Operational Overhead	|1	|0	|	|
|Data Marshalling	|1	|0	|	|
|Hot Reloading	|1	|0	|	|
|Containerization Compatibility	|1	|0	|	|
|Resource Allocation	|1	|0	|	|
|Cost Optimization	|1	|0	|	|
|Supported Runtimes	|1	|0	|Nodejs was the first supported Lambda Runtime.	|
|Cold Start Performance	|1	|0	|Python is a slight winner over Typescript here 	|
|Memory and CPU Allocation	|1	|0	|	|
|Concurrency and Scaling	|1	|0	|	|
|Execution Environment Limitations	|1	|0	|	|
|Billing and Cost Considerations	|1	|0	|	|
|Team Skills and Preferences	|1	|0	|	|
|Developer Productivity and Experience ****	|1	|0	|	|
|Community Support and Documentation	|0	|1	|	|
|Legacy Systems and Interoperability	|0	|1	|	|
|Type Systems / Strongly Typed	|0	|0	|	|
|Tooling and Ecosystem	|0	|0	|	|

* https://www.peerbits.com/blog/nodejs-vs-java.html

>According to Jeff Harrell, former Director of Engineering and Chief Architect at PayPal, Node.js apps require 33% fewer lines of code and 40% fewer files. As a result, on average, the development of Node.js apps takes less time.

* https://www.toptal.com/back-end/server-side-io-performance-node-php-java-go

|Language	|Threads vs. Processes	|Non-blocking I/O	|Ease of Use	|
|---	|---	|---	|---	|
|PHP	|Processes	|No	|	|
|---	|---	|---	|---	|
|Java	|Threads	|Available	|Requires Callbacks	|
|Node.js	|Threads	|Yes	|Requires Callbacks	|
|Go	|Threads (Goroutines)	|Yes	|No Callbacks Needed	|

* https://www.netguru.com/blog/node-js-vs-java

>Applications that are CPU intensive or CPU bound will benefit from Java. The same goes for applications with a vast code base – since Java provides strongly typed sources, refactoring it and bug fixing will be more straightforward during its maintenance.

Typescript is a good choice if you're dealing with microservice architecture, which can lay the foundation for advanced systems – bear in mind that apps like Netflix or Uber were built using Node.js.



* https://medium.com/deno-the-complete-reference/node-js-vs-java-native-http-server-performance-comparison-for-hello-world-case-25a13385f9be


* https://insights.stackoverflow.com/survey/2021#most-popular-technologies-language-prof
    * Most commonly used programming language:



* https://keenethics.com/blog/node-js-vs-java-choosing-perfect-technology

>**Speed of Coding:** Node.js is known for its flexibility and so, fast in development. Yet, Java is the exact opposite of Node.js since the first technology takes much more time to develop due to being a rigid language (though, Java may save time in the long term in some cases).
*Winner: Node.js*
*Result: Node.js 3 – Java 1*



* https://www.educba.com/node-js-vs-java-performance/





* https://blazeclan.com/blog/node-js-vs-java/

|**Comparison Areas**	|**Java**	|**Node.js**	|
|---	|---	|---	|
|Performance 	|Very low. However, performance can be enhanced by using JIT compilers. 	|Runs faster compared to Java without any buffering. 	|
|Security 	|Highly secure. There are no vulnerabilities, except the ones from integrations. 	|Vulnerable to denial-of-service (DoS) attacks and cross-site scripting. It lacks default risk management. 	|
|Coding Speed 	|Needs greater definitions and is time-intensive for developing applications. 	|Lesser time for application development, as it is lightweight and more flexible. 	|
|Development Cost 	|More affordable than Node.JS. Cost may vary depending on the option of outsourcing. 	|Greater than Java. 	|

* https://benchmarksgame-team.pages.debian.net/benchmarksgame/q6600/fastest/javascript.html

|source	|secs	|mem	|gz	|busy	|cpu load	|
|---	|---	|---	|---	|---	|---	|
|[Node js](https://benchmarksgame-team.pages.debian.net/benchmarksgame/q6600/program/binarytrees-node-1.html)	|19.22	|1,000,628	|711	|61.94	|80% 82% 82% 79%	|
|---	|---	|---	|---	|---	|---	|
|[Java](https://benchmarksgame-team.pages.debian.net/benchmarksgame/q6600/program/binarytrees-java-7.html)	|8.28	|948,040	|835	|28.2	|80% 84% 87% 90%	|

* https://olesyam-miller.medium.com/java-vs-typescript-9aacf622f6c

>In terms of typing, both Java and TypeScript offer the benefits of strong typing, such as catching errors at compile-time rather than runtime. However, TypeScript takes strong typing a step further by providing static typing, which is a feature that allows variables to have a specific type that cannot be changed, even at runtime.

* https://dev.to/csohei/why-we-used-typescript-instead-of-java-on-serverless-39e2

>We found that Java is not too good to be running on the FaaS service such as AWS Lambda.
The reasons are the following.
**The overhead to launch the JVM is not ignorable.**
**Moreover, our primary framework Spring took more time for launching containers.**
**The final package of source code is relatively large. (Sometimes more than 100MB)**
**Hard to proxy the requests without using web framework when the number of functions increased**
**G1GC or JIT compile not works well since the container stops very shortly**
**Can not enjoy the benefit of the platform free since it always running on EC2 with Amazon Linux image.** (Not cons, but just reduced the reason to use Java)



* https://deepu.tech/concurrency-in-modern-languages-final/
    * https://deepu.tech/concurrency-in-modern-languages-ts/
    * https://deepu.tech/concurrency-in-modern-languages-java/
* https://www.techmagic.co/blog/node-js-vs-java-what-to-choose/
* https://www.theserverside.com/tip/The-differences-between-Java-and-TypeScript-devs-must-know

>Typescript is a good fit for Java programmers who want to branch out into another language but still leverage their expertise with OOP.

* https://www.sameerkulkarni.de/blog/2023-04-12-java-vs-typescript

>One of the key differences between Java and TypeScript is their syntax. Java has a more verbose syntax that requires the use of curly braces, semicolons, and parentheses. TypeScript, on the other hand, has a more concise syntax that is similar to JavaScript.

* https://programming-language-benchmarks.vercel.app/java-vs-typescript

Binary Tree:


|[java](https://programming-language-benchmarks.vercel.app/java)	|[2.java](https://github.com/hanabi1224/Programming-Language-Benchmarks/blob/main/bench/algorithm/binarytrees/2.java)	|1178ms	|0.9ms	|1055.6MB	|607ms	|733ms	|openjdk/zgc 21	|
|---	|---	|---	|---	|---	|---	|---	|---	|
|[typescript](https://programming-language-benchmarks.vercel.app/typescript)	|[1-m.ts](https://github.com/hanabi1224/Programming-Language-Benchmarks/blob/main/bench/algorithm/binarytrees/1.ts)	|1432ms	|22ms	|190.5MB	|2300ms	|300ms	|deno 1.40.2	|

HelloWorld:

|[typescript](https://programming-language-benchmarks.vercel.app/typescript)	|[1.ts](https://github.com/hanabi1224/Programming-Language-Benchmarks/blob/main/bench/algorithm/helloworld/1.ts)	|27ms	|0.7ms	|51.1MB	|8ms	|4ms	|deno 1.40.2	|
|---	|---	|---	|---	|---	|---	|---	|---	|
|[java](https://programming-language-benchmarks.vercel.app/java)	|[1.java](https://github.com/hanabi1224/Programming-Language-Benchmarks/blob/main/bench/algorithm/helloworld/1.java)	|66ms	|3.1ms	|54.7MB	|64ms	|24ms	|graal/jvm 17.0.8	|

MerkleTrees:


|[typescript](https://programming-language-benchmarks.vercel.app/typescript)	|[1.ts](https://github.com/hanabi1224/Programming-Language-Benchmarks/blob/main/bench/algorithm/merkletrees/1.ts)	|554ms	|0.7ms	|130.9MB	|633ms	|73ms	|deno 1.40.2	|
|---	|---	|---	|---	|---	|---	|---	|---	|
|[java](https://programming-language-benchmarks.vercel.app/java)	|[1.java](https://github.com/hanabi1224/Programming-Language-Benchmarks/blob/main/bench/algorithm/merkletrees/1.java)	|1027ms	|7.4ms	|941.0MB	|473ms	|707ms	|openjdk/zgc 21	|

Pidigits:


|[java](https://programming-language-benchmarks.vercel.app/java)	|[1.java](https://github.com/hanabi1224/Programming-Language-Benchmarks/blob/main/bench/algorithm/pidigits/1.java)	|timeout	|0.0ms	|1824.0MB	|4710ms	|1153ms	|openjdk/zgc 21	|
|---	|---	|---	|---	|---	|---	|---	|---	|
|[typescript](https://programming-language-benchmarks.vercel.app/typescript)	|[3.ts](https://github.com/hanabi1224/Programming-Language-Benchmarks/blob/main/bench/algorithm/pidigits/3.ts)	|timeout	|0.0ms	|100.6MB	|4977ms	|53ms	|deno 1.40.2	|

Spectral Norm:


|[java](https://programming-language-benchmarks.vercel.app/java)	|[2-m.java](https://github.com/hanabi1224/Programming-Language-Benchmarks/blob/main/bench/algorithm/spectral-norm/2.java)	|2081ms	|13ms	|45.6MB	|7440ms	|140ms	|openjdk/zgc 21	|
|---	|---	|---	|---	|---	|---	|---	|---	|
|[typescript](https://programming-language-benchmarks.vercel.app/typescript)	|[7.ts](https://github.com/hanabi1224/Programming-Language-Benchmarks/blob/main/bench/algorithm/spectral-norm/7.ts)	|4066ms	|156ms	|59.5MB	|4050ms	|13ms	|deno 1.40.2	|

* https://www.sam-solutions.com/blog/node-js-vs-java/

| 	|**Node.js**	|**Java**	|
|---	|---	|---	|
|**Key features**	|Based on JavaScript, Node.js uses the same syntactical features for backend and frontend, which facilitates agility and increased speed of processes.	|Java is known for its platform-independent nature, effective memory management, and portability. Both Java and Node.js can boast of numerous libraries.	|
|**Performance**	|Node.js is known to be a performant environment. Node.js is not faster than Java because of compilers.	|Java is often considered to be more performant than Node.js.	|
|**Stability**	|Focused on API that undergoes frequent changes, Node.js is prone to have difficulties with stable functioning.	|Java is a leader in this field. With strict structure, it offers high stability of interface.	|
|**Scalability**	|Enjoys high scalability that exceeds that of Java.	|Without inner scalability, Java needs to resort to third-party apps to improve this characteristic.	|
|**Security**	|Security vulnerabilities in third-party npm packages. JavaScript environment is prone to DOS cyberattacks.	|Java has rich security characteristics that exceeds that of Node.js.	|
|**Documentation**	|Node.js offers rich documentation. However, some specialists argue that it might be better.	|Java provides robust documentation with thorough guidelines for all the required tech functionalities.	|
|**Talent pool**	|The [talent pool](https://insights.stackoverflow.com/survey/2021#technology-most-popular-technologies) of Node.js (33.91% of popularity) is not as large as that of Java (35.35%). However, the difference is not very significant.	|According to Stack Overflow, Java (35.35%) has proved to be more popular than Node.js.	|
|**Easiness to learn**	|Thanks to syntactical simplicity and JavaScript code interpretation, Node.js is often considered to be easier to master.	|Java is not so easy to learn, but it is also possible to grasp it if you make enough efforts.	|
|**Speed of coding**	|In comparison with Java, Node.js is quicker to code. Though, it is important to note that this is likely to vary depending on the type of your project, the size of your team, etc.	|Usually, it takes more time to code in Java. Nevertheless, the exact amount of time depends on the peculiarities of the project and number of Java developers working on it.	|

* https://www.peerbits.com/blog/nodejs-vs-java.html

|Determinant	|Node.js	|Java	|
|---	|---	|---	|
|Performance	|It operates extremely fast in a short time period.	|Java delivers high-performance capabilities to the applications.	|
|---	|---	|---	|
|Application Architecture	|NodeJS uses a single-threaded event loop system or MVP/MVC architecture.	|Java developers opt for the model-view-controller architecture for app development.	|
|Installation	|You need the archive file on your system.	|You will have to set the JavaFX environment to execute the JavaFX applications.	|
|Testing	|NodeJS provides competent testing and debugging abilities.	|Java enables testing with FitNess, JMeter, Selenium, JUnit, and Apache.	|
|Scalability	|NodeJS boasts scalability and efficiency.	|Java offers vertical scaling, horizontal scaling, single point of failure, and a single solution for all architecture needs.	|
|Microservices Compatibility	|NodeJS is highly compatible with the code and service modules.	|Java is compatible with the microservice architecture, owing to its frameworks like Spring Boot and Annotation Syntax.	|
|Database Support	|NodeJS extends its support for all the NoSQL and relational databases.	|Java uses MySQL, SQLite, and PostgreSQL.	|
|Community Support	|Facebook, Google, and Amazon have contributed significantly to the NodeJS environment, thereby turning the NodeJS technology more credible	|A broad community implies bug squashing, frequent updates, as well as innovation.	|
|Hiring Difficulty	|Easy	|Easy	|

* https://benchmarksgame-team.pages.debian.net/benchmarksgame/fastest/javascript.html


