Query 1: Find Available Properties by Location
Initial Query

EXPLAIN ANALYZE
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.pricepernight,
    u.first_name || ' ' || u.last_name AS host_name
FROM "Property" p
JOIN "User" u ON p.host_id = u.user_id
WHERE p.location ILIKE '%Miami%'
AND p.property_id NOT IN (
    SELECT b.property_id
    FROM "Booking" b
    WHERE b.status = 'confirmed'
    AND b.start_date <= '2024-12-31'
    AND b.end_date >= '2024-12-01'
);

"Hash Join  (cost=2.66..3.95 rows=1 width=998) (actual time=0.641..0.649 rows=2.00 loops=1)"
"  Hash Cond: (u.user_id = p.host_id)"
"  Buffers: shared hit=3"
"  ->  Seq Scan on ""User"" u  (cost=0.00..1.20 rows=20 width=452) (actual time=0.027..0.029 rows=20.00 loops=1)"
"        Buffers: shared hit=1"
"  ->  Hash  (cost=2.65..2.65 rows=1 width=982) (actual time=0.588..0.589 rows=2.00 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"        Buffers: shared hit=2"
"        ->  Seq Scan on ""Property"" p  (cost=1.42..2.65 rows=1 width=982) (actual time=0.554..0.568 rows=2.00 loops=1)"
"              Filter: (((location)::text ~~* '%Miami%'::text) AND (NOT (ANY (property_id = (hashed SubPlan 1).col1))))"
"              Rows Removed by Filter: 13"
"              Buffers: shared hit=2"
"              SubPlan 1"
"                ->  Seq Scan on ""Booking"" b  (cost=0.00..1.42 rows=1 width=16) (actual time=0.032..0.036 rows=1.00 loops=1)"
"                      Filter: ((start_date <= '2024-12-31'::date) AND (end_date >= '2024-12-01'::date) AND ((status)::text = 'confirmed'::text))"
"                      Rows Removed by Filter: 23"
"                      Buffers: shared hit=1"
"Planning:"
"  Buffers: shared hit=8"
"Planning Time: 1.023 ms"
"Execution Time: 0.733 ms"

Identified Bottlenecks

Sequential Scan on Property - No index on location column
Sequential Scan on Booking - Filtering on status and date range without indexes
NOT IN Subquery - Anti-join operation can be expensive with large datasets

Optimization Strategy
Create Indexes:
-- Index for location-based searches
CREATE INDEX idx_property_location ON "Property" USING gin(to_tsvector('english', location));

-- Or simpler pattern matching index
CREATE INDEX idx_property_location_pattern ON "Property" (location);

-- Composite index for booking availability checks
CREATE INDEX idx_booking_status_dates ON "Booking" (status, start_date, end_date);

-- Index for property lookup in bookings
CREATE INDEX idx_booking_property_status ON "Booking" (property_id, status);

Optimized Query

EXPLAIN ANALYZE
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.pricepernight,
    u.first_name || ' ' || u.last_name AS host_name
FROM "Property" p
JOIN "User" u ON p.host_id = u.user_id
LEFT JOIN "Booking" b ON p.property_id = b.property_id
    AND b.status = 'confirmed'
    AND b.start_date <= '2024-12-31'
    AND b.end_date >= '2024-12-01'
WHERE p.location ILIKE '%Miami%'
AND b.booking_id IS NULL;

Improved Performance Results
"Nested Loop Left Join  (cost=1.20..3.92 rows=1 width=998) (actual time=0.139..0.173 rows=2.00 loops=1)"
"  Join Filter: (p.property_id = b.property_id)"
"  Rows Removed by Join Filter: 2"
"  Filter: (b.booking_id IS NULL)"
"  Buffers: shared hit=4"
"  ->  Hash Join  (cost=1.20..2.48 rows=1 width=1402) (actual time=0.106..0.116 rows=2.00 loops=1)"
"        Hash Cond: (u.user_id = p.host_id)"
"        Buffers: shared hit=2"
"        ->  Seq Scan on ""User"" u  (cost=0.00..1.20 rows=20 width=452) (actual time=0.033..0.036 rows=20.00 loops=1)"
"              Buffers: shared hit=1"
"        ->  Hash  (cost=1.19..1.19 rows=1 width=982) (actual time=0.064..0.064 rows=2.00 loops=1)"
"              Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"              Buffers: shared hit=1"
"              ->  Seq Scan on ""Property"" p  (cost=0.00..1.19 rows=1 width=982) (actual time=0.031..0.058 rows=2.00 loops=1)"
"                    Filter: ((location)::text ~~* '%Miami%'::text)"
"                    Rows Removed by Filter: 13"
"                    Buffers: shared hit=1"
"  ->  Seq Scan on ""Booking"" b  (cost=0.00..1.42 rows=1 width=32) (actual time=0.014..0.020 rows=1.00 loops=2)"
"        Filter: ((start_date <= '2024-12-31'::date) AND (end_date >= '2024-12-01'::date) AND ((status)::text = 'confirmed'::text))"
"        Rows Removed by Filter: 23"
"        Buffers: shared hit=2"
"Planning Time: 0.823 ms"
"Execution Time: 0.229 ms"

Performance Improvement
Before: "Execution Time: 0.733 ms"
After: "Execution Time: 0.229 ms"
