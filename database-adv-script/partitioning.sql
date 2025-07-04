-- partitioning.sql

-- This script demonstrates how to implement table partitioning on the
-- 'Bookings' table based on the 'start_date' column.
-- Partitioning can significantly improve query performance for large datasets,
-- especially for queries filtering by date ranges.

-- Step 0: (Optional, for clean re-run) Drop dependent tables and the original Bookings table
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Bookings; -- This will drop the original, non-partitioned table if it exists

-- Step 1: Create the master partitioned table for Bookings
-- This table acts as a template and holds no data itself.
CREATE TABLE Bookings (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- Step 2: Create partition tables for specific date ranges
-- Example: Partitioning by year or by quarter.

CREATE TABLE bookings_2024 PARTITION OF Bookings
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF Bookings
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');


-- Step 3: Re-create dependent tables with Foreign Key constraints
CREATE TABLE Payments (
    payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id UUID NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE,
    UNIQUE (booking_id)
);

-- Step 4: Re-insert data into the partitioned table
-- Data inserted into the master 'Bookings' table will automatically be routed
-- to the correct partition based on the 'start_date'.
-- Ensure the dates in seed.sql align with your partition ranges.
INSERT INTO Bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
    ('i0eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', '2025-07-10', '2025-07-15', 750.00, 'confirmed'),
    ('j0eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'g0eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '2025-08-01', '2025-08-07', 1803.00, 'pending'),
    ('k0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'h0eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', '2025-09-01', '2025-09-03', 200.00, 'canceled'),
    ('z0eebc99-9c0b-4ef8-bb6d-6bb9bd380a99', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', '2024-12-01', '2024-12-05', 600.00, 'confirmed');


-- Step 5: Test performance of queries on the partitioned table
-- Use EXPLAIN ANALYZE to observe partition pruning.
-- A query filtering by 'start_date' should only scan relevant partitions.

-- Query 1: Fetch bookings for a specific month in 2025
-- Expected: Should only scan 'bookings_2025' partition.
EXPLAIN ANALYZE
SELECT
    booking_id,
    start_date,
    end_date,
    total_price
FROM
    Bookings
WHERE
    start_date >= '2025-07-01' AND start_date < '2025-08-01';

-- Query 2: Fetch bookings for a specific month in 2024
-- Expected: Should only scan 'bookings_2024' partition.
EXPLAIN ANALYZE
SELECT
    booking_id,
    start_date,
    end_date,
    total_price
FROM
    Bookings
WHERE
    start_date >= '2024-12-01' AND start_date < '2025-01-01';

-- Query 3: Fetch bookings across multiple partitions.
-- Expected: Should scan multiple relevant partitions.
EXPLAIN ANALYZE
SELECT
    booking_id,
    start_date,
    end_date,
    total_price
FROM
    Bookings
WHERE
    start_date >= '2024-12-15' AND start_date < '2025-01-15';

