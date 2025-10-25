-- =====================================================
-- AIRBNB CLONE DATABASE SCHEMA
-- =====================================================
-- Database: PostgreSQL 12+
-- Author: [Your Name]
-- Date: October 25, 2025
-- Description: Complete database schema for AirBnB Clone project
-- =====================================================

-- Enable UUID extension for PostgreSQL
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =====================================================
-- DROP TABLES (for clean reinstall)
-- =====================================================
DROP TABLE IF EXISTS "Message" CASCADE;
DROP TABLE IF EXISTS "Review" CASCADE;
DROP TABLE IF EXISTS "Payment" CASCADE;
DROP TABLE IF EXISTS "Booking" CASCADE;
DROP TABLE IF EXISTS "Property" CASCADE;
DROP TABLE IF EXISTS "User" CASCADE;

-- =====================================================
-- TABLE 1: USER
-- Purpose: Stores all platform users (guests, hosts, admins)
-- =====================================================
CREATE TABLE "User" (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(10) NOT NULL DEFAULT 'guest',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT check_user_role CHECK (role IN ('guest', 'host', 'admin')),
    CONSTRAINT check_email_format CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

-- Indexes for User table
CREATE INDEX idx_user_email ON "User"(email);
CREATE INDEX idx_user_role ON "User"(role);
CREATE INDEX idx_user_created_at ON "User"(created_at);

-- Comments for documentation
COMMENT ON TABLE "User" IS 'Stores all platform users including guests, hosts, and administrators';
COMMENT ON COLUMN "User".user_id IS 'Primary key, unique identifier for each user';
COMMENT ON COLUMN "User".email IS 'User email address, must be unique and valid format';
COMMENT ON COLUMN "User".password_hash IS 'Hashed password using bcrypt or similar';
COMMENT ON COLUMN "User".role IS 'User role: guest (default), host, or admin';

-- =====================================================
-- TABLE 2: PROPERTY
-- Purpose: Stores rental property listings
-- =====================================================
CREATE TABLE "Property" (
    property_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_id UUID NOT NULL,
    name VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_property_host 
        FOREIGN KEY (host_id) 
        REFERENCES "User"(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Data Validation Constraints
    CONSTRAINT check_price_positive CHECK (pricepernight > 0),
    CONSTRAINT check_name_length CHECK (LENGTH(name) >= 3)
);

-- Indexes for Property table
CREATE INDEX idx_property_host ON "Property"(host_id);
CREATE INDEX idx_property_location ON "Property"(location);
CREATE INDEX idx_property_price ON "Property"(pricepernight);
CREATE INDEX idx_property_created_at ON "Property"(created_at DESC);

-- Trigger to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_property_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER property_update_trigger
    BEFORE UPDATE ON "Property"
    FOR EACH ROW
    EXECUTE FUNCTION update_property_timestamp();

-- Comments
COMMENT ON TABLE "Property" IS 'Stores rental property listings created by hosts';
COMMENT ON COLUMN "Property".property_id IS 'Primary key, unique identifier for each property';
COMMENT ON COLUMN "Property".host_id IS 'Foreign key referencing the property owner (User table)';
COMMENT ON COLUMN "Property".pricepernight IS 'Nightly rental rate, must be positive';

-- =====================================================
-- TABLE 3: BOOKING
-- Purpose: Records property reservations
-- =====================================================
CREATE TABLE "Booking" (
    booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_booking_property 
        FOREIGN KEY (property_id) 
        REFERENCES "Property"(property_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_booking_user 
        FOREIGN KEY (user_id) 
        REFERENCES "User"(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Data Validation Constraints
    CONSTRAINT check_booking_dates CHECK (end_date > start_date),
    CONSTRAINT check_booking_status CHECK (status IN ('pending', 'confirmed', 'canceled')),
    CONSTRAINT check_total_price_positive CHECK (total_price >= 0)
);

-- Indexes for Booking table
CREATE INDEX idx_booking_property ON "Booking"(property_id);
CREATE INDEX idx_booking_user ON "Booking"(user_id);
CREATE INDEX idx_booking_status ON "Booking"(status);
CREATE INDEX idx_booking_dates ON "Booking"(start_date, end_date);
CREATE INDEX idx_booking_created_at ON "Booking"(created_at DESC);

-- Composite index for checking availability
CREATE INDEX idx_booking_property_dates ON "Booking"(property_id, start_date, end_date);

-- Comments
COMMENT ON TABLE "Booking" IS 'Stores property booking reservations made by guests';
COMMENT ON COLUMN "Booking".booking_id IS 'Primary key, unique identifier for each booking';
COMMENT ON COLUMN "Booking".status IS 'Booking status: pending, confirmed, or canceled';
COMMENT ON COLUMN "Booking".total_price IS 'Total cost calculated as (end_date - start_date) * pricepernight';

-- =====================================================
-- TABLE 4: PAYMENT
-- Purpose: Tracks payment transactions
-- =====================================================
CREATE TABLE "Payment" (
    payment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20) NOT NULL,
    
    -- Foreign Key Constraint
    CONSTRAINT fk_payment_booking 
        FOREIGN KEY (booking_id) 
        REFERENCES "Booking"(booking_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Data Validation Constraints
    CONSTRAINT check_payment_amount_positive CHECK (amount > 0),
    CONSTRAINT check_payment_method CHECK (payment_method IN ('credit_card', 'paypal', 'stripe'))
);

-- Indexes for Payment table
CREATE INDEX idx_payment_booking ON "Payment"(booking_id);
CREATE INDEX idx_payment_date ON "Payment"(payment_date DESC);
CREATE INDEX idx_payment_method ON "Payment"(payment_method);

-- Comments
COMMENT ON TABLE "Payment" IS 'Stores payment transaction records for bookings';
COMMENT ON COLUMN "Payment".payment_id IS 'Primary key, unique identifier for each payment';
COMMENT ON COLUMN "Payment".booking_id IS 'Foreign key linking payment to booking';
COMMENT ON COLUMN "Payment".payment_method IS 'Payment method: credit_card, paypal, or stripe';

-- =====================================================
-- TABLE 5: REVIEW
-- Purpose: Stores guest reviews for properties
-- =====================================================
CREATE TABLE "Review" (
    review_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_review_property 
        FOREIGN KEY (property_id) 
        REFERENCES "Property"(property_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_review_user 
        FOREIGN KEY (user_id) 
        REFERENCES "User"(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Data Validation Constraints
    CONSTRAINT check_rating_range CHECK (rating >= 1 AND rating <= 5),
    CONSTRAINT check_comment_length CHECK (LENGTH(comment) >= 10)
);

-- Indexes for Review table
CREATE INDEX idx_review_property ON "Review"(property_id);
CREATE INDEX idx_review_user ON "Review"(user_id);
CREATE INDEX idx_review_rating ON "Review"(rating);
CREATE INDEX idx_review_created_at ON "Review"(created_at DESC);

-- Composite index for property average rating queries
CREATE INDEX idx_review_property_rating ON "Review"(property_id, rating);

-- Comments
COMMENT ON TABLE "Review" IS 'Stores guest reviews and ratings for properties';
COMMENT ON COLUMN "Review".review_id IS 'Primary key, unique identifier for each review';
COMMENT ON COLUMN "Review".rating IS 'Star rating between 1 and 5';
COMMENT ON COLUMN "Review".comment IS 'Review text, minimum 10 characters';

-- =====================================================
-- TABLE 6: MESSAGE
-- Purpose: Facilitates user-to-user communication
-- =====================================================
CREATE TABLE "Message" (
    message_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_message_sender 
        FOREIGN KEY (sender_id) 
        REFERENCES "User"(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_message_recipient 
        FOREIGN KEY (recipient_id) 
        REFERENCES "User"(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Data Validation Constraints
    CONSTRAINT check_message_users CHECK (sender_id != recipient_id),
    CONSTRAINT check_message_body_length CHECK (LENGTH(message_body) >= 1)
);

-- Indexes for Message table
CREATE INDEX idx_message_sender ON "Message"(sender_id);
CREATE INDEX idx_message_recipient ON "Message"(recipient_id);
CREATE INDEX idx_message_sent_at ON "Message"(sent_at DESC);

-- Composite index for conversation threads
CREATE INDEX idx_message_conversation ON "Message"(sender_id, recipient_id, sent_at DESC);

-- Comments
COMMENT ON TABLE "Message" IS 'Stores messages exchanged between users';
COMMENT ON COLUMN "Message".message_id IS 'Primary key, unique identifier for each message';
COMMENT ON COLUMN "Message".sender_id IS 'Foreign key referencing the message sender';
COMMENT ON COLUMN "Message".recipient_id IS 'Foreign key referencing the message recipient';

-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================

-- View all tables
SELECT 
    table_name,
    table_type
FROM information_schema.tables 
WHERE table_schema = 'public' 
    AND table_name IN ('User', 'Property', 'Booking', 'Payment', 'Review', 'Message')
ORDER BY table_name;

-- View all indexes
SELECT
    schemaname,
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;

-- View all foreign key constraints
SELECT
    tc.table_name,
    tc.constraint_name,
    tc.constraint_type,
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu
    ON ccu.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
    AND tc.table_schema = 'public'
ORDER BY tc.table_name, tc.constraint_name;

-- View all check constraints
SELECT
    tc.table_name,
    tc.constraint_name,
    cc.check_clause
FROM information_schema.table_constraints AS tc
JOIN information_schema.check_constraints AS cc
    ON tc.constraint_name = cc.constraint_name
WHERE tc.constraint_type = 'CHECK'
    AND tc.table_schema = 'public'
ORDER BY tc.table_name, tc.constraint_name;

-- =====================================================
-- COMPLETION MESSAGE
-- =====================================================
DO $$ 
BEGIN
    RAISE NOTICE '========================================';
    RAISE NOTICE 'AirBnB Database Schema Created Successfully!';
    RAISE NOTICE '========================================';
    RAISE NOTICE 'Tables created: 6';
    RAISE NOTICE '  - User';
    RAISE NOTICE '  - Property';
    RAISE NOTICE '  - Booking';
    RAISE NOTICE '  - Payment';
    RAISE NOTICE '  - Review';
    RAISE NOTICE '  - Message';
    RAISE NOTICE '';
    RAISE NOTICE 'Foreign Keys: 8';
    RAISE NOTICE 'Indexes: 20+';
    RAISE NOTICE 'Constraints: 15+';
    RAISE NOTICE '';
    RAISE NOTICE 'Next steps:';
    RAISE NOTICE '1. Verify tables: SELECT * FROM information_schema.tables;';
    RAISE NOTICE '2. Insert sample data';
    RAISE NOTICE '3. Test queries';
    RAISE NOTICE '========================================';
END $$;