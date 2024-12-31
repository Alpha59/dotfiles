## Team's Database Tables: Keys, Indexes, and Range Keys Documentation

### Purpose
This document provides a detailed list of all tables, their corresponding hash keys, primary keys, unique indexes, and range keys used in the team's databases. This ensures clarity in database structure, aiding in efficient queries and data management.

---

### 1. **Order Table**

| **Attribute**     | **Key Type**  | **Description**                                           |
|-------------------|---------------|-----------------------------------------------------------|
| **OrderID**       | **Primary Key** | Unique identifier for each order (hash key).             |
| **CustomerID**    | **Range Key**  | Customer identifier (range key for composite primary key).|
| **OrderDate**     | **Index**      | Date of order placed (non-unique index for queries by date).|
| **TotalAmount**   | **Attribute**  | Total cost of the order.                                 |
| **Status**        | **Attribute**  | Status of the order (e.g., pending, completed).          |
| **CustomerEmail** | **Unique Index**| Customer email address (unique index).                   |

#### Primary Key:
- **OrderID** (hash key)
- **CustomerID** (range key)

#### Indexes:
- **OrderDate** (non-unique index)
- **CustomerEmail** (unique index)

---

### 2. **Payment Table**

| **Attribute**     | **Key Type**  | **Description**                                           |
|-------------------|---------------|-----------------------------------------------------------|
| **PaymentID**     | **Primary Key** | Unique identifier for each payment (hash key).            |
| **OrderID**       | **Range Key**  | Associated order ID (range key for composite primary key).|
| **PaymentDate**   | **Index**      | Date when the payment was made (non-unique index).        |
| **Amount**        | **Attribute**  | Amount paid.                                              |
| **PaymentMethod** | **Attribute**  | Payment method (e.g., credit card, PayPal).               |
| **TransactionID** | **Unique Index**| Unique identifier for the payment transaction.            |

#### Primary Key:
- **PaymentID** (hash key)
- **OrderID** (range key)

#### Indexes:
- **PaymentDate** (non-unique index)
- **TransactionID** (unique index)

---

### 3. **Customer Table**

| **Attribute**     | **Key Type**  | **Description**                                           |
|-------------------|---------------|-----------------------------------------------------------|
| **CustomerID**    | **Primary Key** | Unique identifier for each customer (hash key).            |
| **Email**         | **Unique Index**| Customer email address (unique index).                   |
| **FullName**      | **Attribute**  | Customer's full name.                                     |
| **PhoneNumber**   | **Attribute**  | Customer's phone number.                                  |
| **Address**       | **Attribute**  | Customer's address.                                       |

#### Primary Key:
- **CustomerID** (hash key)

#### Indexes:
- **Email** (unique index)

---

### 4. **Inventory Table**

| **Attribute**     | **Key Type**  | **Description**                                           |
|-------------------|---------------|-----------------------------------------------------------|
| **ProductID**     | **Primary Key** | Unique identifier for each product (hash key).            |
| **Category**      | **Range Key**  | Category of the product (range key for composite primary key).|
| **StockQuantity** | **Attribute**  | Number of items in stock.                                  |
| **Price**         | **Attribute**  | Price of the product.                                      |
| **SupplierID**    | **Attribute**  | Supplier identifier for the product.                      |

#### Primary Key:
- **ProductID** (hash key)
- **Category** (range key)

#### Indexes:
- **SupplierID** (non-unique index)

---

### 5. **Shipping Table**

| **Attribute**     | **Key Type**  | **Description**                                           |
|-------------------|---------------|-----------------------------------------------------------|
| **ShippingID**    | **Primary Key** | Unique identifier for each shipping record (hash key).    |
| **OrderID**       | **Range Key**  | Order associated with the shipping record (range key).     |
| **ShippingDate**  | **Attribute**  | Date the order was shipped.                               |
| **TrackingNumber**| **Attribute**  | Tracking number for the shipment.                         |
| **Carrier**       | **Attribute**  | Carrier handling the shipment (e.g., UPS, FedEx).         |

#### Primary Key:
- **ShippingID** (hash key)
- **OrderID** (range key)

---

### 6. **ProductReview Table**

| **Attribute**     | **Key Type**  | **Description**                                           |
|-------------------|---------------|-----------------------------------------------------------|
| **ReviewID**      | **Primary Key** | Unique identifier for each product review (hash key).      |
| **ProductID**     | **Range Key**  | ID of the reviewed product (range key).                    |
| **CustomerID**    | **Attribute**  | Customer who left the review.                              |
| **Rating**        | **Attribute**  | Rating given to the product (1-5).                         |
| **ReviewText**    | **Attribute**  | Text of the review.                                        |
| **ReviewDate**    | **Attribute**  | Date the review was submitted.                             |

#### Primary Key:
- **ReviewID** (hash key)
- **ProductID** (range key)

---

### 7. **Audit Log Table**

| **Attribute**     | **Key Type**  | **Description**                                           |
|-------------------|---------------|-----------------------------------------------------------|
| **AuditID**       | **Primary Key** | Unique identifier for each audit log entry (hash key).    |
| **Timestamp**     | **Range Key**  | Timestamp of the audit event (range key).                  |
| **EventType**     | **Attribute**  | Type of event (e.g., login, payment, order update).        |
| **Details**       | **Attribute**  | Additional details about the event.                        |
| **UserID**        | **Attribute**  | ID of the user who triggered the event.                   |

#### Primary Key:
- **AuditID** (hash key)
- **Timestamp** (range key)

---

### Summary of Key Concepts

1. **Primary Key**:
   - A **primary key** consists of one or two attributes (hash key and optional range key) that uniquely identify each item in the table.
   - **Hash Key** is the mandatory unique identifier.
   - **Range Key** is optional and allows you to define a composite key for more granular data retrieval.

2. **Unique Index**:
   - A **unique index** ensures that the attribute(s) indexed are unique across the table, providing efficient query access and enforcing data integrity.

3. **Range Key**:
   - The **range key** is used in composite primary keys to allow for more complex data access patterns and sorting based on time, categories, or other criteria.

4. **Indexes**:
   - **Global Secondary Indexes (GSI)** and **Local Secondary Indexes (LSI)** are used to optimize queries beyond the primary key and can improve access performance for attributes frequently queried in different ways.

---

### Monitoring and Maintenance

- **Review Index Usage**:
  - Regularly review the usage of indexes, particularly unique indexes, to avoid performance issues.
- **Monitor Data Access Patterns**:
  - Ensure that queries are optimized by designing indexes based on common access patterns (e.g., by date, product, or customer).
- **Security and Access Control**:
  - Implement appropriate access control mechanisms to secure sensitive attributes such as customer data, payment information, and audit logs.

---

### Acceptance Criteria
- All tables, keys, and indexes are documented and follow best practices for the use case.
- Tables should have efficient primary keys and indexes that match the expected query patterns.
- Regular reviews of index usage should be scheduled to ensure optimal query performance.

---

### Gherkin

**Feature**: Documenting Database Schema with Keys and Indexes
**Scenario**: Listing all tables, hash keys, primary keys, unique indexes, and range keys
- **Given** the team is working with multiple databases,
- **When** the schema for each table is reviewed,
- **Then** the documentation should include the primary keys, hash keys, range keys, unique indexes, and their purposes for efficient data access and query optimization.

This structured approach ensures clarity and consistency across the team's database management, improving query performance and data integrity.
