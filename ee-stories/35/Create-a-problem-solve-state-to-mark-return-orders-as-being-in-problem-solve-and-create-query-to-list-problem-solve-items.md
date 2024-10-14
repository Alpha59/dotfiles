
# Create a problem solve state to mark return orders as being in problem solve and create query to list problem solve items
### Summary
**As a** Software Engineer, **I want** to create a new problem-solve state for Return Orders and implement a query to list all items currently marked as in problem-solve, **So That** we can efficiently track and manage Return Orders requiring manual intervention or further investigation, ensuring better visibility and management of problematic items.

This story focuses on adding a new state to the Return Order workflow to mark orders that require problem-solving. The accompanying query will allow teams to list all Return Orders in this state, improving operational oversight and enabling teams to quickly identify and address issues.

### Vision
By adding a problem-solve state and a corresponding query, we improve the Return Order workflow by making it easier to track orders that encounter issues and require additional attention. This provides clarity and visibility, ensuring that problem-solve items can be quickly identified, prioritized, and resolved.

### Background
Return Orders sometimes encounter issues that prevent them from completing the standard workflow, such as missing data, incorrect item conditions, or system errors. These orders need to be marked for further investigation. Adding a specific problem-solve state ensures these orders are properly tracked, and a query to retrieve all such orders will streamline operations and provide better oversight.

## Details

1. **Define the Problem-Solve State**
   - Extend the Return Order status model by adding a new state called `PROBLEM_SOLVE`. This state will indicate that the Return Order is in need of manual intervention or further investigation.
   - Ensure that the state can only be applied when there is an unresolved issue with the order (e.g., missing item information, incorrect SKU, system error).

   Example state model extension:
   ```java
   public enum ReturnOrderStatus {
       PENDING,
       COMPLETED,
       CANCELED,
       PROBLEM_SOLVE; // New state added
   }
   ```

2. **Modify Workflow to Support Problem-Solve State**
   - Update the Return Order workflow to allow transitions to the `PROBLEM_SOLVE` state when certain error conditions are met:
     - If an item cannot be processed due to missing data.
     - If there is a conflict in item condition or validation.
     - If the system encounters an error and the order cannot proceed automatically.
   - Ensure that the system can transition Return Orders back to active processing or other states once the problem is resolved.

   Example of adding state transition logic:
   ```java
   public void markAsProblemSolve(ReturnOrder order) {
       if (order.hasProcessingError()) {
           order.setStatus(ReturnOrderStatus.PROBLEM_SOLVE);
           // Additional logic for notifying the operations team or logging the error
       }
   }
   ```

3. **Create Problem-Solve Query**
   - Write a query to retrieve all Return Orders that are currently in the `PROBLEM_SOLVE` state. This will help operations teams track and manage items that require manual intervention.
   - The query should filter Return Orders by their current status and return relevant details, such as order ID, item information, date added to problem-solve, and associated issues.

   Example SQL query:
   ```sql
   SELECT
       order_id, item_sku, issue_description, problem_solve_date
   FROM
       return_orders
   WHERE
       status = 'PROBLEM_SOLVE';
   ```

4. **Implement API Endpoint for Query**
   - Create an API endpoint that allows users or systems to retrieve the list of Return Orders in the `PROBLEM_SOLVE` state.
   - The endpoint should return a paginated list of orders along with relevant information, such as the reason the order was placed in the problem-solve state and timestamps for when it was added.

   Example API endpoint (Node.js):
   ```javascript
   app.get('/api/problem-solve-orders', async (req, res) => {
       try {
           const problemSolveOrders = await db.query(
               `SELECT order_id, item_sku, issue_description, problem_solve_date FROM return_orders WHERE status = 'PROBLEM_SOLVE';`
           );
           res.json(problemSolveOrders.rows);
       } catch (err) {
           res.status(500).send('Error retrieving problem-solve orders');
       }
   });
   ```

5. **Add Problem-Solve State UI and Notifications**
   - Update the user interface (UI) to display the `PROBLEM_SOLVE` status when viewing a Return Order's details. Ensure that users are informed when an order is in problem-solve and are aware of the next steps.
   - Implement notifications or alerts to inform the relevant teams when orders enter the problem-solve state, allowing them to take timely action.

6. **Testing and Validation**
   - Test the following scenarios:
     - Marking a Return Order as `PROBLEM_SOLVE` when an error occurs.
     - Querying the list of Return Orders in the `PROBLEM_SOLVE` state.
     - Transitioning items out of the `PROBLEM_SOLVE` state once the issue is resolved.
     - API endpoint performance and correctness.
     - UI display and notifications for problem-solve orders.

7. **Monitoring and Logging**
   - Set up logging and monitoring for the problem-solve state transitions and queries:
     - Log each time an order is moved to the `PROBLEM_SOLVE` state and record the reason for the status change.
     - Monitor query performance to ensure it scales effectively as the number of problem-solve orders grows.

### Testing
- Test the state transition to `PROBLEM_SOLVE` by simulating errors in Return Orders and verifying that the system correctly applies the new status.
- Run the query to ensure it retrieves all Return Orders currently in the problem-solve state and that the data returned is accurate.
- Test the API endpoint by retrieving the list of problem-solve orders and verifying the correctness and completeness of the response.
- Ensure that problem-solve orders are correctly transitioned back to other states when resolved and that the system responds appropriately.

### Acceptance Criteria
- Should have a `PROBLEM_SOLVE` state added to the Return Order workflow.
- Should have a query that returns all Return Orders currently marked as in problem-solve.
- Should have an API endpoint that provides a paginated list of problem-solve orders.
- Should have tested the workflow, query, and API, ensuring correctness and performance.
- Should have UI and notifications updated to display problem-solve orders and inform relevant teams.
