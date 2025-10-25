-- =====================================================
-- SEED DATA FOR AIRBNB CLONE DATABASE
-- =====================================================
-- This script populates the database with realistic sample data
-- Run this AFTER creating the schema with schema.sql
-- =====================================================

-- Clear existing data (optional - use with caution)
-- TRUNCATE TABLE "Message", "Review", "Payment", "Booking", "Property", "User" CASCADE;

-- =====================================================
-- 1. SEED USERS (20 users: guests, hosts, and admins)
-- =====================================================

INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
-- Admins (2)
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Admin', 'Smith', 'admin@airbnb.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-0001', 'admin', '2024-01-15 10:00:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Sarah', 'Johnson', 'sarah.admin@airbnb.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-0002', 'admin', '2024-01-20 11:00:00'),

-- Hosts (8)
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Michael', 'Chen', 'michael.chen@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-1001', 'host', '2024-02-01 09:30:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Emily', 'Rodriguez', 'emily.rod@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-1002', 'host', '2024-02-05 14:20:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'James', 'Wilson', 'james.wilson@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-1003', 'host', '2024-02-10 16:45:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Sophia', 'Martinez', 'sophia.m@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-1004', 'host', '2024-02-15 10:15:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'David', 'Lee', 'david.lee@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-1005', 'host', '2024-02-20 13:30:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'Olivia', 'Taylor', 'olivia.t@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-1006', 'host', '2024-02-25 15:00:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'Daniel', 'Brown', 'daniel.brown@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-1007', 'host', '2024-03-01 11:20:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'Isabella', 'Garcia', 'isabella.g@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-1008', 'host', '2024-03-05 09:45:00'),

-- Guests (10)
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'John', 'Doe', 'john.doe@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-2001', 'guest', '2024-03-10 10:00:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'Jane', 'Smith', 'jane.smith@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-2002', 'guest', '2024-03-12 14:30:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'Robert', 'Johnson', 'robert.j@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-2003', 'guest', '2024-03-15 16:00:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'Maria', 'Lopez', 'maria.lopez@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-2004', 'guest', '2024-03-18 11:15:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 'William', 'Anderson', 'william.a@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-2005', 'guest', '2024-03-20 09:30:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a26', 'Emma', 'Thomas', 'emma.thomas@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-2006', 'guest', '2024-03-22 13:45:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a27', 'Alexander', 'White', 'alex.white@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-2007', 'guest', '2024-03-25 15:20:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a28', 'Mia', 'Harris', 'mia.harris@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-2008', 'guest', '2024-03-28 10:40:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a29', 'Ethan', 'Clark', 'ethan.clark@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-2009', 'guest', '2024-04-01 12:00:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a30', 'Ava', 'Lewis', 'ava.lewis@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+1-555-2010', 'guest', '2024-04-05 14:30:00');

-- =====================================================
-- 2. SEED PROPERTIES (15 properties)
-- =====================================================

INSERT INTO "Property" (property_id, host_id, name, description, location, pricepernight, created_at) VALUES
-- Michael Chen's properties
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Luxury Downtown Loft', 'Modern 2-bedroom loft in the heart of downtown with skyline views. Perfect for business travelers and couples.', 'New York, NY', 250.00, '2024-02-02 10:00:00'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Cozy Studio Apartment', 'Charming studio with all amenities in a quiet neighborhood. Great for solo travelers.', 'Brooklyn, NY', 120.00, '2024-02-05 11:30:00'),

-- Emily Rodriguez's properties
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Beachfront Paradise', 'Stunning 3-bedroom beach house with private access to the beach. Ocean views from every room.', 'Miami, FL', 350.00, '2024-02-06 09:15:00'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b14', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Art Deco Condo', 'Beautifully restored 1930s condo in the historic Art Deco district.', 'Miami Beach, FL', 180.00, '2024-02-10 14:20:00'),

