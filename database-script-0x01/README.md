# Database Schema (DDL) - AirBnB Clone

## 📋 Overview

This directory contains the **Data Definition Language (DDL)** scripts for creating the AirBnB Clone database schema, including all tables, constraints, indexes, and relationships.

---

## 📁 Files

| File | Purpose |
|------|---------|
| `schema.sql` | Complete database schema with CREATE TABLE statements |
| `README.md` | This documentation file |

---

## 🎯 Objective

Create a complete, production-ready database schema that:
- Defines all 6 entities (User, Property, Booking, Payment, Review, Message)
- Implements proper data types and constraints
- Establishes foreign key relationships
- Creates performance-optimized indexes
- Ensures data integrity through validation

---

## 📊 Database Schema Summary

### Tables Created: 6

1. **User** - Platform users (guests, hosts, admins)
2. **Property** - Rental property listings
3. **Booking** - Property reservations
4. **Payment** - Payment transactions
5. **Review** - Property reviews and ratings
6. **Message** - User-to-user communication

### Key Features:

- ✅ **Primary Keys**: UUID with auto-generation
- ✅ **Foreign Keys**: 8 relationships with CASCADE rules
- ✅ **Constraints**: 15+ validation checks
- ✅ **Indexes**: 20+ for optimal query performance
- ✅ **Triggers**: Auto-update timestamps
- ✅ **Comments**: Inline documentation

---

## 🚀 Quick Start

### Prerequisites

- PostgreSQL 12 or higher
- Database admin access
- psql command-line tool or GUI client (pgAdmin, DBeaver)

### Installation Steps

#### Option 1: Using psql (Command Line)

```bash
# Step 1: Create database
createdb airbnb_db

# Step 2: Run schema script
psql airbnb_db < schema.sql

# Step 3: Verify installation
psql airbnb_db -c "\dt"
```

#### Option 2: Using psql Interactive Mode

```bash
# Step 1: Connect to PostgreSQL
psql -U postgres

# Step 2: Create database
CREATE DATABASE airbnb_db;

# Step 3: Connect to database
\c airbnb_db

# Step 4: Run schema file
\i schema.sql

# Step 5: Verify tables
\dt

# Step 6: View table structure
\d "User"
```

#### Option 3: Using Docker

```bash
# Step 1: Start PostgreSQL container
docker run --name airbnb-postgres \
  -e POSTGRES_PASSWORD=mysecretpassword \
  -e POSTGRES_DB=airbnb_db \
  -p 5432:5432 \
  -d postgres:14

# Step 2: Copy schema file to container
docker cp schema.sql airbnb-postgres:/schema.sql

# Step 3: Execute schema
docker exec -it airbnb-postgres psql -U postgres -d airbnb_db -f /schema.sql
```

---

## 📋 Schema Details

### Table: USER

**Purpose**: Stores all platform users

```sql
Columns:
  - user_id (UUID, PRIMARY KEY)
  - first_name (VARCHAR(100), NOT NULL)
  - last_name (VARCHAR(100), NOT NULL)
  - email (VARCHAR(255), UNIQUE, NOT NULL)
  - password_hash (VARCHAR(255), NOT NULL)
  - phone_number (VARCHAR(20))
  - role (VARCHAR(10), NOT NULL, DEFAULT 'guest')
  - created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

Constraints:
  - CHECK: role IN ('guest', 'host', 'admin')
  - CHECK: email format validation

Indexes:
  - idx_user_email (email)
  - idx_user_role (role)
  - idx_user_created_at (created_at)
```

---

### Table: PROPERTY

**Purpose**: Rental property listings

