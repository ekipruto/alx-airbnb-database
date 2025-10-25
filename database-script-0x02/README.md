# Database Seeding Guide - AirBnB Clone

## 📋 Overview

This directory contains SQL scripts to populate the AirBnB Clone database with realistic sample data for testing and development purposes.

---

## 📁 Files

| File | Purpose |
|------|---------|
| `seed.sql` | Complete seeding script with INSERT statements |
| `README.md` | This step-by-step guide |

---

## 🎯 What Gets Seeded

### Data Summary

| Table | Records | Description |
|-------|---------|-------------|
| **User** | 20 | 2 admins, 8 hosts, 10 guests |
| **Property** | 15 | Various property types across USA |
| **Booking** | 25 | Mix of confirmed, pending, and canceled |
| **Payment** | 17 | Payments for confirmed bookings |
| **Review** | 15 | Ratings from 3-5 stars with comments |
| **Message** | 22 | Conversations between guests and hosts |

### Sample Data Characteristics

✅ **Realistic scenarios**: Inquiries, bookings, payments, reviews  
✅ **Diverse locations**: NY, FL, CO, CA, AZ, MA, IL  
✅ **Multiple price points**: $120 - $500 per night  
✅ **Various booking statuses**: Pending, confirmed, canceled  
✅ **Payment methods**: Credit card, PayPal, Stripe  
✅ **Rating distribution**: 3-5 stars with detailed comments

---

## 🚀 Quick Start

### Prerequisites

- ✅ PostgreSQL database created
- ✅ Schema created (run `schema.sql` first)
- ✅ Database connection ready

---

## 📖 Step-by-Step Guide

### Step 1: Verify Schema Exists

Before running seed data, ensure your database schema is created:

```bash
# Connect to your database
psql -U postgres -d airbnb_db

# Check if tables exist
\dt

# Expected output: User, Property, Booking, Payment, Review, Message
```

**If tables don't exist**, run the schema first:
```bash
psql -U postgres -d airbnb_db -f ../database-adv-script/schema.sql
```

---

### Step 2: Run the Seed Script

#### Option 1: Using psql Command Line

```bash
# Navigate to the directory containing seed.sql
cd database-script-0x02

# Run the seed script
psql -U postgres -d airbnb_db -f seed.sql

# Expected output: Multiple INSERT statements executing
```

#### Option 2: Using psql Interactive Mode

```bash
# Connect to database
psql -U postgres -d airbnb_db

# Run seed file
\i seed.sql

# Check results
SELECT COUNT(*) FROM "User";
```

#### Option 3: Using Docker

```bash
# Copy seed file to container
docker cp seed.sql airbnb-postgres:/seed.sql

# Execute seed script
docker exec -it airbnb-postgres psql -U postgres -d airbnb_db -f /seed.sql

# Verify data
docker exec -it airbnb-postgres psql -U postgres -d airbnb_db -c "SELECT COUNT(*) FROM \"User\";"
```

#### Option 4: Using GUI Tools (pgAdmin, DBeaver)

1. Open your database tool
2. Connect to `airbnb_db`
3. Open `seed.sql` file
4. Execute the entire script
5. Verify in the table viewers

---

### Step 3: Verify Data Insertion

Run these queries to confirm data was inserted successfully:

#### Check Record Counts

```sql
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
```

**Expected Output:**
```
 table_name | record_count
------------+--------------
 Users      |           20
 Properties |           15
 Bookings   |           25
 Payments   |           17
 Reviews    |           15
 Messages   |           22
```

#### Sample Data Queries

```sql
-- View all hosts and their properties
SELECT 
    u.first_name || ' ' || u.last_name AS host_name,
    p.name AS property_name,
    p.location,
    p.pricepernight
FROM "User" u
JOIN "Property" p ON u.user_id = p.host_id
ORDER BY u.last_name;

-- View booking status distribution
SELECT status, COUNT(*) AS count
FROM "Booking"
GROUP BY status;

-- View average ratings by property
SELECT 
    p.name,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    COUNT(r.review_id) AS review_count
FROM "Property" p
LEFT JOIN "Review" r ON p.property_id = r.property_id
GROUP BY p.name
ORDER BY avg_rating DESC;

-- View payment method distribution
SELECT 
    payment_method,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_revenue
FROM "Payment"
GROUP BY payment_method;
```

---

### Step 4: Test Relationships

Verify foreign key relationships are working:

