-- database_index.sql

-- This script first runs a set of queries to establish a performance baseline
-- without specific custom indexes.
-- Then, it creates appropriate indexes on high-usage columns.
-- Finally, it re-runs the same queries to demonstrate the performance improvement
-- due to the newly created indexes.

-- ##############################################################################
-- SECTION 1: BASELINE MEASUREMENT (BEFORE INDEXES)
-- Run representative queries and analyze their execution plans.
-- Use EXPLAIN ANALYZE for PostgreSQL or EXPLAIN for MySQL.
-- ##############################################################################

-- Query 1: Search properties by location
-- Expected: Likely a full table scan without an index on 'location'.
EXPLAIN ANALYZE SELECT * FROM Properties WHERE location = 'New York, NY';

-- Query 2: Count bookings within a date range
-- Expected: Likely a full table scan on Bookings without indexes on 'start_date'/'end_date'.
EXPLAIN ANALYZE SELECT COUNT(*) FROM Bookings WHERE start_date BETWEEN '2025-07-01' AND '2025-07-31';

-- Query 3: Join Users and Properties, filtering by host_id
-- Expected: May involve sequential scan on Properties or slower join without index on 'host_id'.
EXPLAIN ANALYZE SELECT u.first_name, p.name
FROM Users u
JOIN Properties p ON u.user_id = p.host_id
WHERE u.user_id = 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11';


-- ##############################################################################
-- SECTION 2: INDEX CREATION
-- Create appropriate indexes on identified high-usage columns.
-- ##############################################################################

-- 1. Indexes for Properties Table
-- Index on host_id for faster lookups of properties by host.
CREATE INDEX idx_properties_host_id ON Properties (host_id);
-- Index on location for faster searching of properties by location.
CREATE INDEX idx_properties_location ON Properties (location);

-- 2. Indexes for Bookings Table
-- Indexes on foreign keys (property_id, user_id) for faster joins and lookups.
CREATE INDEX idx_bookings_property_id ON Bookings (property_id);
CREATE INDEX idx_bookings_user_id ON Bookings (user_id);
-- Indexes on start_date and end_date for efficient date range queries.
CREATE INDEX idx_bookings_start_date ON Bookings (start_date);
CREATE INDEX idx_bookings_end_date ON Bookings (end_date);

-- Note: Primary Keys (e.g., user_id, property_id, booking_id) are typically
-- automatically indexed by the database system. The 'email' column in Users
-- table already has a UNIQUE constraint, which also usually creates an index.


-- ##############################################################################
-- SECTION 3: MEASUREMENT AFTER INDEX CREATION
-- Re-run the same representative queries and analyze their execution plans
-- with the new indexes in place.
-- ##############################################################################

-- Query 1: Search properties by location (after index)
-- Expected: Should now use the idx_properties_location index.
EXPLAIN ANALYZE SELECT * FROM Properties WHERE location = 'New York, NY';

-- Query 2: Count bookings within a date range (after index)
-- Expected: Should now use idx_bookings_start_date and/or idx_bookings_end_date.
EXPLAIN ANALYZE SELECT COUNT(*) FROM Bookings WHERE start_date BETWEEN '2025-07-01' AND '2025-07-31';

-- Query 3: Join Users and Properties, filtering by host_id (after index)
-- Expected: Should now use idx_properties_host_id for the join/filter on Properties.
EXPLAIN ANALYZE SELECT u.first_name, p.name
FROM Users u
JOIN Properties p ON u.user_id = p.host_id
WHERE u.user_id = 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11';