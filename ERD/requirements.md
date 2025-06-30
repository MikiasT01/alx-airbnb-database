Database Specification for Airbnb-like Database
This document outlines the database specification for the Airbnb-like database, including entities, attributes, relationships, constraints, and indexes. The Entity-Relationship (ER) diagram is provided in ERD/diagram.png, created using Draw.io.
Entities and Attributes
User

user_id: CHAR(36) (Primary Key, Indexed)
first_name: VARCHAR(255) (NOT NULL)
last_name: VARCHAR(255) (NOT NULL)
email: VARCHAR(255) (UNIQUE, NOT NULL)
password_hash: VARCHAR(255) (NOT NULL)
phone_number: VARCHAR(20)
role: ENUM('guest', 'host', 'admin') (NOT NULL)
created_at: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

Property

property_id: CHAR(36) (Primary Key, Indexed)
host_id: CHAR(36) (Foreign Key -> User.user_id, NOT NULL)
name: VARCHAR(255) (NOT NULL)
description: TEXT (NOT NULL)
location: VARCHAR(255) (NOT NULL)
pricepernight: DECIMAL(10,2) (NOT NULL)
created_at: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)
updated_at: TIMESTAMP (ON UPDATE CURRENT_TIMESTAMP)

Booking

booking_id: CHAR(36) (Primary Key, Indexed)
property_id: CHAR(36) (Foreign Key -> Property.property_id, NOT NULL)
user_id: CHAR(36) (Foreign Key -> User.user_id, NOT NULL)
start_date: DATE (NOT NULL)
end_date: DATE (NOT NULL)
status: ENUM('pending', 'confirmed', 'canceled') (NOT NULL)
created_at: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

Payment

payment_id: CHAR(36) (Primary Key, Indexed)
booking_id: CHAR(36) (Foreign Key -> Booking.booking_id, NOT NULL)
amount: DECIMAL(10,2) (NOT NULL)
payment_date: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)
payment_method: ENUM('credit_card', 'paypal', 'stripe') (NOT NULL)

Review

review_id: CHAR(36) (Primary Key, Indexed)
property_id: CHAR(36) (Foreign Key -> Property.property_id, NOT NULL)
user_id: CHAR(36) (Foreign Key -> User.user_id, NOT NULL)
rating: INTEGER (CHECK rating >= 1 AND rating <= 5, NOT NULL)
comment: TEXT (NOT NULL)
created_at: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

Message

message_id: CHAR(36) (Primary Key, Indexed)
sender_id: CHAR(36) (Foreign Key -> User.user_id, NOT NULL)
recipient_id: CHAR(36) (Foreign Key -> User.user_id, NOT NULL)
message_body: TEXT (NOT NULL)
sent_at: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

Relationships

User to Property (Owns):
One-to-Many (1:N).
A User (host) can own multiple Properties.
A Property is owned by one User.
Foreign Key: Property.host_id -> User.user_id.
Participation: Mandatory.


User to Booking (Makes):
One-to-Many (1:N).
A User (guest) can make multiple Bookings.
A Booking is made by one User.
Foreign Key: Booking.user_id -> User.user_id.
Participation: Mandatory.


Property to Booking (Has):
One-to-Many (1:N).
A Property can have multiple Bookings.
A Booking is for one Property.
Foreign Key: Booking.property_id -> Property.property_id.
Participation: Mandatory.


Booking to Payment (Has):
One-to-One (1:1).
A Booking can have one Payment (optional).
A Payment is for one Booking.
Foreign Key: Payment.booking_id -> Booking.booking_id.
Participation: Optional for Booking.


User to Review (Writes):
One-to-Many (1:N).
A User (guest) can write multiple Reviews.
A Review is written by one User.
Foreign Key: Review.user_id -> User.user_id.
Participation: Mandatory.


Property to Review (Has):
One-to-Many (1:N).
A Property can have multiple Reviews.
A Review is for one Property.
Foreign Key: Review.property_id -> Property.property_id.
Participation: Mandatory.


User to Message (Sends):
One-to-Many (1:N).
A User can send multiple Messages.
A Message has one sender.
Foreign Key: Message.sender_id -> User.user_id.
Participation: Mandatory.


User to Message (Receives):
One-to-Many (1:N).
A User can receive multiple Messages.
A Message has one recipient.
Foreign Key: Message.recipient_id -> User.user_id.
Participation: Mandatory.



Constraints

User: 
Unique constraint on email.
NOT NULL on first_name, last_name, email, password_hash, role.


Property: 
Foreign key constraint on host_id.
NOT NULL on name, description, location, pricepernight.


Booking: 
Foreign key constraints on property_id, user_id.
NOT NULL on start_date, end_date, status.
status must be one of 'pending', 'confirmed', or 'canceled'.


Payment: 
Foreign key constraint on booking_id.
NOT NULL on amount, payment_method.
payment_method must be one of 'credit_card', 'paypal', or 'stripe'.


Review: 
Foreign key constraints on property_id, user_id.
NOT NULL on rating, comment.
CHECK constraint: rating must be between 1 and 5.


Message: 
Foreign key constraints on sender_id, recipient_id.
NOT NULL on message_body.



Indexes

Primary Keys: Automatically indexed (user_id, property_id, booking_id, payment_id, review_id, message_id).
Additional Indexes:
User.email: For fast lookup of users by email.
Property.property_id: For queries involving properties (already indexed as PK).
Booking.property_id: For efficient joins with Property.
Payment.booking_id: For efficient joins with Booking.



ER Diagram
The ER diagram is available in ERD/diagram.png, created using Draw.io. It visualizes the entities, attributes, relationships, and constraints described above, using crow’s foot notation for cardinality and participation.