```sql
-- Test User -> Property relationship
SELECT 
    u.email AS host_email,
    COUNT(p.property_id) AS property_count
FROM "User" u
LEFT JOIN "Property" p ON u.user_id = p.host_id
WHERE u.role = 'host'
GROUP BY u.user_id, u.email;

-- Test Property -> Booking relationship
SELECT 
    p.name,
    COUNT(b.booking_id) AS total_bookings
FROM "Property" p
LEFT JOIN "Booking" b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY total_bookings DESC;

-- Test Booking -> Payment relationship
SELECT 
    b.booking_id,
    b.status,
    b.total_price AS booking_amount,
    p.amount AS payment_amount,
    p.payment_method
FROM "Booking" b
LEFT JOIN "Payment" p ON b.booking_id = p.booking_id
WHERE b.status = 'confirmed';
```

---

## 📊 Sample Data Details

### Users (20 total)

#### Admins (2)
- `admin@airbnb.com` - Admin Smith
- `sarah.admin@airbnb.com` - Sarah Johnson

#### Hosts (8)
- `michael.chen@example.com` - 2 properties (NYC)
- `emily.rod@example.com` - 2 properties (Miami)
- `james.wilson@example.com` - 2 properties (Colorado)
- `sophia.m@example.com` - 2 properties (San Francisco)
- `david.lee@example.com` - 1 property (Arizona)
- `olivia.t@example.com` - 2 properties (Boston)
- `daniel.brown@example.com` - 2 properties (Lake Tahoe)
- `isabella.g@example.com` - 2 properties (Chicago)

#### Guests (10)
- john.doe@example.com through ava.lewis@example.com

**Password for all users**: `password123` (hashed as `$2a$10$N9q...`)

---

### Properties (15 total)

| Property | Location | Host | Price/Night |
|----------|----------|------|-------------|
| Luxury Downtown Loft | New York, NY | Michael Chen | $250 |
| Cozy Studio Apartment | Brooklyn, NY | Michael Chen | $120 |
| Beachfront Paradise | Miami, FL | Emily Rodriguez | $350 |
| Art Deco Condo | Miami Beach, FL | Emily Rodriguez | $180 |
| Mountain Retreat Cabin | Aspen, CO | James Wilson | $400 |
| Ski-In Ski-Out Chalet | Vail, CO | James Wilson | $500 |
| Victorian Townhouse | San Francisco, CA | Sophia Martinez | $320 |
| Bay View Apartment | San Francisco, CA | Sophia Martinez | $280 |
| Desert Oasis Villa | Scottsdale, AZ | David Lee | $450 |
| Historic Brownstone | Boston, MA | Olivia Taylor | $220 |
| Waterfront Condo | Boston, MA | Olivia Taylor | $195 |
| Lake House Retreat | Lake Tahoe, CA | Daniel Brown | $380 |
| Cozy A-Frame Cabin | Lake Tahoe, CA | Daniel Brown | $160 |
| Urban Penthouse | Chicago, IL | Isabella Garcia | $425 |
| Riverside Loft | Chicago, IL | Isabella Garcia | $210 |

---

### Bookings (25 total)

#### Status Distribution
- **Confirmed**: 17 bookings (past and upcoming)
- **Pending**: 4 bookings (awaiting confirmation)
- **Canceled**: 3 bookings (user cancellations)

#### Date Ranges
- **Past bookings**: March - October 2024
- **Upcoming bookings**: November - December 2024

---

### Payments (17 total)

All confirmed bookings have corresponding payments:

#### Payment Methods
- **Credit Card**: ~35% of payments
- **Stripe**: ~35% of payments
- **PayPal**: ~30% of payments

**Total Revenue**: $27,870.00

---

### Reviews (15 total)

#### Rating Distribution
- **5 stars**: 11 reviews (73%)
- **4 stars**: 3 reviews (20%)
- **3 stars**: 1 review (7%)

**Average Platform Rating**: 4.67/5.00

---

### Messages (22 total)

Message types include:
- Pre-booking inquiries (6 messages)
- Check-in instructions (4 messages)
- Special requests (4 messages)
- Thank you messages (4 messages)
- Maintenance issues (2 messages)
- Admin communications (2 messages)

---

## 🔍 Useful Queries for Testing

### Find Available Properties

```sql
-- Properties with no overlapping bookings for specific dates
SELECT p.*
FROM "Property" p
WHERE p.property_id NOT IN (
    SELECT b.property_id
    FROM "Booking" b
    WHERE b.status = 'confirmed'
    AND (
        ('2024-12-15' BETWEEN b.start_date AND b.end_date)
        OR ('2024-12-20' BETWEEN b.start_date AND b.end_date)
        OR (b.start_date BETWEEN '2024-12-15' AND '2024-12-20')
    )
);
```

### Top Rated Properties

```sql
SELECT 
    p.name,
    p.location,
    p.pricepernight,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    COUNT(r.review_id) AS review_count
FROM "Property" p
JOIN "Review" r ON p.property_id = r.property_id
GROUP BY p.property_id
HAVING COUNT(r.review_id) >= 1
ORDER BY avg_rating DESC, review_count DESC
LIMIT 5;
```

