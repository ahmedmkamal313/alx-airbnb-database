
# 🏡 ALX AirBnB Database Project

This repository contains the full database design and implementation for an AirBnB-like platform, including:

- Entity-Relationship Diagram (ERD)
- Normalization process to Third Normal Form (3NF)
- SQL schema (DDL) scripts
- Sample data insertion (DML) scripts
- Advanced SQL querying and optimization techniques

---

## 📁 Repository Structure

alx-airbnb-database/
- [ERD/](/ERD/)
    - [airbnb_erd.png](/ERD/airbnb_erd.PNG) # ER diagram image.
    - [requirements.md](/ERD/requirements.md) # ERD details with entities, attributes, and relationships.
- [database-script-0x01/](/database-script-0x01/)
    - [schema.sql](/database-script-0x01/schema.sql) # Full schema DDL script with constraints and indexes.
    - [README.md](/database-script-0x01/README.md) # Notes on schema and implementation details.
- [database-script-0x02/](/database-script-0x02/)
    - [seed.sql](/database-script-0x02/seed.sql) # Sample data INSERTs for all tables.
    - [README.md](/database-script-0x02/README.md) # Explanation of how the seed data works.
- [database-adv-script/](/database-adv-script/)
    - [joins_queries.sql](/database-adv-script/joins_queries.sql) # SQL queries demonstrating various JOIN types.
    - [subqueries.sql](/database-adv-script/subqueries.sql) # SQL queries using correlated and non-correlated subqueries.
    - [aggregations_and_window_functions.sql](/database-adv-script/aggregations_and_window_functions.sql) # SQL queries for aggregations and window functions.
    - [database_index.sql](/database-adv-script/database_index.sql) # SQL commands to create indexes and measure performance.
    - [index_performance.md](/database-adv-script/index_performance.md) # Report on index performance improvements.
    - [performance.sql](/database-adv-script/performance.sql) # Initial and refactored complex queries with performance analysis.
    - [optimization_report.md](/database-adv-script/optimization_report.md) # Report on query optimization steps.
    - [partitioning.sql](/database-adv-script/partitioning.sql) # SQL commands for table partitioning.
    - [partition_performance.md](/database-adv-script/partition_performance.md) # Report on partitioning performance improvements.
    - [performance_monitoring.md](/database-adv-script/performance_monitoring.md) # Documentation on continuous performance monitoring.
    - [README.md](/database-adv-script/README.md) # Notes on advanced SQL scripts.


- [normalization.md](normalization.md) # Normalization process up to 3NF.
- [README.md](README.md) # Main project documentation (this file).


---

## 🧠 Project Goals

- Model a real-world AirBnB-style relational database
- Apply sound relational design and indexing
- **Normalize** all tables to **Third Normal Form (3NF)**
- **Use SQL** (MySQL-compatible) to define and populate the database schema
- **Master Advanced SQL:** Write complex queries involving joins, subqueries, and aggregations for data retrieval and analysis.
- **Optimize Query Performance:** Analyze and refactor SQL scripts using performance tools like EXPLAIN and ANALYZE.
- **Implement Indexing and Partitioning:** Understand and apply indexing and table partitioning to improve database performance for large datasets.
- **Monitor and Refine Performance:** Continuously monitor database health and refine schemas and queries for optimal performance.
- **Think Like a DBA:** Learn to make data-driven decisions about schema design and optimization strategies for high-volume applications.

---

## 📌 Entity-Relationship Diagram (ERD)

The ER diagram visualizes the relationships between major entities:

- **Users** (guests, hosts, admins)
- **Properties** listed by hosts
- **Bookings** made by guests
- **Payments**, **Reviews**, and **Messages**

