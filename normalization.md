Database Normalization to 3NF
This document outlines the steps taken to normalize the Airbnb-like database to the Third Normal Form (3NF) based on the provided schema. The goal is to eliminate redundancies, ensure data integrity, and avoid insertion, update, and deletion anomalies.
Database Schema
The database consists of six tables: User, Property, Booking, Payment, Review, and Message. The schema was reviewed for compliance with the First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF).
Entities and Attributes
User

user_id: UUID (PK, Indexed)
first_name: VARCHAR (NOT NULL)
last_name: VARCHAR (NOT NULL)
email: VARCHAR (UNIQUE, NOT NULL)
password_hash: VARCHAR (NOT NULL)
phone_number: VARCHAR
role: ENUM(guest, host, admin) (NOT NULL)
created_at: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

Property

property_id: UUID (PK, Indexed)
host_id: UUID (FK -> User.user_id)
name: VARCHAR (NOT NULL)
description: TEXT (NOT NULL)
location: VARCHAR (NOT NULL)
pricepernight: DECIMAL (NOT NULL)
created_at: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)
updated_at: TIMESTAMP (ON UPDATE CURRENT_TIMESTAMP)

Booking

booking_id: UUID (PK, Indexed)
property_id: UUID (FK -> Property.property_id)
user_id: UUID (FK -> User.user_id)
start_date: DATE (NOT NULL)
end_date: DATE (NOT NULL)
total_price: DECIMAL (NOT NULL)
status: ENUM(pending, confirmed, canceled) (NOT NULL)
created_at: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

Payment

payment_id: UUID (PK, Indexed)
booking_id: UUID (FK -> Booking.booking_id)
amount: DECIMAL (NOT NULL)
payment_date: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)
payment_method: ENUM(credit_card, paypal, stripe) (NOT NULL)

Review

review_id: UUID (PK, Indexed)
property_id: UUID (FK -> Property.property_id)
user_id: UUID (FK -> User.user_id)
rating: INTEGER (CHECK 1-5, NOT NULL)
comment: TEXT (NOT NULL)
created_at: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

Message

message_id: UUID (PK, Indexed)
sender_id: UUID (FK -> User.user_id)
recipient_id: UUID (FK -> User.user_id)
message_body: TEXT (NOT NULL)
sent_at: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

Normalization Steps
Step 1: First Normal Form (1NF)
Objective: Ensure all attributes are atomic (no multi-valued attributes or repeating groups) and each table has a primary key.
Analysis:

Atomic Attributes: All attributes in all tables are atomic:
User: Attributes like email, first_name, and role store single values.
Property: location (VARCHAR) is assumed to be a single string (e.g., "New York, NY"). No multi-valued attributes detected.
Booking, Payment, Review, Message: Attributes like message_body (TEXT) and comment (TEXT) are single values, not repeating groups.


Primary Keys: Each table has a unique primary key (UUIDs: user_id, property_id, booking_id, payment_id, review_id, message_id), all indexed.
Result: The schema is in 1NF, as all attributes are atomic and primary keys are defined.

Step 2: Second Normal Form (2NF)
Objective: Ensure the schema is in 1NF and there are no partial dependencies (non-key attributes must depend on the entire primary key).
Analysis:

All tables have single-column primary keys (UUIDs), so partial dependencies are not applicable.
Non-key attributes (e.g., User.first_name, Property.name, Booking.status) depend fully on their respective primary keys.
Result: The schema is in 2NF, as there are no composite keys or partial dependencies.

Step 3: Third Normal Form (3NF)
Objective: Ensure the schema is in 2NF and there are no transitive dependencies (non-key attributes must not depend on other non-key attributes).
Analysis:

User: All non-key attributes (first_name, last_name, email, etc.) depend directly on user_id. No transitive dependencies.
Property: Attributes like name, description, location, and pricepernight depend on property_id. The foreign key host_id depends on property_id (as it defines the relationship), not on other non-key attributes.
Booking:
Issue: The total_price attribute may be derived from Property.pricepernight, start_date, and end_date (e.g., total_price = pricepernight * (end_date - start_date)). This creates a transitive dependency, as total_price depends on non-key attributes indirectly through property_id.
Solution: Remove total_price from the Booking table to eliminate the transitive dependency. Calculate total_price dynamically in queries:SELECT 
    b.booking_id,
    (DATEDIFF(b.end_date, b.start_date) * p.pricepernight) AS total_price
FROM Booking b
JOIN Property p ON b.property_id = p.property_id;




Payment: Attributes (amount, payment_date, payment_method) depend on payment_id. The foreign key booking_id depends on payment_id.
Review: Attributes (rating, comment) depend on review_id. Foreign keys property_id and user_id depend on review_id.
Message: Attributes (message_body, sent_at) depend on message_id. Foreign keys sender_id and recipient_id depend on message_id.
Result: After removing Booking.total_price, the schema is in 3NF, as no non-key attributes depend on other non-key attributes.

Final Normalized Schema
The adjusted Booking table is:
Booking

booking_id: UUID (PK, Indexed)
property_id: UUID (FK -> Property.property_id)
user_id: UUID (FK -> User.user_id)
start_date: DATE (NOT NULL)
end_date: DATE (NOT NULL)
status: ENUM(pending, confirmed, canceled) (NOT NULL)
created_at: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

All other tables (User, Property, Payment, Review, Message) remain unchanged, as they are already in 3NF.
Summary

The original schema was in 1NF and 2NF, with atomic attributes, primary keys, and no partial dependencies.
A transitive dependency was identified in the Booking table (total_price depending on Property.pricepernight, start_date, and end_date).
The schema was normalized to 3NF by removing Booking.total_price and computing it dynamically in queries.
The normalized schema ensures data integrity, minimizes redundancy, and prevents anomalies during data operations.
