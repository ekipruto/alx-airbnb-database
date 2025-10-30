-- INDEXES FOR AIRBNB CLONE SCHEMA
-- File: database_index.sql
-- 1. Index for Property Search Optimization
-- Improves queries searching by both location and price, which is a common search pattern.
CREATE INDEX idx_property_location_price ON "Property" (location, pricepernight);

-- 2. Index for Booking Availability and Conflict Checks
-- Essential for checking property availability in a date range.
CREATE INDEX idx_booking_dates_property ON "Booking" (property_id, start_date, end_date);

-- 3. Index for Fast Review Aggregation
-- Improves performance for calculating average ratings, especially when filtering by rating range.
CREATE INDEX idx_review_property_rating_agg ON "Review" (property_id, rating);

-- 4. Index for User Filtering (if not already covered by the unique index on email)
CREATE INDEX idx_user_last_name ON "User" (last_name);

-- 5. Index for Property Filtering by Host
-- Useful for hosts viewing their own properties, sorted by creation date.
CREATE INDEX idx_property_host_created ON "Property" (host_id, created_at DESC);

-- Note: Indexes on Foreign Key columns (user_id, property_id) are usually automatically
-- created by PostgreSQL when the FK constraint is defined.These new indexes focus on common multi-column searches.