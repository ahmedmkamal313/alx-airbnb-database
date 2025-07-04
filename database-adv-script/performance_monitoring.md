# 🛠️ Database Performance Monitoring and Refinement

This document outlines the process for continuously monitoring database query performance, identifying bottlenecks, proposing schema optimizations, implementing those changes, and reporting on observed improvements.

---

## 🎯 Objective

Ensure optimal database performance by proactively identifying and resolving inefficiencies in query execution and schema design.

---

## 🔍 Methodology

This approach consists of four main steps:

1. **Identify frequently used or slow queries**  
2. **Monitor performance and identify bottlenecks**  
3. **Propose and implement schema/index improvements**  
4. **Re-measure performance and document improvements**

---

## 📌 Step 1: Identify Frequently Used or Slow Queries

Choose queries that are critical to application performance or have historically shown poor execution times.

### Example Queries:

**Query 1 – Fetch a user's bookings with property details:**
```sql
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    p.name AS property_name,
    p.location
FROM
    Bookings AS b
JOIN
    Properties AS p ON b.property_id = p.property_id
WHERE
    b.user_id = 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12'
ORDER BY
    b.start_date DESC;
```

**Query 2 – Find properties with high average ratings:**
```sql
SELECT
    p.property_id,
    p.name,
    AVG(r.rating) AS average_rating
FROM
    Properties AS p
JOIN
    Reviews AS r ON p.property_id = r.property_id
GROUP BY
    p.property_id, p.name
HAVING
    AVG(r.rating) > 4.5
ORDER BY
    average_rating DESC;
```

**Query 3 – Retrieve recent messages for a user:**
```sql
SELECT
    m.message_id,
    m.message_body,
    m.sent_at,
    u_sender.first_name AS sender_name,
    u_recipient.first_name AS recipient_name
FROM
    Messages AS m
JOIN
    Users AS u_sender ON m.sender_id = u_sender.user_id
JOIN
    Users AS u_recipient ON m.recipient_id = u_recipient.user_id
WHERE
    m.recipient_id = 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'
ORDER BY
    m.sent_at DESC
LIMIT 10;
```

---

## 📊 Step 2: Monitor Performance and Identify Bottlenecks

Use tools like `EXPLAIN ANALYZE` (PostgreSQL) or `EXPLAIN`/`SHOW PROFILE` (MySQL) to understand how the database executes each query.

### Example:
```sql
EXPLAIN ANALYZE
SELECT ...
```

### Look for:
- `Seq Scan`: Full table scans on large tables.
- `Sort`: Expensive sorting not using an index.
- `Nested Loop Join`: Can be inefficient on large datasets.
- Actual vs. estimated row counts and execution times.

---

## ⚙️ Step 3: Suggest and Implement Changes

Based on the observed bottlenecks, apply targeted improvements.

### 🔧 Common Fixes:

#### ✅ New Indexes
If a column is repeatedly used in `WHERE`, `JOIN`, or `ORDER BY` clauses:

```sql
CREATE INDEX idx_bookings_user_id ON Bookings (user_id);
CREATE INDEX idx_bookings_user_id_start_date ON Bookings (user_id, start_date DESC);
CREATE INDEX idx_reviews_property_id ON Reviews (property_id);
CREATE INDEX idx_messages_recipient_sent_at ON Messages (recipient_id, sent_at DESC);
```

#### 🏗️ Schema Adjustments
- **Partitioning**: Especially helpful for large time-based tables like `Bookings`.
- **Materialized Views**: For frequently accessed aggregates.
- **Denormalization** (last resort): Only if a join is costly and data is relatively static.

---

## 📈 Step 4: Report Observed Improvements

After applying changes, re-run queries and compare the results:

| Query | Initial Time | Bottlenecks | Implemented Change | Final Time | Improvement |
|-------|--------------|-------------|---------------------|------------|-------------|
| Query 1 | 120ms | Seq Scan on Bookings | Composite index on (user_id, start_date) | 5ms | 95% ↓ |
| Query 2 | 80ms | Full Table Scan on Reviews | Index on property_id | 3ms | 96% ↓ |
| Query 3 | 50ms | Sort, Hash Join | Index on (recipient_id, sent_at) | 2ms | 96% ↓ |

> 📌 Replace example values with actual test results from your DB.

---

## 🧠 Conclusion

By actively monitoring and refining query performance:
- Response times are significantly reduced.
- Backend scalability improves.
- Users experience a more responsive application.

**Key Takeaway**: Don't wait for performance issues to become critical—optimize as you grow. 🚀
