# TechGear Enterprise Relational Database Architecture

## Main Challenge
E-commerce platform databases frequently encounter data redundancy, referential integrity failure, and transactional stock errors during high-volume purchasing. Without constraint enforcement, schema normalization, and automated audit trails, systems suffer from orphaned purchase records, inaccurate inventory counts, and unmonitored price changes.

## Track Alignment
Database Design, Relational Data Modeling, and Data Engineering Architecture.

## Project Description

### Problem
Legacy e-commerce databases often mix operational transaction processing with reporting, leading to lock contention and data quality issues. Inconsistent data inputs (e.g., miscapitalized strings, missing customer details, ambiguous user roles) lower data quality and slow down real-time business reporting.

### Solution
This project implements a fully normalized relational MySQL database schema (`techgear_db`) designed for enterprise retail management. The solution establishes strict data integrity using relational constraints, handles bad or inconsistent raw data, provides multi-table reporting capabilities, enforces transactional safety during order placement, and automates auditing through database triggers and stored procedures.

### Target Users
- **Backend Engineers**: Requiring reliable transaction handling and relational integrity for API integration.
- **Database Administrators (DBAs)**: Seeking structural schema examples with indexing, triggers, and automated logging.
- **Data Analysts**: Needing optimized analytical views and clean data aggregation paths for business intelligence dashboards.

### Business Impact
- **Data Integrity**: Foreign key constraints with explicit CASCADE and RESTRICT rules eliminate orphaned records.
- **Transactional Consistency**: Manual transaction control (`COMMIT` / `ROLLBACK`) prevents inventory over-selling during order processing.
- **Automated Compliance**: Database triggers track all historical price modifications without application-level intervention.
- **Query Optimization**: Multi-column indexes reduce full table scans across operational endpoints.

---

## Tech Stack
- **Database Engine**: MySQL Server 8.0+
- **Management Tools**: MySQL Command Line Client / MySQL Workbench / DBeaver
- **Dialect Features**: Stored Procedures, Triggers, Views, InnoDB Engine Transactions, Foreign Keys, Indexing

---

## Key Features & Architecture

1. **Normalized Relational Schema**: 5 core tables (`employees`, `customers`, `products`, `orders`, `order_items`) linked by relational constraints.
2. **Self-Referencing Relationships**: Employee-to-manager hierarchical modeling using Self-JOIN queries.
3. **Automated Audit Logging**: Trigger-based tracking logging old and new price states to a dedicated audit ledger upon modification.
4. **Encapsulated Business Logic**: Stored procedure handling stock replenishment procedures safely.
5. **Atomic Transactions**: Multi-step transaction blocks maintaining atomic balance state across product inventory and orders.
6. **Analytical Views**: Pre-compiled virtual tables providing reporting metrics for high-value pending orders and category summaries.

---

## Repository Data Schema Setup & Results

### Schema Overview
+----------------+ +-----------------+ +----------------+
| customers | | orders | | order_items |
+----------------+ +-----------------+ +----------------+
| id (PK) |<----->| order_id (PK) |<----->| item_id (PK) |
| name | | customer_id(FK) | | order_id (FK) |
| email (UQ) | | status | | product_id(FK) |
| phone_number | | total_amount | | quantity |
| loyalty_points | +-----------------+ | unit_price |
+----------------+ +----------------+
|
v
+----------------+
| products |
+----------------+
| id (PK) |
| product_name |
| category |
| price |
| stock_quantity |
+----------------+


### Sample Analytical Results

#### 1. Category Revenue and Stock Rollup (`queries/executive_reporting.sql`)
Query computing revenue per category alongside total physical inventory.

```sql
SELECT 
    p.category, 
    SUM(oi.quantity * oi.unit_price) AS total_revenue,
    AVG(p.price) AS avg_product_price
FROM products p
LEFT JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.category;
Expected Output Table:

category	total_revenue	avg_product_price
Laptops	5100.00	1700.000000
Peripherals	1275.00	181.250000
Accessories	75.00	80.000000
Software	479.00	159.666667
2. Price Change Verification Log (price_audit_log)
Verifies trigger performance when a product price update occurs.

Expected Output Table:

log_id	product_id	old_price	new_price	changed_at
1	1	1200.00	1100.00	2026-10-07 15:15:00
Prerequisites
•	MySQL Server: Version 8.0 or higher installed locally or via Docker.

•	Git: Installed for repository cloning.

•	MySQL Client: Terminal interface (mysql) or a database GUI client (e.g., MySQL Workbench, DBeaver).

Local Setup & Execution Guide
Step 1: Clone the Repository
Bash
git clone [https://github.com/your-username/techgear-db-architecture.git](https://github.com/your-username/techgear-db-architecture.git)
cd techgear-db-architecture
Step 2: Connect to MySQL Engine
Start your MySQL terminal client:

Bash
mysql -u root -p
Step 3: Execute Setup Scripts Sequentially
Run the script files in order from within the repository root or source them inside your MySQL client:

SQL
-- 1. Create Schema and Constraints
SOURCE scripts/01_schema_and_constraints.sql;

-- 2. Clean and Sanitize Raw Data
SOURCE scripts/02_data_sanitization_and_cleaning.sql;

-- 3. Populate Database with Bulk Test Data
SOURCE scripts/03_bulk_data_insertion.sql;

-- 4. Load Analytical Views and Reporting Logic
SOURCE scripts/04_analytics_and_views.sql;

-- 5. Compile Procedures, Triggers, and Run Transaction Verification
SOURCE scripts/05_procedures_triggers_transactions.sql;
Step 4: Verify Installation
Verify table counts and view functionality:
SQL
USE techgear_db;
SHOW FULL TABLES WHERE Table_type = 'VIEW' OR Table_type = 'BASE TABLE';
SELECT * FROM high_value_pending_orders;

