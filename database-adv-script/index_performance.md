# 📊 Index Performance Analysis

This document outlines the process for measuring and analyzing the performance impact of adding indexes to the Airbnb database schema.

---

## 🎯 Objective

To demonstrate how database indexes improve query execution times by comparing query performance **before** and **after** index creation.

---

## 🔍 Identified High-Usage Columns for Indexing

Based on common query patterns and foreign key relationships, the following columns have been identified as candidates for indexing to optimize performance:

### 🧑‍💻 Users Table
- `email`: Frequently used in login, user lookups, and unique constraint enforcement.
  > *Note: Often implicitly indexed by a `UNIQUE` constraint.*

### 🏘️ Properties Table
- `host_id`: Used in joins to link properties to hosts.
- `location`: Frequently used in `WHERE` clauses for property search.

### 📆 Bookings Table
- `property_id`: Used in joins to link bookings to properties.
- `user_id`: Used in joins to link bookings to users.
- `start_date`, `end_date`: Crucial for date range queries and availability checks.

---

## 🛠️ Index Creation

The `database_index.sql` script contains the `CREATE INDEX` statements for these identified columns.

---

## ⚙️ Measuring Query Performance

To evaluate the performance gain from indexes, follow the steps below:

---

### ✅ Step 1: Baseline Measurement (Before Indexes)

1. **Ensure no custom indexes exist**  
   If you’ve already run `database_index.sql`, drop the indexes:
   ```sql
   DROP INDEX IF EXISTS idx_properties_host_id ON Properties;
   ```

2. **Run representative queries**  
   Example queries that benefit from indexes:
   ```sql
   SELECT * FROM Properties WHERE location = 'New York, NY';

   SELECT COUNT(*) FROM Bookings
   WHERE start_date BETWEEN '2025-07-01' AND '2025-07-31';

   SELECT u.first_name, p.name
   FROM Users u
   JOIN Properties p ON u.user_id = p.host_id
   WHERE u.user_id = 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11';
   ```

3. **Analyze Query Plan**
   Use:
   - PostgreSQL:  
     ```sql
     EXPLAIN ANALYZE SELECT ...;
     ```
   - MySQL:  
     ```sql
     EXPLAIN SELECT ...;
     SHOW WARNINGS;
     -- or
     ANALYZE TABLE table_name;
     ```

4. **Record Results**  
   Note execution time and important query plan details (e.g., full table scan, join method).

---

### ✅ Step 2: Measurement After Index Creation

1. **Create Indexes**  
   Run the script:
   ```sql
   \i database_index.sql
   ```

2. **Repeat Representative Queries**  
   Execute the same queries from Step 1.

3. **Analyze Query Plan Again**  
   Use `EXPLAIN ANALYZE` or `EXPLAIN` to compare plans and execution times.

4. **Record Results**  
   Note performance improvements and changes in scan types or join strategies.

---

## 📝 Documenting Results

Present your findings in a table like this:

| Query Description            | Before Indexing (Time) | Before (Plan)        | After Indexing (Time) | After (Plan)      |
|-----------------------------|------------------------|-----------------------|------------------------|-------------------|
| Properties by location      | 150ms                  | Full Table Scan       | 5ms                    | Index Scan        |
| Count Bookings in July      | 200ms                  | Sequential Scan       | 8ms                    | Index Range Scan  |
| Join Users & Properties     | 120ms                  | Nested Loop (Seq Scan)| 7ms                    | Index Join        |

---

## 📈 Performance Analysis Summary

> ✅ *The index on `location` allowed the query to switch from a full table scan to an index scan, significantly reducing I/O and improving response time from 150ms to 5ms.*

---

## 📂 Related File

- [database_index.sql:](/database-adv-script/database_index.sql) Contains all index creation statements used in this analysis.
