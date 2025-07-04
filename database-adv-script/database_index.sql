-- database_index.sql

-- This script contains SQL commands to create indexes on high-usage columns
-- in the Users, Properties, and Bookings tables of the Airbnb database schema.
-- These indexes are designed to improve query performance for common operations.

-- 1. Indexes for Users Table
-- The 'email' column already has a UNIQUE constraint, which typically creates an index.
-- If not, or for explicit clarity, you could add:
-- CREATE UNIQUE INDEX idx_users_email ON Users (email);

-- 2. Indexes for Properties Table
-- Index on host_id for faster lookups of properties by host.
CREATE INDEX idx_properties_host_id ON Properties (host_id);
-- Index on location for faster searching of properties by location.
CREATE INDEX idx_properties_location ON Properties (location);

-- 3. Indexes for Bookings Table
-- Indexes on foreign keys (property_id, user_id) for faster joins and lookups.
CREATE INDEX idx_bookings_property_id ON Bookings (property_id);
CREATE INDEX idx_bookings_user_id ON Bookings (user_id);
-- Indexes on start_date and end_date for efficient date range queries.
CREATE INDEX idx_bookings_start_date ON Bookings (start_date);
CREATE INDEX idx_bookings_end_date ON Bookings (end_date);

-- Optional: Composite index for frequently queried date ranges or combined filters
-- For example, if you often search for bookings by property and date range:
-- CREATE INDEX idx_bookings_property_dates ON Bookings (property_id, start_date, end_date);

