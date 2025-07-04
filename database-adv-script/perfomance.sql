-- Initial Query: Retrieve all bookings with user, property, and payment details
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

-- Refactored Query: Optimized to reduce unnecessary columns and leverage indexes
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
ORDER BY 
    b.check_in_date;