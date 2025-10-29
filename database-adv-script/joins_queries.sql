-- Query 1: INNER JOIN - Bookings with Users
-- Requirement: Retrieve all bookings and the respective users who made those bookings
-- SQL Query:
select 
b.booking_id,
b.start_date,
b.end_date,
b.total_price,
b.status,
u.user_id,
u.first_name ||''|| u.last_name AS "Guest Name",
u.email
from "Booking" b
INNER JOIN "User" u on b.user_id=u.user_id;

-- a query using aLEFT JOIN to retrieve all properties and their reviews, including properties 
-- that have no reviews.
-- select
p.property_id,
p.name as property_name,
p.location,
p.pricepernight,
r.review_id,
r.rating,
r.comment,
u.first_name || ''|| u.last_name as "Reviewer Name"
from "Property" p
left join "Review" r on p.property_id=r.property_id
left join "User" u on r.user_id=u.user_id;

-- Query 3: FULL OUTER JOIN - Users and Bookings
-- Requirement: Retrieve all users and all bookings, even if the user has no booking or a 
-- booking is not linked to a user
select 
u.user_id,
u.first_name,
u.last_name,
u.role,
u.email,
b.booking_id,
b.start_date,
b.end_date,
total_price,
b.status
from "User" u
FULL OUTER JOIN "Booking"b on u.user_id=b.user_id;