-- performance.sql

-- This script demonstrates query optimization by:
-- 1. Presenting an initial complex query.
-- 2. Analyzing its performance using EXPLAIN ANALYZE.
-- 3. Refactoring the query for improved performance.
-- 4. Analyzing the refactored query's performance.

-- ##############################################################################
-- SECTION 1: INITIAL COMPLEX QUERY AND BASELINE ANALYSIS
-- Objective: Retrieve all bookings along with user details, property details,
-- and payment details.
-- ##############################################################################

-- Initial Complex Query
-- This query uses multiple INNER JOINs to combine data from four tables.
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price AS booking_total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    pm.payment_id,
    pm.amount AS payment_amount,
    pm.payment_date,
    pm.payment_method
FROM
    Bookings AS b
INNER JOIN
    Users AS u ON b.user_id = u.user_id
INNER JOIN
    Properties AS p ON b.property_id = p.property_id
INNER JOIN
    Payments AS pm ON b.booking_id = pm.booking_id
ORDER BY
    b.created_at DESC;

-- Analyze Initial Query Performance
-- Use EXPLAIN ANALYZE for PostgreSQL or EXPLAIN for MySQL
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price AS booking_total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    pm.payment_id,
    pm.amount AS payment_amount,
    pm.payment_date,
    pm.payment_method
FROM
    Bookings AS b
INNER JOIN
    Users AS u ON b.user_id = u.user_id
INNER JOIN
    Properties AS p ON b.property_id = p.property_id
INNER JOIN
    Payments AS pm ON b.booking_id = pm.booking_id
ORDER BY
    b.created_at DESC;

-- ##############################################################################
-- SECTION 2: REFACTORED OPTIMIZED QUERY AND ANALYSIS
-- Refactoring Strategy:
-- - Ensure all relevant foreign keys are indexed (already done in database_index.sql).
-- - Use appropriate join types. For this specific query, INNER JOINs are correct
--   as we need matching records from all tables.
-- - Consider if any subqueries or CTEs could simplify or improve specific parts,
--   though for simple joins, direct joins are often efficient.
-- - If filtering conditions were present, ensure they leverage indexes.
-- ##############################################################################
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price AS booking_total_price,
    b.status AS booking_status,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    pm.amount AS payment_amount,
    pm.payment_date
FROM
    Bookings AS b
INNER JOIN
    Users AS u ON b.user_id = u.user_id
INNER JOIN
    Properties AS p ON b.property_id = p.property_id
INNER JOIN
    Payments AS pm ON b.booking_id = pm.booking_id
WHERE
    b.start_date >= '2025-07-01' AND b.end_date <= '2025-07-31' -- Example filter
ORDER BY
    b.created_at DESC;

-- Analyze Refactored Query Performance
-- Use EXPLAIN ANALYZE for PostgreSQL or EXPLAIN for MySQL
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price AS booking_total_price,
    b.status AS booking_status,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    pm.amount AS payment_amount,
    pm.payment_date
FROM
    Bookings AS b
INNER JOIN
    Users AS u ON b.user_id = u.user_id
INNER JOIN
    Properties AS p ON b.property_id = p.property_id
INNER JOIN
    Payments AS pm ON b.booking_id = pm.booking_id
WHERE
    b.start_date >= '2025-07-01' AND b.end_date <= '2025-07-31'
ORDER BY
    b.created_at DESC;

