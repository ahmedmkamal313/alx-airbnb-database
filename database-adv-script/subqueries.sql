-- subqueries.sql

-- This script contains SQL queries demonstrating both non-correlated and correlated subqueries
-- based on the Airbnb database schema.

-- 1. Non-Correlated Subquery: Find all properties where the average rating is greater than 4.0.
--    This subquery runs independently and returns a set of property_ids.
--    The outer query then uses this set to filter properties.
SELECT
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight
FROM
    Properties AS p
WHERE
    p.property_id IN (
        SELECT
            r.property_id
        FROM
            Reviews AS r
        GROUP BY
            r.property_id
        HAVING
            AVG(r.rating) > 4.0
    );

-- 2. Correlated Subquery: Find users who have made more than 3 bookings.
--    This subquery executes once for each row processed by the outer query.
--    It checks the count of bookings for the specific user_id from the outer query.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM
    Users AS u
WHERE
    (SELECT COUNT(b.booking_id)
     FROM Bookings AS b
     WHERE b.user_id = u.user_id) > 3;