```sql
Columns:
  - property_id (UUID, PRIMARY KEY)
  - host_id (UUID, FOREIGN KEY → User.user_id)
  - name (VARCHAR(200), NOT NULL)
  - description (TEXT, NOT NULL)
  - location (VARCHAR(255), NOT NULL)
  - pricepernight (DECIMAL(10,2), NOT NULL)
  - created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
  - updated_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

Constraints:
  - FOREIGN KEY: host_id → User(user_id) CASCADE
  - CHECK: pricepernight > 0
  - CHECK: name length >= 3

Indexes:
  - idx_property_host (host_id)
  - idx_property_location (location)
  - idx_property_price (pricepernight)
  - idx_property_created_at (created_at DESC)

Triggers:
  - Auto-update updated_at on modification
```

---

### Table: BOOKING

**Purpose**: Property reservations

```sql
Columns:
  - booking_id (UUID, PRIMARY KEY)
  - property_id (UUID, FOREIGN KEY → Property.property_id)
  - user_id (UUID, FOREIGN KEY → User.user_id)
  - start_date (DATE, NOT NULL)
  - end_date (DATE, NOT NULL)
  - total_price (DECIMAL(10,2), NOT NULL)
  - status (VARCHAR(20), NOT NULL, DEFAULT 'pending')
  - created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

Constraints:
  - FOREIGN KEY: property_id → Property(property_id) CASCADE
  - FOREIGN KEY: user_id → User(user_id) CASCADE
  - CHECK: end_date > start_date
  - CHECK: status IN ('pending', 'confirmed', 'canceled')
  - CHECK: total_price >= 0

Indexes:
  - idx_booking_property (property_id)
  - idx_booking_user (user_id)
  - idx_booking_status (status)
  - idx_booking_dates (start_date, end_date)
  - idx_booking_property_dates (property_id, start_date, end_date)
```

---

### Table: PAYMENT

**Purpose**: Payment transactions

```sql
Columns:
  - payment_id (UUID, PRIMARY KEY)
  - booking_id (UUID, FOREIGN KEY → Booking.booking_id)
  - amount (DECIMAL(10,2), NOT NULL)
  - payment_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
  - payment_method (VARCHAR(20), NOT NULL)

Constraints:
  - FOREIGN KEY: booking_id → Booking(booking_id) CASCADE
  - CHECK: amount > 0
  - CHECK: payment_method IN ('credit_card', 'paypal', 'stripe')

Indexes:
  - idx_payment_booking (booking_id)
  - idx_payment_date (payment_date DESC)
  - idx_payment_method (payment_method)
```

---

### Table: REVIEW

**Purpose**: Property reviews and ratings

```sql
Columns:
  - review_id (UUID, PRIMARY KEY)
  - property_id (UUID, FOREIGN KEY → Property.property_id)
  - user_id (UUID, FOREIGN KEY → User.user_id)
  - rating (INTEGER, NOT NULL)
  - comment (TEXT, NOT NULL)
  - created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

Constraints:
  - FOREIGN KEY: property_id → Property(property_id) CASCADE
  - FOREIGN KEY: user_id → User(user_id) CASCADE
  - CHECK: rating BETWEEN 1 AND 5
  - CHECK: comment length >= 10

Indexes:
  - idx_review_property (property_id)
  - idx_review_user (user_id)
  - idx_review_rating (rating)
  - idx_review_property_rating (property_id, rating)
```

---

### Table: MESSAGE

**Purpose**: User communication

```sql
Columns:
  - message_id (UUID, PRIMARY KEY)
  - sender_id (UUID, FOREIGN KEY → User.user_id)
  - recipient_id (UUID, FOREIGN KEY → User.user_id)
  - message_body (TEXT, NOT NULL)
  - sent_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

Constraints:
  - FOREIGN KEY: sender_id → User(user_id) CASCADE
  - FOREIGN KEY: recipient_id → User(user_id) CASCADE
  - CHECK: sender_id != recipient_id

Indexes:
  - idx_message_sender (sender_id)
  - idx_message_recipient (recipient_id)
  - idx_message_conversation (sender_id, recipient_id, sent_at DESC)
```

---

## 🔍 Verification Queries

### Check All Tables

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public'
ORDER BY table_name;
```

### View Foreign Keys

```sql
SELECT
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS foreign_table,
    ccu.column_name AS foreign_column
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage ccu
    ON tc.constraint_name = ccu.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
