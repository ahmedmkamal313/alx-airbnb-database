-- joins_queries.sql

-- This script contains SQL queries demonstrating different types of JOINs
-- (INNER JOIN, LEFT JOIN, FULL OUTER JOIN) based on the Airbnb database schema.

-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings.
--    This query will only return rows where there is a match in both the Bookings and Users tables.
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM
    Bookings AS b
INNER JOIN
    Users AS u ON b.user_id = u.user_id;

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews.
--    This query will return all properties from the Properties table, and matching reviews
--    from the Reviews table. If a property has no reviews, the review-related columns
--    will show NULL values.
SELECT
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM
    Properties AS p
LEFT JOIN
    Reviews AS r ON p.property_id = r.property_id;

-- 3. FULL OUTER JOIN: Retrieve all users and all bookings, even if the user has no booking
--    or a booking is not linked to a user.

SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM
    Users AS u
FULL OUTER JOIN
    Bookings AS b ON u.user_id = b.user_id;