### Host Revenue Report

```sql
SELECT 
    u.first_name || ' ' || u.last_name AS host_name,
    COUNT(DISTINCT p.property_id) AS property_count,
    COUNT(b.booking_id) AS total_bookings,
    SUM(pay.amount) AS total_revenue
FROM "User" u
JOIN "Property" p ON u.user_id = p.host_id
LEFT JOIN "Booking" b ON p.property_id = b.property_id
LEFT JOIN "Payment" pay ON b.booking_id = pay.booking_id
WHERE u.role = 'host'
GROUP BY u.user_id, host_name
ORDER BY total_revenue DESC NULLS LAST;
```

### Guest Booking History

```sql
SELECT 
    u.first_name || ' ' || u.last_name AS guest_name,
    p.name AS property_name,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM "User" u
JOIN "Booking" b ON u.user_id = b.user_id
JOIN "Property" p ON b.property_id = p.property_id
WHERE u.email = 'john.doe@example.com'
ORDER BY b.start_date DESC;
```

### Recent Messages Between Users

```sql
SELECT 
    sender.first_name || ' ' || sender.last_name AS sender,
    recipient.first_name || ' ' || recipient.last_name AS recipient,
    m.message_body,
    m.sent_at
FROM "Message" m
JOIN "User" sender ON m.sender_id = sender.user_id
JOIN "User" recipient ON m.recipient_id = recipient.user_id
ORDER BY m.sent_at DESC
LIMIT 10;
```

---

## 🧹 Reset Database (Clear Seed Data)

If you need to clear the seed data and start fresh:

```sql
-- WARNING: This deletes ALL data from tables
TRUNCATE TABLE "Message", "Review", "Payment", "Booking", "Property", "User" CASCADE;

-- Verify tables are empty
SELECT 'Users' AS table_name, COUNT(*) FROM "User"
UNION ALL
SELECT 'Properties', COUNT(*) FROM "Property"
UNION ALL
SELECT 'Bookings', COUNT(*) FROM "Booking";
```

Then re-run the seed script.

---

## 🚧 Troubleshooting

### Error: "duplicate key value violates unique constraint"

**Problem**: Data already exists in the database.

**Solution**: Clear existing data first:
```sql
TRUNCATE TABLE "Message", "Review", "Payment", "Booking", "Property", "User" CASCADE;
```

---

### Error: "relation does not exist"

**Problem**: Schema hasn't been created yet.

**Solution**: Run the schema.sql file first:
```bash
psql -U postgres -d airbnb_db -f ../database-adv-script/schema.sql
```

---

### Error: "insert or update on table violates foreign key constraint"

**Problem**: Foreign key references don't exist.

**Solution**: Ensure you run the ENTIRE seed.sql file in order. The script inserts data in the correct sequence:
1. Users (no dependencies)
2. Properties (depends on Users)
3. Bookings (depends on Properties and Users)
4. Payments (depends on Bookings)
5. Reviews (depends on Properties and Users)
6. Messages (depends on Users)

---

### Error: "permission denied for table"

**Problem**: Insufficient database privileges.

**Solution**: Connect as superuser or grant privileges:
```sql
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO your_username;
```

---

## 📈 Performance Notes

- **Execution time**: ~500ms for full seed script
- **Total inserted records**: 114 rows across 6 tables
- **Indexes**: All automatically maintained during INSERT
- **Foreign keys**: All validated during insertion

---

## 🔐 Security Notes

⚠️ **Important**: This is sample data for development/testing only!

- All passwords are hashed using bcrypt
- Sample password for all users: `password123`
- **Never use this seed data in production**
- UUIDs are hardcoded for consistency in testing

---

## 📚 Next Steps

After seeding the database:

1. ✅ **Test queries** - Run the sample queries above
2. ✅ **Verify relationships** - Check foreign key constraints
3. ✅ **Test your application** - Connect your app to the database
4. ⏭️ **Create additional queries** - Practice JOIN operations
5. ⏭️ **Build API endpoints** - Use this data for backend testing
6. ⏭️ **Create indexes** - Optimize query performance (if not already done)

---

## 📖 Related Documentation

- [Schema Documentation](../database-adv-script/README.md)
- [PostgreSQL INSERT Syntax](https://www.postgresql.org/docs/current/sql-insert.html)
- [Foreign Keys](https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-FK)

---

## 👨‍💻 Author

**Your Name**  
GitHub: [@ekipruto](https://github.com/ekipruto)  
Email: bikpruto141@gmail.com

---

## 📄 License

This project is part of the ALX Software Engineering curriculum.

---

## 📝 Change Log

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | Oct 26, 2025 | Initial seed data creation |

---

**Happy Testing! 🚀**