ORDER BY tc.table_name;
```

### View All Indexes

```sql
SELECT
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;
```

### Check Constraints

```sql
SELECT
    tc.table_name,
    tc.constraint_name,
    cc.check_clause
FROM information_schema.table_constraints tc
JOIN information_schema.check_constraints cc
    ON tc.constraint_name = cc.constraint_name
WHERE tc.constraint_type = 'CHECK'
ORDER BY tc.table_name;
```

---

## 🧪 Testing the Schema

### Test Data Insertion

```sql
-- Insert test user
INSERT INTO "User" (first_name, last_name, email, password_hash, role)
VALUES ('John', 'Doe', 'john@example.com', '$2a$10$...hashed...', 'host');

-- Verify insertion
SELECT * FROM "User" WHERE email = 'john@example.com';

-- Insert test property
INSERT INTO "Property" (host_id, name, description, location, pricepernight)
VALUES (
    (SELECT user_id FROM "User" WHERE email = 'john@example.com'),
    'Cozy Beach House',
    'Beautiful beachfront property',
    'Miami, FL',
    150.00
);

-- Verify foreign key relationship
SELECT 
    p.name,
    u.first_name || ' ' || u.last_name AS host_name
FROM "Property" p
JOIN "User" u ON p.host_id = u.user_id;
```

---

## 📊 Index Performance

### Purpose of Each Index

| Index | Purpose | Query Benefit |
|-------|---------|---------------|
| `idx_user_email` | Login queries | Fast user authentication |
| `idx_property_location` | Location search | Efficient property filtering |
| `idx_booking_dates` | Availability check | Quick date range queries |
| `idx_review_property` | Property reviews | Fast review aggregation |
| `idx_message_conversation` | Chat history | Efficient conversation loading |

---

## 🔐 Security Features

1. **Password Hashing**: password_hash column (never store plain text)
2. **Email Validation**: CHECK constraint on email format
3. **Cascade Delete**: Prevents orphaned records
4. **Role Validation**: CHECK constraint on user roles
5. **Data Type Enforcement**: Proper column types prevent injection

---

## 🚧 Troubleshooting

### Error: "extension uuid-ossp does not exist"

```sql
-- Solution: Enable extension as superuser
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```

### Error: "relation does not exist"

```bash
# Solution: Ensure you're in correct database
psql -l  # List all databases
\c airbnb_db  # Connect to correct database
```

### Error: "permission denied"

```bash
# Solution: Run as postgres user
sudo -u postgres psql airbnb_db < schema.sql
```

### Reset Database

```sql
-- Drop all tables (careful!)
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;

-- Then re-run schema.sql
```

---

## 📈 Performance Tips

1. **Use EXPLAIN ANALYZE** to check query performance
2. **Monitor index usage** with pg_stat_user_indexes
3. **Vacuum regularly** to maintain performance
4. **Consider partitioning** Booking table by date for large datasets
5. **Use connection pooling** (PgBouncer) for production

---

## 🔄 Next Steps

After running this schema:

1. ✅ Verify all tables created
2. ✅ Test foreign key relationships
3. ✅ Insert sample data
4. ⏭️ Create database queries (SELECT, JOIN, etc.)
5. ⏭️ Implement application logic
6. ⏭️ Set up backups and monitoring

---

## 📚 Resources

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [UUID Best Practices](https://www.postgresql.org/docs/current/uuid-ossp.html)
- [Index Types](https://www.postgresql.org/docs/current/indexes-types.html)
- [Constraint Documentation](https://www.postgresql.org/docs/current/ddl-constraints.html)

---

## 📝 Change Log

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | Oct 25, 2025 | Initial schema creation |

---

## 👨‍💻 Author

**Your Name**  
GitHub: [@ekipruto](https://github.com/ekipruto)  
Email: bikpruto141@gmail.com

---

## 📄 License

This project is part of the ALX Software Engineering curriculum.