-- Create index on users.user_id (primary key, already indexed, but included for clarity)
CREATE INDEX idx_users_user_id ON users(user_id);

-- Create index on users.email (used in WHERE clauses for authentication)
CREATE INDEX idx_users_email ON users(email);

-- Create index on properties.user_id (used in JOIN with users)
CREATE INDEX idx_properties_user_id ON properties(user_id);

-- Create index on properties.property_id (primary key, already indexed, but included for clarity)
CREATE INDEX idx_properties_property_id ON properties(property_id);

-- Create index on bookings.user_id (used in JOIN with users and WHERE in subqueries)
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- Create index on bookings.property_id (used in JOIN with properties)
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Performance Analysis: Test query before creating index on reviews.property_id
EXPLAIN ANALYZE
SELECT 
    p.property_id, 
    p.title, 
    p.location
FROM 
    properties p
WHERE 
    p.property_id IN (
        SELECT 
            r.property_id
        FROM 
            reviews r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    );

-- Create index on reviews.property_id (used in JOIN with properties and subqueries)
CREATE INDEX idx_reviews_property_id ON reviews(property_id);

-- Performance Analysis: Test query after creating index on reviews.property_id
EXPLAIN ANALYZE
SELECT 
    p.property_id, 
    p.title, 
    p.location
FROM 
    properties p
WHERE 
    p.property_id IN (
        SELECT 
            r.property_id
        FROM 
            reviews r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    );

-- Performance Analysis Summary:
-- Before Indexing:
-- - The test query likely uses a sequential scan on the reviews table for the subquery, as no index exists on reviews.property_id.
-- - The outer query may use an index scan on properties.property_id (if it’s a primary key index) but still requires scanning the entire properties table to match the subquery results.
-- - Execution time is higher, especially for large datasets, due to the sequential scan on reviews.
--
-- After Indexing:
-- - The index idx_reviews_property_id enables an index scan for the subquery, reducing the cost of grouping and filtering by r.property_id.
-- - The outer query continues to leverage the primary key index on properties.property_id (idx_properties_property_id).
-- - Execution time is reduced, particularly for large datasets, as the index scan on reviews.property_id avoids scanning all rows.
-- - Note: Actual performance improvements depend on data size. For small datasets (e.g., seed.sql), the difference may be minimal, but for thousands of rows, the index significantly lowers execution time.
