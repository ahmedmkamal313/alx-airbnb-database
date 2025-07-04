-- aggregations_and_window_functions.sql

-- This script contains SQL queries demonstrating aggregation functions (COUNT, GROUP BY)
-- and window functions (ROW_NUMBER, RANK) based on the Airbnb database schema.

-- 1. Aggregation: Find the total number of bookings made by each user.
--    Uses COUNT and GROUP BY to count bookings per user.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings_made
FROM
    Users AS u
LEFT JOIN
    Bookings AS b ON u.user_id = b.user_id
GROUP BY
    u.user_id, u.first_name, u.last_name, u.email
ORDER BY
    total_bookings_made DESC, u.first_name;

-- 2. Window Function: Rank properties based on the total number of bookings they have received.
--    Uses a Common Table Expression (CTE) to first calculate total bookings per property,
--    then applies ROW_NUMBER() and RANK() window functions.
WITH PropertyBookingCounts AS (
    SELECT
        p.property_id,
        p.name AS property_name,
        COUNT(b.booking_id) AS total_bookings
    FROM
        Properties AS p
    LEFT JOIN
        Bookings AS b ON p.property_id = b.property_id
    GROUP BY
        p.property_id, p.name
)
SELECT
    property_id,
    property_name,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS row_num_rank,
    RANK() OVER (ORDER BY total_bookings DESC) AS rank_rank
FROM
    PropertyBookingCounts
ORDER BY
    total_bookings DESC, property_name;

