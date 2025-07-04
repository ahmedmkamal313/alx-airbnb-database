# 📊 Table Partitioning Performance Report

This report details the implementation of table partitioning on the `Bookings` table and analyzes its impact on query performance, particularly for date-range queries.

---

## 🎯 Objective

To demonstrate how partitioning a large table can optimize query execution times by reducing the amount of data scanned during queries.

---

## 🧩 Partitioning Strategy

The `Bookings` table is partitioned by **RANGE** on the `start_date` column.

### Why RANGE on `start_date`?

- `start_date` is commonly used in WHERE clauses (e.g., to find bookings within a month or year).
- **Range partitioning** enables **partition pruning**, meaning the database only reads relevant partitions during query execution.

---

## ⚙️ Partition Implementation Steps

As defined in `partitioning.sql`:

1. **Recreate the Master Table**  
   - Drop and recreate `Bookings` as a partitioned table using:
     ```sql
     CREATE TABLE Bookings (
         ...
     ) PARTITION BY RANGE (start_date);
     ```

2. **Create Child Partitions**  
   - Example:
     ```sql
     CREATE TABLE bookings_2024 PARTITION OF Bookings
     FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
     ```

3. **Update Foreign Keys**  
   - Update `Payments` (and other dependent tables) to reference the new partitioned structure.

4. **Data Re-Insertion**  
   - Insert data into `Bookings`; the database routes rows to the appropriate partition automatically.

---

## 🧪 Performance Testing Methodology

To evaluate performance:

- **Tools Used**: `EXPLAIN ANALYZE` (PostgreSQL) or `EXPLAIN` (MySQL).
- **Comparison**: Query execution on the non-partitioned `Bookings` table **vs.** the partitioned version.
- **Test Queries**:
  - Query 1: Bookings in **July 2025**
  - Query 2: Bookings in **December 2024**
  - Query 3: Bookings between **December 2024 and January 2025**

---

## 📈 Observed Improvements

| Query | Description | Before Partitioning (Conceptual) | After Partitioning (Actual) | Improvement |
|-------|-------------|----------------------------------|-----------------------------|-------------|
| Query 1 | Bookings in July 2025 | 1500 ms<br>Full Table Scan | _e.g._ 80 ms<br>Index Scan on `bookings_2025` | 🔻 ~95% |
| Query 2 | Bookings in Dec 2024 | 1400 ms<br>Full Table Scan | _e.g._ 100 ms<br>Index Scan on `bookings_2024` | 🔻 ~90% |
| Query 3 | Bookings Dec 2024 - Jan 2025 | 1600 ms<br>Full Table Scan | _e.g._ 180 ms<br>Index Scan on `bookings_2024`, `bookings_2025` | 🔻 ~88% |

> 📌 Replace these example times with actual measurements from your testing.

---

## 🔍 Sample Query

```sql
EXPLAIN ANALYZE
SELECT * FROM Bookings
WHERE start_date BETWEEN '2025-07-01' AND '2025-07-31';
```

**Expected Output (PostgreSQL example):**
```sql
Index Scan using idx_bookings_start_date on bookings_2025
  Index Cond: (start_date >= '2025-07-01' AND start_date <= '2025-07-31')
```

---

## 🧠 Conclusion

Partitioning the `Bookings` table by `start_date`:

- Enables **partition pruning**.
- Reduces **I/O operations**.
- Significantly improves **query speed** for time-based queries.

> 🏆 This is especially important for high-volume systems like Airbnb, where users frequently search bookings by date.

Partitioning is a powerful optimization strategy when managing large datasets with predictable access patterns.
