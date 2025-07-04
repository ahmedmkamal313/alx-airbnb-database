# 🧠 Advanced Database Scripting

This directory contains advanced SQL scripts and performance documentation for the **ALX Airbnb Database Module**, focusing on optimization, query efficiency, and modern SQL techniques.

---

## 🎯 Purpose

This module is designed to demonstrate and validate proficiency in:

- ✅ **Complex SQL Queries**: Using various joins, subqueries, and aggregations.
- 🚀 **Query Optimization**: Analyzing and refactoring SQL for better execution times.
- 📊 **Indexing & Partitioning**: Enhancing performance for large datasets.
- 🔍 **Performance Monitoring**: Continuously improving database health via metrics and refinement.

---

## 📂 Contents

| Filename | Description |
|----------|-------------|
| `joins_queries.sql` | Demonstrates `INNER JOIN`, `LEFT JOIN`, and `FULL OUTER JOIN` across tables. |
| `subqueries.sql` | Contains non-correlated and correlated subqueries for advanced filtering and analysis. |
| `aggregations_and_window_functions.sql` | Uses `GROUP BY`, `COUNT`, `ROW_NUMBER`, `RANK`, etc., for analytics. |
| `database_index.sql` | Includes `CREATE INDEX` statements and `EXPLAIN ANALYZE` to test performance impact. |
| `index_performance.md` | Documents before/after analysis of queries enhanced by indexing. |
| `performance.sql` | Shows an original complex query, its performance test, and a refactored version. |
| `optimization_report.md` | Explains refactoring process and performance improvements in depth. |
| `partitioning.sql` | Implements `PARTITION BY RANGE` on the `Bookings` table and shows impact using `EXPLAIN ANALYZE`. |
| `partition_performance.md` | Documentation for partitioning impact on query performance. |
| `performance_monitoring.md` | Outlines continuous monitoring and schema refinement processes. |

---

## 🛠️ How to Use

To execute these scripts, follow these steps:

1. Ensure your **Airbnb database schema** is created via `schema.sql` (from `database-script-0x01/`).
2. Populate the database using `seed.sql` (from `database-script-0x02/`).
3. Connect to your SQL database (PostgreSQL or MySQL).
4. Run the appropriate script using your client’s command syntax.

---

### ✅ Example Commands

#### PostgreSQL (psql):
```bash
psql -U your_username -d your_database_name
\i joins_queries.sql
\i subqueries.sql
\i aggregations_and_window_functions.sql
\i database_index.sql
\i performance.sql
\i partitioning.sql
```

#### MySQL:
```bash
mysql -u your_username -p your_database_name
source joins_queries.sql;
source subqueries.sql;
source aggregations_and_window_functions.sql;
source database_index.sql;
source performance.sql;
source partitioning.sql;
```

---

## 📘 Related Dependencies

- **Schema**: [database-script-0x01/schema.sql](database-script-0x01/schema.sql)
- **Data**: [database-script-0x02/seed.sql](database-script-0x02/seed.sql)
---
