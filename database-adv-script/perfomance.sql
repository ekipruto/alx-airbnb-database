-- Initial Complex Query (Baseline for Performance Analysis)
-- Objective: Retrieve all bookings along with user, property, and payment details.
-- This query uses multiple INNER JOINs which will serve as the baseline for optimization.
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    p.name AS property_name,
    p.location AS property_location,
    pm.amount AS payment_amount,
    pm.payment_date
FROM
    "Booking" AS b
INNER JOIN
    "User" AS u ON b.user_id = u.user_id
INNER JOIN
    "Property" AS p ON b.property_id = p.property_id
INNER JOIN
    "Payment" AS pm ON b.booking_id = pm.booking_id
ORDER BY
    b.start_date;

    -- =================================================================
-- Optimized Query (Refactored for Performance)
-- Optimization Technique: Leveraging existing indexes and using efficient LEFT JOIN
-- for payment details, as not every booking may have a completed payment record.
-- =================================================================
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    u.email AS user_contact_email, -- Selecting high-value columns only
    p.name AS property_name,
    pm.amount AS payment_amount,
    pm.payment_method
FROM
    "Booking" AS b
JOIN
    "User" AS u ON b.user_id = u.user_id
JOIN
    "Property" AS p ON b.property_id = p.property_id
LEFT JOIN
    "Payment" AS pm ON b.booking_id = pm.booking_id -- Use LEFT JOIN for optional details
WHERE
    b.status = 'confirmed' -- Adding a filter to reduce the initial result set size
ORDER BY
    b.start_date
LIMIT 1000; -- Adding a limit, a practical optimization for reporting tools

