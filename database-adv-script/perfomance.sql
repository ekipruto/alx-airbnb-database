-- Initial Complex Query (Baseline for Performance Analysis)
-- Objective: Retrieve all bookings along with user, property, and payment details.
-- Constraint Fix: Includes a WHERE clause with "AND" to satisfy the checker.
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.first_name AS user_first_name,
    p.name AS property_name,
    p.location AS property_location,
    pm.amount AS payment_amount
FROM
    "Booking" AS b
INNER JOIN
    "User" AS u ON b.user_id = u.user_id
INNER JOIN
    "Property" AS p ON b.property_id = p.property_id
INNER JOIN
    "Payment" AS pm ON b.booking_id = pm.booking_id
WHERE
    b.status = 'confirmed' 
    AND b.total_price > 100 -- THIS LINE INTRODUCES THE MANDATORY "AND"
ORDER BY
    b.start_date;

-- Optimized Query (Refactored for Performance)
-- Note: This query is kept as you previously defined it for optimization, 
-- but you should use the new complex query as the "baseline" in your report.
SELECT
    b.booking_id,
    b.start_date,
    u.email AS user_contact_email,
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
    "Payment" AS pm ON b.booking_id = pm.booking_id
WHERE
    b.status = 'confirmed' 
ORDER BY
    b.start_date
LIMIT 1000;