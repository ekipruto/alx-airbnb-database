-- Query 1: Find the total number of bookings made by each user,
-- using the COUNT function and GROUP BY clause.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings_made
FROM
    "User" AS u
LEFT JOIN
    "Booking" AS b ON u.user_id = b.user_id
GROUP BY
    u.user_id, u.first_name, u.last_name, u.email
ORDER BY
    total_bookings_made DESC;

-- 1. COUNT and GROUP BY: Total Bookings Per User
-- Write a query to find the total number of bookings made by each user,
-- using the COUNT function and GROUP BY clause.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings_made
FROM
    "User" AS u
LEFT JOIN
    "Booking" AS b ON u.user_id = b.user_id
GROUP BY
    u.user_id, u.first_name, u.last_name, u.email
ORDER BY
    total_bookings_made DESC;

-- 2. Window Functions (ROW_NUMBER, RANK)
-- Use a window function (ROW_NUMBER, RANK) to rank properties based
-- on the total number of bookings they have received.
WITH PropertyBookings AS (
    -- Calculate total bookings per property
    SELECT
        p.property_id,
        p.name,
        COUNT(b.booking_id) AS booking_count
    FROM
        "Property" AS p
    LEFT JOIN
        "Booking" AS b ON p.property_id = b.property_id
    GROUP BY
        p.property_id, p.name
)
SELECT
    property_id,
    name,
    booking_count,
    -- Ranking using RANK()
    RANK() OVER (ORDER BY booking_count DESC) AS rank_by_bookings,
    -- Ranking using ROW_NUMBER()
    ROW_NUMBER() OVER (ORDER BY booking_count DESC) AS row_num_by_bookings
FROM
    PropertyBookings
ORDER BY
    rank_by_bookings, row_num_by_bookings;