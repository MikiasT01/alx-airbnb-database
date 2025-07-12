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

-- Create index on reviews.property_id (used in JOIN with properties and subqueries)
CREATE INDEX idx_reviews_property_id ON reviews(property_id);