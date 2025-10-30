-- Query 1: Find all properties where the average rating is greater than 4.0 using a non-correlated 
-- subquery.
SELECT
    p.property_id,
    p.name,
    p.location
FROM
    "Property" AS p
WHERE
    p.property_id IN (
        -- Subquery: Find the property_ids that have an average rating > 4.0
        SELECT
            r.property_id
        FROM
            "Review" AS r
        GROUP BY
            r.property_id
        HAVING
            AVG(r.rating) > 4.0
    );



-- Query 2: Find users who have made more than 3 bookings using a correlated subquery.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM
    "User" AS u
WHERE
    -- Correlated Subquery: Checks the count of bookings for the current user (u.user_id)
    (
        SELECT
            COUNT(b.booking_id)
        FROM
            "Booking" AS b
        WHERE
            b.user_id = u.user_id -- Correlation condition
    ) > 3;