-- James Wilson's properties
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b15', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Mountain Retreat Cabin', 'Rustic 4-bedroom cabin with hot tub and fireplace. Perfect for family getaways and skiing trips.', 'Aspen, CO', 400.00, '2024-02-12 08:45:00'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b16', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Ski-In Ski-Out Chalet', 'Luxury chalet with direct access to ski slopes and mountain views.', 'Vail, CO', 500.00, '2024-02-15 10:30:00'),

-- Sophia Martinez's properties
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b17', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Victorian Townhouse', 'Historic 5-bedroom Victorian with original details and modern updates.', 'San Francisco, CA', 320.00, '2024-02-16 13:00:00'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b18', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Bay View Apartment', 'Modern 2-bedroom with stunning views of the Golden Gate Bridge.', 'San Francisco, CA', 280.00, '2024-02-20 15:45:00'),

-- David Lee's properties
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b19', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'Desert Oasis Villa', 'Luxurious 6-bedroom villa with pool, spa, and desert views.', 'Scottsdale, AZ', 450.00, '2024-02-22 11:20:00'),

-- Olivia Taylor's properties
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b20', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'Historic Brownstone', 'Charming 3-bedroom brownstone in trendy neighborhood.', 'Boston, MA', 220.00, '2024-02-25 09:30:00'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b21', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'Waterfront Condo', 'Modern condo with harbor views and rooftop deck access.', 'Boston, MA', 195.00, '2024-03-01 14:15:00'),

-- Daniel Brown's properties
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'Lake House Retreat', '4-bedroom lakefront property with private dock and kayaks.', 'Lake Tahoe, CA', 380.00, '2024-03-03 10:45:00'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b23', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'Cozy A-Frame Cabin', 'Romantic 1-bedroom A-frame with forest views.', 'Lake Tahoe, CA', 160.00, '2024-03-05 16:20:00'),

-- Isabella Garcia's properties
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b24', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'Urban Penthouse', 'Spectacular 3-bedroom penthouse with wraparound terrace.', 'Chicago, IL', 425.00, '2024-03-06 12:00:00'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b25', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'Riverside Loft', 'Industrial-chic 2-bedroom loft with exposed brick and river views.', 'Chicago, IL', 210.00, '2024-03-08 13:30:00');

-- =====================================================
-- 3. SEED BOOKINGS (25 bookings with various statuses)
-- =====================================================

INSERT INTO "Booking" (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
-- Confirmed bookings (past)
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c11', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', '2024-03-15', '2024-03-18', 750.00, 'confirmed', '2024-03-01 10:30:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c12', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', '2024-03-20', '2024-03-27', 2450.00, 'confirmed', '2024-03-05 14:20:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c13', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b15', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', '2024-04-01', '2024-04-05', 1600.00, 'confirmed', '2024-03-10 09:15:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c14', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b17', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', '2024-04-10', '2024-04-14', 1280.00, 'confirmed', '2024-03-15 11:45:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c15', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b19', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', '2024-04-15', '2024-04-20', 2250.00, 'confirmed', '2024-03-20 13:00:00'),

-- Confirmed bookings (upcoming)
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c16', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a26', '2024-11-01', '2024-11-05', 1000.00, 'confirmed', '2024-10-15 10:00:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c17', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a27', '2024-11-10', '2024-11-17', 2450.00, 'confirmed', '2024-10-18 14:30:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c18', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b16', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a28', '2024-12-20', '2024-12-27', 3500.00, 'confirmed', '2024-10-20 16:45:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c19', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b18', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a29', '2024-11-15', '2024-11-18', 840.00, 'confirmed', '2024-10-22 09:20:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c20', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b20', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a30', '2024-11-25', '2024-11-28', 660.00, 'confirmed', '2024-10-25 11:15:00'),

-- Pending bookings
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c21', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', '2024-12-01', '2024-12-05', 1520.00, 'pending', '2024-10-26 08:30:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c22', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b24', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', '2024-12-10', '2024-12-15', 2125.00, 'pending', '2024-10-26 09:45:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c23', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b14', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', '2024-12-05', '2024-12-08', 540.00, 'pending', '2024-10-26 10:20:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c24', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b25', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', '2024-11-20', '2024-11-23', 630.00, 'pending', '2024-10-26 11:00:00'),

