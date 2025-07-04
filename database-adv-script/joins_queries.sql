-- INNER JOIN: Bookings and Users
SELECT 
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    u.user_id,
    u.name,
    u.email
FROM 
    bookings b
INNER JOIN 
    users u ON b.user_id = u.user_id;

-- LEFT JOIN: Properties and Reviews
SELECT 
    p.property_id,
    p.title,
    p.location,
    r.review_id,
    r.rating,
    r.comment
FROM 
    properties p
LEFT JOIN 
    reviews r ON p.property_id = r.property_id;

-- FULL OUTER JOIN: Users and Bookings
SELECT 
    u.user_id,
    u.name,
    u.email,
    b.booking_id,
    b.check_in_date,
    b.check_out_date
FROM 
    users u
FULL OUTER JOIN 
    bookings b ON u.user_id = b.user_id;