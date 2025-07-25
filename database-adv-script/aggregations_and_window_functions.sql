-- Query 1: Find the total number of bookings made by each user using COUNT and GROUP BY
SELECT 
    u.user_id,
    u.name,
    u.email,
    COUNT(b.booking_id) AS total_bookings
FROM 
    users u
LEFT JOIN 
    bookings b ON u.user_id = b.user_id
GROUP BY 
    u.user_id,
    u.name,
    u.email
ORDER BY 
    total_bookings DESC;

-- Query 2: Use window functions to rank properties based on total number of bookings
SELECT 
    p.property_id,
    p.title,
    p.location,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_row_number,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM 
    properties p
LEFT JOIN 
    bookings b ON p.property_id = b.property_id
GROUP BY 
    p.property_id,
    p.title,
    p.location
ORDER BY 
    booking_row_number, total_bookings DESC;