-- Canceled bookings
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c25', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', '2024-05-01', '2024-05-03', 240.00, 'canceled', '2024-04-10 15:30:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c26', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b23', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a26', '2024-06-15', '2024-06-18', 480.00, 'canceled', '2024-05-20 12:45:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c27', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b21', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a27', '2024-07-01', '2024-07-04', 585.00, 'canceled', '2024-06-10 14:00:00'),

-- More confirmed bookings for diversity
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c28', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a28', '2024-08-10', '2024-08-15', 600.00, 'confirmed', '2024-07-15 10:30:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c29', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b14', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a29', '2024-08-20', '2024-08-25', 900.00, 'confirmed', '2024-07-20 11:45:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c30', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b23', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a30', '2024-09-01', '2024-09-07', 960.00, 'confirmed', '2024-08-01 09:00:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c31', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b25', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', '2024-09-15', '2024-09-20', 1050.00, 'confirmed', '2024-08-20 13:30:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c32', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b21', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', '2024-10-01', '2024-10-05', 780.00, 'confirmed', '2024-09-10 15:00:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c33', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', '2024-10-10', '2024-10-15', 1900.00, 'confirmed', '2024-09-15 10:20:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c34', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b24', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', '2024-10-20', '2024-10-24', 1700.00, 'confirmed', '2024-09-25 14:45:00');

-- =====================================================
-- 4. SEED PAYMENTS (for confirmed bookings)
-- =====================================================

INSERT INTO "Payment" (payment_id, booking_id, amount, payment_date, payment_method) VALUES
-- Payments for past confirmed bookings
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d11', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c11', 750.00, '2024-03-01 10:45:00', 'credit_card'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d12', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c12', 2450.00, '2024-03-05 14:35:00', 'stripe'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d13', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c13', 1600.00, '2024-03-10 09:30:00', 'paypal'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d14', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c14', 1280.00, '2024-03-15 12:00:00', 'credit_card'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d15', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c15', 2250.00, '2024-03-20 13:15:00', 'stripe'),

-- Payments for upcoming confirmed bookings
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d16', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c16', 1000.00, '2024-10-15 10:15:00', 'credit_card'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d17', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c17', 2450.00, '2024-10-18 14:45:00', 'paypal'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d18', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c18', 3500.00, '2024-10-20 17:00:00', 'stripe'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d19', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c19', 840.00, '2024-10-22 09:35:00', 'credit_card'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d20', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c20', 660.00, '2024-10-25 11:30:00', 'paypal'),

-- Payments for other confirmed bookings
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d21', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c28', 600.00, '2024-07-15 10:45:00', 'credit_card'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d22', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c29', 900.00, '2024-07-20 12:00:00', 'stripe'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d23', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c30', 960.00, '2024-08-01 09:15:00', 'paypal'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d24', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c31', 1050.00, '2024-08-20 13:45:00', 'credit_card'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d25', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c32', 780.00, '2024-09-10 15:15:00', 'stripe'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d26', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c33', 1900.00, '2024-09-15 10:35:00', 'paypal'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d27', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c34', 1700.00, '2024-09-25 15:00:00', 'credit_card');

-- =====================================================
-- 5. SEED REVIEWS (for completed bookings)
-- =====================================================

INSERT INTO "Review" (review_id, property_id, user_id, rating, comment, created_at) VALUES
-- Reviews for Luxury Downtown Loft
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e11', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 5, 'Absolutely stunning loft! The views were incredible and the location was perfect for exploring downtown. Host was very responsive and accommodating.', '2024-03-19 14:30:00'),
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e12', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a26', 4, 'Great place for business travel. Very clean and well-equipped. Only minor issue was some street noise at night, but overall excellent stay.', '2024-11-06 10:15:00'),

-- Reviews for Beachfront Paradise
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e13', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 5, 'Dream vacation home! Waking up to ocean views every morning was magical. The house had everything we needed and more. Highly recommend for families!', '2024-03-28 16:45:00'),

