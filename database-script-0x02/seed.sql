-- Insert sample data into User table
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
('uuid-1', 'John', 'Doe', 'john.doe@example.com', 'hash1', '123-456-7890', 'host', '2025-06-01 10:00:00'),
('uuid-2', 'Jane', 'Smith', 'jane.smith@example.com', 'hash2', '234-567-8901', 'host', '2025-06-01 11:00:00'),
('uuid-3', 'Alice', 'Johnson', 'alice.johnson@example.com', 'hash3', '345-678-9012', 'guest', '2025-06-02 09:00:00'),
('uuid-4', 'Bob', 'Brown', 'bob.brown@example.com', 'hash4', '456-789-0123', 'guest', '2025-06-02 10:00:00'),
('uuid-5', 'Carol', 'White', 'carol.white@example.com', 'hash5', '567-890-1234', 'guest', '2025-06-03 12:00:00'),
('uuid-6', 'Admin', 'User', 'admin@example.com', 'hash6', '678-901-2345', 'admin', '2025-06-01 08:00:00');

-- Insert sample data into Property table
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
('uuid-101', 'uuid-1', 'Cozy Downtown Apartment', 'A modern apartment in the heart of the city.', 'New York, NY', 150.00, '2025-06-01 12:00:00', '2025-06-01 12:00:00'),
('uuid-102', 'uuid-1', 'Beachfront Villa', 'Spacious villa with ocean views.', 'Miami, FL', 300.00, '2025-06-02 14:00:00', '2025-06-02 14:00:00'),
('uuid-103', 'uuid-2', 'Mountain Cabin', 'Rustic cabin in the mountains.', 'Denver, CO', 200.00, '2025-06-03 10:00:00', '2025-06-03 10:00:00');

-- Insert sample data into Booking table
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, status, created_at) VALUES
('uuid-201', 'uuid-101', 'uuid-3', '2025-07-01', '2025-07-05', 'confirmed', '2025-06-10 09:00:00'),
('uuid-202', 'uuid-102', 'uuid-4', '2025-07-10', '2025-07-15', 'pending', '2025-06-11 10:00:00'),
('uuid-203', 'uuid-103', 'uuid-5', '2025-07-20', '2025-07-25', 'canceled', '2025-06-12 11:00:00'),
('uuid-204', 'uuid-101', 'uuid-4', '2025-08-01', '2025-08-03', 'confirmed', '2025-06-13 12:00:00');

-- Insert sample data into Payment table
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('uuid-301', 'uuid-201', 600.00, '2025-06-10 10:00:00', 'credit_card'),
('uuid-302', 'uuid-204', 300.00, '2025-06-13 13:00:00', 'paypal');

-- Insert sample data into Review table
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
('uuid-401', 'uuid-101', 'uuid-3', 5, 'Amazing stay, great location!', '2025-07-06 09:00:00'),
('uuid-402', 'uuid-101', 'uuid-4', 4, 'Comfortable apartment, but parking was limited.', '2025-08-04 10:00:00'),
('uuid-403', 'uuid-103', 'uuid-5', 3, 'Nice cabin, but a bit remote.', '2025-07-26 11:00:00');

-- Insert sample data into Message table
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('uuid-501', 'uuid-3', 'uuid-1', 'Hi, is the apartment available for July?', '2025-06-05 08:00:00'),
('uuid-502', 'uuid-1', 'uuid-3', 'Yes, it’s available. Please book soon!', '2025-06-05 09:00:00'),
('uuid-503', 'uuid-4', 'uuid-2', 'Can you provide more details about the villa?', '2025-06-06 10:00:00');