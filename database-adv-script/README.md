Absolutely — here is a short, clean, professional `README.md` for your Task 0

---

# Task 0 — Complex SQL Joins

This task demonstrates how to use different types of SQL joins to retrieve related data from multiple tables in the **ALX AirBnB Database**.

---

## Queries Included

| Query | Join Type       | Purpose                                                                      |
| ----- | --------------- | ---------------------------------------------------------------------------- |
| 1️⃣   | INNER JOIN      | Show bookings with the users who made them                                   |
| 2️⃣   | LEFT JOIN       | Show all properties and their reviews (including properties without reviews) |
| 3️⃣   | FULL OUTER JOIN | Show all users and all bookings, including unmatched records                 |

---

## File Structure

```
alx-airbnb-database/
└── joins_queries.sql   # Task 0 solution
```

---

## How to Run

```bash
# Connect to DB
psql -U postgres -d alx_airbnb_db

# Execute file
\i joins_queries.sql
```

---

## Expected Results

| Table                      | Expected Count                   |
| -------------------------- | -------------------------------- |
| Booking                    | 25 rows                          |
| User                       | 20 rows                          |
| Property                   | 15 rows                          |
| Review                     | 15 rows                          |
| Properties without reviews | Included (NULL review columns) |
| Users without bookings     | Included in Full Outer Join    |

---

## What You Learn

* Understanding join relationships in a real database
* Detecting missing relationships using `NULL`
* Querying across normalized tables

---

## Author

**Edmond Kipruto**
GitHub: [@ekipruto](https://github.com/ekipruto)

---

*This marks completion of Task 0 — onward to the next challenge!*

---

If you'd like, I can add screenshots, output results, or verification SQL as a separate section.
