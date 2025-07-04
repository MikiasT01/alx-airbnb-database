-- Step 1: Create the parent table for bookings (no data, just structure)
CREATE TABLE bookings (
    booking_id SERIAL,
    user_id INT REFERENCES users(user_id),
    property_id INT REFERENCES properties(property_id),
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    CHECK (check_out_date > check_in_date)
) PARTITION BY RANGE (check_in_date);

-- Step 2: Create partitions for bookings by year (2024, 2025, 2026)
CREATE TABLE bookings_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE bookings_2026 PARTITION OF bookings
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

-- Step 3: Create primary key and indexes on partitions
ALTER TABLE bookings_2024 ADD PRIMARY KEY (booking_id);
ALTER TABLE bookings_2025 ADD PRIMARY KEY (booking_id);
ALTER TABLE bookings_2026 ADD PRIMARY KEY (booking_id);

CREATE INDEX idx_bookings_2024_user_id ON bookings_2024(user_id);
CREATE INDEX idx_bookings_2025_user_id ON bookings_2025(user_id);
CREATE INDEX idx_bookings_2026_user_id ON bookings_2026(user_id);

CREATE INDEX idx_bookings_2024_property_id ON bookings_2024(property_id);
CREATE INDEX idx_bookings_2025_property_id ON bookings_2025(property_id);
CREATE INDEX idx_bookings_2026_property_id ON bookings_2026(property_id);

CREATE INDEX idx_bookings_2024_check_in_date ON bookings_2024(check_in_date);
CREATE INDEX idx_bookings_2025_check_in_date ON bookings_2025(check_in_date);
CREATE INDEX idx_bookings_2026_check_in_date ON bookings_2026(check_in_date);

-- Step 4: Migrate existing data from the original bookings table (if it exists)
-- Note: Run this only if the original bookings table has data
INSERT INTO bookings (booking_id, user_id, property_id, check_in_date, check_out_date)
SELECT booking_id, user_id, property_id, check_in_date, check_out_date
FROM bookings_old;

-- Step 5: Drop the original bookings table (if it exists) after migration
-- DROP TABLE bookings_old;