![ERD](https://github.com/ahmedmkamal313/alx-airbnb-database/blob/main/ERD/airbnb_erd.PNG)

> 🧾 Full breakdown of entities, attributes, relationships, and cardinalities:  
> [ERD/requirements.md](./ERD/requirements.md)

---

## ✅ Database Normalization (3NF)

The design follows database normalization principles to eliminate redundancy and ensure data integrity.

- **1NF**: Atomic attributes, no repeating groups  
- **2NF**: No partial dependencies (no composite PKs)  
- **3NF**: No transitive dependencies  

Each table’s structure is explained in detail in the [normalization.md](./normalization.md) file.

---

## 🏗️ Database Schema (DDL)

File: [`database-script-0x01/schema.sql`](./database-script-0x01/schema.sql)

- Includes `CREATE TABLE` statements for:
  - Users
  - Properties
  - Bookings
  - Payments
  - Reviews
  - Messages

- All relationships are defined with foreign keys
- Includes constraints (e.g., CHECK, ENUM) and performance indexes
- Tailored for **MySQL** with UUIDs and ENUM types

> 📘 More details in: [`database-script-0x01/README.md`](./database-script-0x01/README.md)

---

## 🧪 Sample Seed Data (DML)

File: [`database-script-0x02/seed.sql`](./database-script-0x02/seed.sql)

- Adds multiple:
  - Users (with `host`, `guest`, and `admin` roles)
  - Properties (linked to hosts)
  - Bookings (linked to users and properties)
  - Payments (only for confirmed bookings)
  - Reviews (linked to both properties and users)
  - Messages (between users)

- Designed for development/testing environments
- Includes realistic use cases and interlinked data

> 📘 More details in: [`database-script-0x02/README.md`](./database-script-0x02/README.md)

---
## 📈 Advanced SQL Querying & Optimization
This section highlights the advanced SQL tasks undertaken to master complex querying, optimization, indexing, partitioning, and performance monitoring.

**1. Complex Queries with Joins**
Demonstrates the use of INNER JOIN, LEFT JOIN, and FULL OUTER JOIN to combine data from multiple tables.

  > 📘 See: [database-adv-script/joins_queries.sql](./database-adv-script/joins_queries.sql)

**2. Power of Subqueries**
Explores both correlated and non-correlated subqueries for advanced data retrieval and filtering.

  > 📘 See: [database-adv-script/subqueries.sql](./database-adv-script/subqueries.sql)

**3. Aggregations and Window Functions**
Applies SQL aggregation functions (COUNT, SUM, AVG) with GROUP BY and advanced window functions (ROW_NUMBER, RANK) for data analysis and ranking.

   > 📘 See: [database-adv-script/aggregations_and_window_functions.sql](./database-adv-script/aggregations_and_window_functions.sql)

**4. Indexing for Optimization**
Identifies high-usage columns and implements appropriate indexes to significantly improve query performance. Includes performance measurement before and after indexing.

  > 📘 See: [database-adv-script/database_index.sql](./database-adv-script/database_index.sql)
  > 🧾 Performance Report: [database-adv-script/index_performance.md](./database-adv-script/index_performance.md))

**5. Query Optimization Techniques**
Analyzes complex queries for inefficiencies using EXPLAIN ANALYZE and refactors them to reduce execution time.

  > 📘 See: [database-adv-script/performance.sql](./database-adv-script/performance.sql)
  > 🧾 Optimization Report: [database-adv-script/optimization_report.md](./database-adv-script/optimization_report.md)

**6. Partitioning Large Tables**
Implements table partitioning on the Bookings table based on date ranges to optimize queries on large datasets.

  > 📘 See: [database-adv-script/partitioning.sql](./database-adv-script/partitioning.sql))
  > 🧾 Performance Report: [database-adv-script/partition_performance.md](./database-adv-script/partition_performance.md)

**7. Performance Monitoring and Schema Refinement**
Details the process of continuously monitoring database performance, identifying bottlenecks, and suggesting/implementing schema adjustments for ongoing optimization.

  > 🧾 See: [database-adv-script/performance_monitoring.md](./database-adv-script/performance_monitoring.md)

---

## 🔗 Related Files

- ER Diagram: [`./ERD/airbnb_erd.png`](./ERD/airbnb_erd.png)
- ERD Metadata: [`./ERD/requirements.md`](./ERD/requirements.md)
- Schema: [`./database-script-0x01/schema.sql`](./database-script-0x01/schema.sql)
- Normalization: [`./normalization.md`](./normalization.md)
- Seed Data: [`./database-script-0x02/seed.sql`](./database-script-0x02/seed.sql)
- Advanced Queries: [`./database-adv-script/`](./database-adv-script/)

---
### 👤 Author
[🔗 GitHub: Ahmed Kamal](https://github.com/ahmedmkamal313)
