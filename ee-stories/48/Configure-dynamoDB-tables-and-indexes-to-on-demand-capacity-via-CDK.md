
# Configure dynamoDB tables and indexes to on-demand capacity via CDK
### Summary
**As a** DevOps Engineer, **I want** to configure DynamoDB tables and indexes to use on-demand capacity via AWS CDK (Cloud Development Kit), **So That** we can handle variable or unpredictable workloads without the need to provision throughput capacity, ensuring the system automatically scales based on demand while optimizing cost.

This story focuses on creating and configuring DynamoDB tables and their global secondary indexes (GSI) to use on-demand capacity mode using AWS CDK. On-demand capacity mode is ideal for applications with unpredictable traffic patterns as it automatically scales to accommodate sudden spikes or drops in traffic.

### Vision
By configuring DynamoDB tables and indexes with on-demand capacity, we ensure that the system automatically adjusts to traffic fluctuations without manual intervention or predefined capacity settings. This reduces the risk of throttling during high traffic periods and avoids over-provisioning when traffic is low, optimizing both performance and cost.

### Background
DynamoDB offers two capacity modes: **provisioned** and **on-demand**. Provisioned capacity requires you to specify the number of read and write capacity units, whereas on-demand capacity scales automatically in response to the actual workload. On-demand capacity is useful for applications with variable or unpredictable traffic patterns, as it allows DynamoDB to scale seamlessly without provisioning capacity in advance.

---

### Steps to Configure DynamoDB Tables and Indexes to On-Demand Capacity via CDK

#### 1. **Set Up AWS CDK for DynamoDB**

If you haven't already, ensure that your development environment is set up with the AWS CDK. This includes installing AWS CDK globally, bootstrapping your environment, and creating a new CDK project.

##### Step 1: Install AWS CDK

```bash
npm install -g aws-cdk
```

##### Step 2: Bootstrap AWS CDK

Ensure your AWS account is bootstrapped for AWS CDK:

```bash
cdk bootstrap
```

##### Step 3: Create a New CDK Project (if needed)

If you don't already have a CDK project, create a new one:

```bash
cdk init app --language typescript
```

---

#### 2. **Define DynamoDB Table with On-Demand Capacity**

Using AWS CDK, you can define a DynamoDB table and configure it to use **on-demand capacity mode**.

##### Step 1: Install CDK DynamoDB Package

Ensure the DynamoDB CDK package is installed:

```bash
npm install @aws-cdk/aws-dynamodb
```

##### Step 2: Define a DynamoDB Table with On-Demand Capacity

Here’s how you define a DynamoDB table with on-demand capacity mode in CDK (TypeScript):

```typescript
import * as cdk from 'aws-cdk-lib';
import { Table, AttributeType, BillingMode } from 'aws-cdk-lib/aws-dynamodb';
import { Stack, StackProps } from 'aws-cdk-lib';
import { Construct } from 'constructs';

export class DynamoDBOnDemandStack extends Stack {
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);

    // Define DynamoDB table with on-demand capacity
    const dynamoTable = new Table(this, 'MyOnDemandTable', {
      partitionKey: { name: 'PK', type: AttributeType.STRING },
      sortKey: { name: 'SK', type: AttributeType.STRING },
      billingMode: BillingMode.PAY_PER_REQUEST,  // On-demand capacity
      tableName: 'MyOnDemandTable'
    });

    // Optionally, add global secondary indexes (GSI) with on-demand capacity
    dynamoTable.addGlobalSecondaryIndex({
      indexName: 'GSI1',
      partitionKey: { name: 'GSI1PK', type: AttributeType.STRING },
      sortKey: { name: 'GSI1SK', type: AttributeType.STRING }
    });
  }
}
```

- **BillingMode.PAY_PER_REQUEST**: This setting configures the DynamoDB table to use on-demand capacity mode (also known as pay-per-request).
- **partitionKey and sortKey**: Defines the primary key for the table (Partition Key and Sort Key).
- **Global Secondary Index (GSI)**: The example includes the creation of a GSI, which also inherits the on-demand capacity configuration.

##### Step 3: Add Secondary Indexes

If your table has **Global Secondary Indexes (GSI)** or **Local Secondary Indexes (LSI)**, they will automatically use the on-demand capacity configuration when the table is set to **PAY_PER_REQUEST**.

For GSIs, you can define additional indexes with their partition and sort keys:

```typescript
dynamoTable.addGlobalSecondaryIndex({
  indexName: 'GSI2',
  partitionKey: { name: 'GSI2PK', type: AttributeType.STRING },
  sortKey: { name: 'GSI2SK', type: AttributeType.STRING }
});
```

This creates an additional GSI that uses on-demand capacity.

---

#### 3. **Deploy the DynamoDB Table Using CDK**

Once your table is defined with on-demand capacity mode, you can deploy the stack to create the table in AWS.

##### Step 1: Synthesize the CloudFormation Template

Before deploying, you can synthesize the CDK app to view the CloudFormation template that will be generated:

```bash
cdk synth
```

This generates the CloudFormation template for the DynamoDB table with on-demand capacity.

##### Step 2: Deploy the Stack

Deploy the DynamoDB table with on-demand capacity:

```bash
cdk deploy
```

Once deployed, AWS will automatically manage the table’s scaling based on the actual workload, charging you only for the requests made.

---

#### 4. **Add Monitoring and Alerts for the DynamoDB Table**

Although on-demand capacity scales automatically, it’s important to monitor your DynamoDB table to ensure it performs optimally under load. You can use AWS CloudWatch to set up alarms for key DynamoDB metrics such as read/write capacity, throttled requests, and consumed throughput.

##### Step 1: Set Up CloudWatch Alarms

You can use AWS CDK to set up **CloudWatch Alarms** to monitor the DynamoDB table. For example, create an alarm if there are too many throttled requests:

```typescript
import { Metric, Alarm } from 'aws-cdk-lib/aws-cloudwatch';

const throttledRequests = new Metric({
  namespace: 'AWS/DynamoDB',
  metricName: 'ThrottledRequests',
  dimensionsMap: {
    TableName: dynamoTable.tableName
  },
  period: cdk.Duration.minutes(1)
});

new Alarm(this, 'ThrottledRequestsAlarm', {
  metric: throttledRequests,
  threshold: 1,
  evaluationPeriods: 1
});
```

This will create an alarm if there is any throttling on the table.

---

### Best Practices for On-Demand Capacity Mode

- **Cost Optimization**: On-demand capacity can be more expensive than provisioned capacity for steady or predictable workloads. Use it primarily for workloads with unpredictable or spiky traffic.
- **Auto-Scaling**: While on-demand capacity automatically scales, it’s still important to monitor performance and cost using CloudWatch metrics and alarms.
- **GSIs and LSIs**: Remember that all global secondary indexes (GSIs) are automatically configured to use the same billing mode (on-demand) as the base table when created.
- **Backups and PITR**: Enable DynamoDB backups and point-in-time recovery (PITR) to ensure you can recover from data loss without impacting performance or cost significantly.

---

### Acceptance Criteria
- Should have a DynamoDB table configured with on-demand capacity mode using AWS CDK.
- Should have global secondary indexes (GSI) configured with on-demand capacity if needed.
- Should deploy the DynamoDB table and validate that it scales automatically with demand without requiring manual capacity adjustments.
- Should have monitoring in place via CloudWatch for key metrics, including throttled requests and consumed capacity.
- Should ensure cost optimization by reviewing actual usage and comparing on-demand vs. provisioned capacity costs based on the workload.
