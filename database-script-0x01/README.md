Database Schema for Airbnb-like Database
Overview
This directory (database-script-0x01/) contains the SQL schema definition for the Airbnb-like database. The schema.sql file includes CREATE TABLE statements for all entities, ensuring proper data types, primary keys, foreign keys, constraints, and indexes as specified.
Files

schema.sql: Defines the database schema with the following tables:
User: Stores user information with a unique email constraint.
Property: Stores property details, linked to a host via host_id.
Booking: Manages bookings, normalized to exclude total_price (computed dynamically).
Payment: Records payment details for bookings.
Review: Stores property reviews with a rating constraint (1–5).
Message: Manages messages between users.
Includes primary keys, foreign keys with ON DELETE CASCADE, unique constraints, and indexes for performance.



Usage

Run the Schema:

Use a MySQL-compatible database (e.g., MySQL, MariaDB).
Execute the schema.sql file to create the tables:mysql -u <username> -p <database_name> < schema.sql


For PostgreSQL, modify ENUM types to TEXT with CHECK constraints and adjust CHAR(36) to UUID.


Verify Constraints:

Ensure foreign key constraints are enforced (SET FOREIGN_KEY_CHECKS=1; in MySQL).
Check the unique constraint on User.email and the CHECK constraint on Review.rating.


Indexes:

Indexes are created on primary keys and additional fields (User.email, Property.property_id, Booking.property_id, Payment.booking_id) for optimal query performance.



Notes

The schema is normalized to 3NF, with Booking.total_price removed to avoid transitive dependencies (see normalization.md in the root directory).
Foreign keys use ON DELETE CASCADE to maintain referential integrity.
The schema assumes a MySQL database; adapt for other DBMS if needed.
