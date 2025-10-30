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

-- Query 2: Use a window function (RANK) to rank properties
-- based on the total number of bookings they have received.
WITH PropertyBookings AS (
    -- Step 1: Calculate total bookings per property
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
    -- Step 2: Apply the window function (RANK)
    ROW_NUMBER() OVER (ORDER BY booking_count DESC) AS booking_rank_number
FROM
    PropertyBookings
ORDER BY
    booking_rank_number;