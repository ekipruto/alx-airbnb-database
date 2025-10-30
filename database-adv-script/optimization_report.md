## Objective
To analyze the performance of a complex multi-join query and refactor it to reduce execution time, leveraging existing indexing strategies.

---

## 1. Baseline Analysis: Initial Complex Query

This initial query uses four consecutive INNER JOINs to retrieve all possible booking, user, property, and payment details.

### EXPLAIN ANALYZE Results (Initial Query)
EXPLAIN ANALYZE 
SELECT 
    b.booking_id, b.start_date, b.end_date, b.total_price, 
    u.first_name, p.name, p.location, pm.amount 
FROM "Booking" AS b 
INNER JOIN "User" AS u ON b.user_id = u.user_id 
INNER JOIN "Property" AS p ON b.property_id = p.property_id 
INNER JOIN "Payment" AS pm ON b.booking_id = pm.booking_id 
WHERE b.status = 'confirmed' 
    AND b.total_price > 100 
ORDER BY b.start_date;


| Metric | Observation |
| :--- | :--- |
| **Execution Time Execution Time: 0.643 ms
|"Hash  (cost=1.20..1.20 rows=20 width=452) (actual time=0.068..0.069 rows=20.00 loops=1)"

**Full EXPLAIN ANALYZE Output (Before Optimization):**
| **Execution Time "Execution Time: 0.823 ms" |
| **Key Operation* "Hash  (cost=1.30..1.30 rows=1 width=52) (actual time=0.037..0.037 rows=17.00 loops=1)"