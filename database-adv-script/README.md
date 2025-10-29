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

--1. Practice Subqueries

database-adv-script/subqueries.sql
Advanced Querying: Subqueries
This file contains two complex SQL queries designed to demonstrate mastery of subqueries, including both non-correlated and correlated types, as part of the ALX AirBnB Database project.
1. Non-Correlated Subquery: Property Rating Filter
Objective: Retrieve all properties that have a high average rating.
Table(s) Used	Join Type	Key Concept
"Property", "Review"	IN clause	The inner subquery executes once to find a list of property_ids before the outer query runs.
Goal: Find properties where the average rating (AVG(rating) from the "Review" table) is strictly greater than 4.0.
2. Correlated Subquery: High-Volume Users
Objective: Identify users who are frequent bookers on the platform.
Table(s) Used	Join Type	Key Concept
"User", "Booking"	WHERE clause (Correlated)	The inner subquery executes once for every row in the outer query, using the user_id to link the count back to the specific user being evaluated.
Goal: Find users who have made more than 3 bookings by counting associated records in the "Booking" table.
Prerequisites
•	A running PostgreSQL database instance.
•	The AirBnB schema (defined in your schema.sql) must be deployed.
•	Sufficient sample data must be populated in the "User", "Property", "Booking", and "Review" tables to ensure the queries return accurate results.