-- Reviews for Mountain Retreat Cabin
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e14', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b15', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 5, 'Perfect mountain getaway! The cabin was cozy, clean, and had amazing amenities. Hot tub under the stars was incredible. Will definitely book again.', '2024-04-06 11:20:00'),

-- Reviews for Victorian Townhouse
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e15', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b17', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 4, 'Beautiful historic property with lots of character. Great location in San Francisco. Only downside was parking was a bit challenging.', '2024-04-15 09:30:00'),

-- Reviews for Desert Oasis Villa
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e16', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b19', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 5, 'Luxury at its finest! The pool area was resort-quality and the house exceeded all expectations. Perfect for large groups and special occasions.', '2024-04-21 15:00:00'),

-- Reviews for Cozy Studio Apartment
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e17', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a28', 4, 'Great value for money! Small but perfectly functional for a solo traveler. Quiet neighborhood and easy access to public transport.', '2024-08-16 12:45:00'),

-- Reviews for Art Deco Condo
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e18', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b14', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a29', 5, 'Absolutely loved the vintage charm combined with modern amenities. Perfect Miami Beach location. Host provided excellent local recommendations.', '2024-08-26 10:00:00'),

-- Reviews for Cozy A-Frame Cabin
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e19', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b23', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a30', 5, 'Romantic and peaceful retreat! The A-frame design is charming and the forest setting is serene. Perfect for couples looking to disconnect.', '2024-09-08 14:20:00'),

-- Reviews for Riverside Loft
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e20', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b25', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 4, 'Cool industrial loft with great views. Very trendy neighborhood with lots of restaurants nearby. Would have given 5 stars but WiFi was spotty.', '2024-09-21 11:30:00'),

-- Reviews for Waterfront Condo
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e21', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b21', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 5, 'Boston harbor views are stunning! Clean, modern condo with everything you need. Rooftop deck was a bonus. Highly recommend!', '2024-10-06 09:45:00'),

-- Reviews for Lake House Retreat
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e22', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 5, 'Amazing lakefront property! Kids loved the kayaks and dock. House was spacious and well-maintained. Perfect family vacation spot.', '2024-10-16 16:00:00'),

-- Reviews for Urban Penthouse
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e23', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b24', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 5, 'Spectacular penthouse with incredible city views! The terrace is perfect for entertaining. This place is worth every penny. Top-tier luxury!', '2024-10-25 13:15:00'),

-- Additional reviews for variety
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e24', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a27', 3, 'Decent place but had some maintenance issues. Hot water was inconsistent and the AC was noisy. Location was good though.', '2024-07-10 15:30:00'),
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e25', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b20', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a30', 4, 'Charming brownstone in a great neighborhood. Loved the historic details. Kitchen could use some updating but overall a pleasant stay.', '2024-06-20 12:00:00');

-- =====================================================
-- 6. SEED MESSAGES (user communication)
-- =====================================================

INSERT INTO "Message" (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
-- Guest inquiries to hosts
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Hi! I am interested in booking your downtown loft for March 15-18. Is it available? Also, do you allow pets?', '2024-02-28 09:00:00'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'Hello! Yes, the loft is available for those dates. Unfortunately, we have a no-pets policy due to allergies. Let me know if you have any other questions!', '2024-02-28 10:30:00'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'No problem! I will proceed with the booking. What is the check-in process?', '2024-02-28 11:15:00'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f14', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'Great! Check-in is at 3 PM. I will send you the door code and parking instructions a day before your arrival. Looking forward to hosting you!', '2024-02-28 12:00:00'),

-- Beach house inquiry
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f15', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Your beach house looks amazing! We are a family of 5. Do you provide beach equipment like chairs and umbrellas?', '2024-03-03 14:20:00'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f16', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'Thank you! Yes, we provide beach chairs, umbrellas, boogie boards, and even beach toys for kids. The garage has everything you need!', '2024-03-03 15:45:00'),

