1. Identify High-Usage Columns
Based on my schema and the queries for users, bookings, 
and reviews, here are the high-usage columns that will benefit most from 
indexing:
Table,High-Usage Column(s),Usage Context
"""User""","email, role","WHERE clause (login/filtering), JOIN key (already covered by unique/index)."
"""Property""","host_id, location, pricepernight","WHERE (searching/filtering), JOIN key (already indexed by FK)."
"""Booking""","start_date, end_date, status","WHERE (availability/filtering), ORDER BY, and JOIN keys (already indexed by FK)."
"""Review""","property_id, rating","JOIN key, WHERE (filtering by rating), GROUP BY (for average rating)."


# Index Performance Analysis

## Objective
To measure the performance improvement of complex queries after applying new custom indexes defined in `database_index.sql`.

## Test Query
The following query is used to test performance, as it relies on multiple filters and a subquery/join:

```sql
SELECT
    p.name,
    p.location,
    AVG(r.rating) AS average_rating
FROM
    "Property" AS p
JOIN
    "Review" AS r ON p.property_id = r.property_id
WHERE
    p.location = 'Paris, France'
GROUP BY
    p.property_id, p.name, p.location
HAVING
    AVG(r.rating) >= 4.5
ORDER BY
    average_rating DESC;
1. Performance BEFORE Index Creation (Baseline)
    Metric,Observation
    Execution Time,"[Successfully run. Total query runtime: 162 msec., e.g.,  ms]"
    Key Operation,"[PASTE MAIN OPERATION, e.g., Sequential Scan on ""Property""]"

    -- 1. Index for Property Search Optimization (Location and Price)
CREATE INDEX idx_property_location_price ON "Property" (location, pricepernight);

-- 2. Index for Booking Availability and Conflict Checks
CREATE INDEX idx_booking_dates_property ON "Booking" (property_id, start_date, end_date);

-- 3. Index for Fast Review Aggregation
CREATE INDEX idx_review_property_rating_agg ON "Review" (property_id, rating);

-- 4. Index for User Filtering
CREATE INDEX idx_user_last_name ON "User" (last_name);

-- 5. Index for Property Filtering by Host
CREATE INDEX idx_property_host_created ON "Property" (host_id, created_at DESC);

2. Performance AFTER Index Creation (Optimized)
running the above query gives:
    Metric,Observation
    Execution Time,"[Successfully run. Total query runtime: Query complete 00:00:00.156 msec., e.g.,  ms]"
    Key Operation,"[PASTE MAIN OPERATION, e.g., Sequential Scan on ""Property""]"

