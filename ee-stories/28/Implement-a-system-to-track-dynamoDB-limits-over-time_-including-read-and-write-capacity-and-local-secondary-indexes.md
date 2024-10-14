
# Implement a system to track dynamoDB limits over time, including read/write capacity and local secondary indexes
### Summary
**As a** DevOps Engineer, **I want** to implement a system to track DynamoDB limits over time, including read/write capacity and local secondary indexes (LSIs), **So That** we can monitor usage patterns, anticipate capacity needs, and ensure that the system remains performant without exceeding DynamoDB limits.

This story focuses on building a monitoring system that continuously tracks DynamoDB read/write capacity units (RCUs/WCUs) and local secondary index (LSI) usage. The system will provide insights into capacity trends, help prevent throttling, and optimize resource allocation.

### Vision
By tracking DynamoDB limits over time, we ensure that our system uses resources efficiently and stays within its capacity limits. The system will provide key insights to prevent over-provisioning or under-provisioning, avoid throttling, and identify the need for any capacity adjustments or index optimizations.

### Background
DynamoDB has specific limits for read/write capacity and local secondary indexes (LSIs). Exceeding these limits can result in throttling, which degrades performance. Monitoring capacity usage over time allows the team to identify trends, optimize configurations, and avoid performance bottlenecks. This also helps in planning scaling strategies for future demand.

## Details
1. **Monitor Read/Write Capacity Units (RCUs/WCUs)**
   - Track the usage of **provisioned** or **on-demand** read/write capacity units (RCUs/WCUs) for each DynamoDB table.
   - Use ** CloudWatch** metrics to monitor:
     - **ConsumedReadCapacityUnits** and **ConsumedWriteCapacityUnits**.
     - **ProvisionedReadCapacityUnits** and **ProvisionedWriteCapacityUnits** (for provisioned mode).
   - Create CloudWatch alarms to trigger notifications when RCUs/WCUs approach predefined thresholds (e.g., 80% usage).

2. **Monitor Local Secondary Index (LSI) Usage**
   - Track the utilization of LSIs, including:
     - How frequently LSIs are accessed compared to the base table.
     - Capacity units consumed by queries and scans that use LSIs.
   - Monitor **IndexConsumedReadCapacityUnits** and **IndexConsumedWriteCapacityUnits** to assess the impact of index usage on overall capacity.

3. **Track Capacity Usage Over Time**
   - Implement long-term tracking to observe trends in capacity usage:
     - Log capacity metrics over time in a data store (e.g., ** S3**, ** RDS**, or **Elasticsearch**).
     - Generate reports that show trends in capacity consumption, peak usage times, and under-utilization.

4. **Configure Alerts and Thresholds**
   - Set up alerts to notify the team when:
     - Read or write capacity exceeds a certain threshold (e.g., 80% of provisioned capacity).
     - LSI usage becomes a bottleneck or approaches its limits.
   - Create CloudWatch alarms to monitor:
     - Excessive **ThrottledRequests** due to capacity limits being exceeded.
     - Sudden spikes in RCU/WCU usage that could indicate abnormal activity or misconfigurations.

5. **Dashboard and Visualization**
   - Create a **CloudWatch Dashboard** or integrate with monitoring tools like **Datadog**, **Grafana**, or **Prometheus** to visualize:
     - Read/write capacity consumption over time.
     - LSI usage and how it impacts the overall system performance.
     - Trends in throttling events or spikes in capacity usage.
   - Enable developers and operations teams to monitor the system easily and identify patterns that require intervention.

6. **Capacity Optimization**
   - Use insights from capacity tracking to:
     - Adjust DynamoDB table provisioning (increase or decrease RCUs/WCUs).
     - Evaluate whether tables can be moved to **on-demand** capacity mode if fluctuating traffic patterns are observed.
     - Optimize the use of LSIs by adjusting indexing strategies or adding/removing indexes based on usage patterns.

### Testing
- Simulate high load on DynamoDB tables to ensure the monitoring system accurately tracks capacity consumption and generates alerts when usage approaches limits.
- Test the system’s ability to track and report LSI usage patterns and ensure that LSI-related throttling events trigger notifications.
- Validate that long-term data collection provides useful insights for capacity planning.

### Acceptance Criteria
- Should have a system in place that tracks DynamoDB read/write capacity units and LSI usage over time.
- Should provide alerts and reports when capacity usage approaches defined thresholds.
- Should have visual dashboards to monitor capacity trends and track key DynamoDB metrics.
- Should have insights into optimizing read/write capacity and LSI usage based on tracked data.