-- Mountain cabin inquiry
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f17', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Hi James! Is your cabin close to the ski slopes? We are planning a ski trip and want easy access.', '2024-03-08 10:00:00'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f18', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'Hello! The cabin is about 15 minutes from the main slopes. I also have a ski-in ski-out chalet if you prefer direct slope access. Check my other listing!', '2024-03-08 11:30:00'),

-- Victorian townhouse inquiry
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f19', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Love the Victorian architecture! Question: is there parking available and is the house accessible for elderly guests?', '2024-03-12 16:00:00'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f20', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'Thank you! There is street parking available. However, please note the house has stairs and is not wheelchair accessible. The main bedroom is on the second floor.', '2024-03-12 17:30:00'),

-- Desert villa inquiry
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f21', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'Hi David! We are planning a group trip (10 people) for a birthday celebration. Can your villa accommodate us?', '2024-03-18 13:00:00'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f22', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 'Absolutely! The villa sleeps up to 12 guests comfortably. Perfect for celebrations! We have a great outdoor space with BBQ and pool. Let me know your dates.', '2024-03-18 14:30:00'),

-- Check-out thank you messages
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f23', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Thank you for the wonderful stay! Everything was perfect. Already left a 5-star review!', '2024-03-18 12:00:00'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f24', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'Thank you for being such a great guest! You are welcome back anytime. Safe travels!', '2024-03-18 13:30:00'),

-- Late inquiry for upcoming booking
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f25', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a26', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Hi! I have a booking starting tomorrow. What time exactly is check-in? Also, is there a grocery store nearby?', '2024-10-31 18:00:00'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f26', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a26', 'Check-in is at 3 PM. I will send door code at 2 PM tomorrow. Yes, there is a Whole Foods 2 blocks away. See you tomorrow!', '2024-10-31 18:45:00'),

-- Special request message
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f27', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a27', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Hi Emily! We are celebrating our anniversary at your beach house. Could you recommend any romantic restaurants nearby?', '2024-11-08 10:30:00'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f28', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a27', 'Congratulations! I highly recommend "The Oceanfront" for fine dining or "Sunset Grill" for a more casual beachside experience. Both have amazing views!', '2024-11-08 12:00:00'),

-- Maintenance issue during stay
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f29', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a28', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Hi James, sorry to bother but the hot tub temperature control seems to not be working. Could you help?', '2024-12-22 16:30:00'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f30', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a28', 'Oh no! I am sending my maintenance person over within the hour. So sorry for the inconvenience. I will comp you one night for the trouble.', '2024-12-22 16:45:00'),

-- Admin communication
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f31', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Hello Michael, congratulations on becoming a Superhost! Your consistent 5-star ratings and quick response times have been noticed. Keep up the great work!', '2024-06-01 09:00:00'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f32', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Thank you so much! I really appreciate the recognition. I love hosting and will continue to provide great experiences for guests.', '2024-06-01 10:30:00');

-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================

-- Count records in each table
SELECT 'Users' AS table_name, COUNT(*) AS record_count FROM "User"
UNION ALL
SELECT 'Properties', COUNT(*) FROM "Property"
UNION ALL
SELECT 'Bookings', COUNT(*) FROM "Booking"
UNION ALL
SELECT 'Payments', COUNT(*) FROM "Payment"
UNION ALL
SELECT 'Reviews', COUNT(*) FROM "Review"
UNION ALL
SELECT 'Messages', COUNT(*) FROM "Message";

-- Show booking status distribution
SELECT status, COUNT(*) AS count
FROM "Booking"
GROUP BY status
ORDER BY count DESC;

-- Show payment methods distribution
SELECT payment_method, COUNT(*) AS count, SUM(amount) AS total_amount
FROM "Payment"
GROUP BY payment_method
ORDER BY count DESC;

-- Show average rating per property
SELECT 
    p.name,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    COUNT(r.review_id) AS review_count
FROM "Property" p
LEFT JOIN "Review" r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name
ORDER BY avg_rating DESC, review_count DESC;

-- =====================================================
-- END OF SEED DATA
-- =====================================================