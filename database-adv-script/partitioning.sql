-- ====================================================
--  PARTITIONING IMPLEMENTATION FOR BOOKING TABLE
-- ====================================================

-- Enable UUID extension (for unique IDs)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1️⃣ Create parent partitioned table
CREATE TABLE booking_partitioned (
    booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price NUMERIC(10, 2),
    status VARCHAR(20)
)
PARTITION BY RANGE (start_date);

-- 2️⃣ Create yearly partitions
CREATE TABLE booking_2023 PARTITION OF booking_partitioned
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE booking_2024 PARTITION OF booking_partitioned
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE booking_2025 PARTITION OF booking_partitioned
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- 3️⃣ Insert sample data
INSERT INTO booking_partitioned (property_id, user_id, start_date, end_date, total_price, status)
VALUES
-- 2023 sample
(uuid_generate_v4(), uuid_generate_v4(), '2023-03-15', '2023-03-18', 150.00, 'confirmed'),
(uuid_generate_v4(), uuid_generate_v4(), '2023-06-10', '2023-06-12', 220.00, 'cancelled'),
(uuid_generate_v4(), uuid_generate_v4(), '2023-11-05', '2023-11-07', 300.00, 'confirmed'),

-- 2024 sample
(uuid_generate_v4(), uuid_generate_v4(), '2024-02-01', '2024-02-03', 280.00, 'pending'),
(uuid_generate_v4(), uuid_generate_v4(), '2024-07-14', '2024-07-17', 450.00, 'confirmed'),
(uuid_generate_v4(), uuid_generate_v4(), '2024-10-20', '2024-10-23', 500.00, 'cancelled'),

-- 2025 sample
(uuid_generate_v4(), uuid_generate_v4(), '2025-01-10', '2025-01-12', 180.00, 'confirmed'),
(uuid_generate_v4(), uuid_generate_v4(), '2025-04-25', '2025-04-28', 600.00, 'pending'),
(uuid_generate_v4(), uuid_generate_v4(), '2025-09-15', '2025-09-20', 750.00, 'confirmed');

-- 4️⃣ Test queries
-- Fetch bookings between 2024-01-01 and 2024-10-30
SELECT * FROM booking_partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-10-30';

-- Count records per partition
SELECT '2023' AS partition_year, COUNT(*) FROM booking_2023
UNION ALL
SELECT '2024' AS partition_year, COUNT(*) FROM booking_2024
UNION ALL
SELECT '2025' AS partition_year, COUNT(*) FROM booking_2025;
