-- Initial Query: Retrieve all bookings with user, property, and payment details
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    u.user_id,
    u.name AS user_name,
    u.email,
    p.property_id,
    p.title AS property_title,
    p.location,
    pm.payment_id,
    pm.amount,
    pm.payment_date,
    pm.status
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
JOIN 
    payments pm ON b.booking_id = pm.booking_id;

-- Refactored Query: Optimized to reduce unnecessary columns, leverage indexes, and include multiple conditions
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    u.name AS user_name,
    p.title AS property_title,
    pm.amount,
    pm.status
FROM 
    bookings b
INNER JOIN 
    users u ON b.user_id = u.user_id
INNER JOIN 
    properties p ON b.property_id = p.property_id
INNER JOIN 
    payments pm ON b.booking_id = pm.booking_id
WHERE 
    b.check_in_date >= '2025-01-01' 
    AND pm.status = 'completed'
ORDER BY 
    b.check_in_date;

-- Performance Analysis:
-- Initial Query:
-- - Uses INNER JOINs to combine bookings, users, properties, and payments tables.
-- - Retrieves all columns, which may include unnecessary data, increasing I/O.
-- - No filtering (WHERE clause) or sorting (ORDER BY), leading to a full table scan if no indexes are used.
-- - EXPLAIN ANALYZE may show sequential scans on bookings, users, properties, and payments if indexes are not leveraged.
-- - Performance depends on table sizes; large datasets may result in high execution times.
--
-- Refactored Query:
-- - Reduces columns to only those needed (booking_id, check_in_date, check_out_date, user_name, property_title, amount, status).
-- - Adds WHERE clause with two conditions (check_in_date >= '2025-01-01' AND pm.status = 'completed') to filter results.
-- - Uses ORDER BY check_in_date for sorted output.
-- - Leverages indexes (e.g., idx_bookings_user_id, idx_bookings_property_id, idx_payments_booking_id from database_index.sql).
-- - If an index on bookings.check_in_date exists, it can optimize the WHERE clause; otherwise, consider adding CREATE INDEX idx_bookings_check_in_date ON bookings(check_in_date).
-- - An index on payments.status could further optimize the pm.status = 'completed' condition; consider adding CREATE INDEX idx_payments_status ON payments(status).
-- - EXPLAIN ANALYZE is expected to show index scans (e.g., on idx_bookings_user_id, idx_bookings_property_id, idx_payments_booking_id) and possibly a sort operation for ORDER BY.
-- - The refactored query should have lower execution time due to filtering and reduced column retrieval, especially with large datasets.
