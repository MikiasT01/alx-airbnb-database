Database Seeding for Airbnb-like Database
Overview
This directory (database-script-0x02/) contains the SQL script to populate the Airbnb-like database with sample data. The seed.sql file includes INSERT statements for the User, Property, Booking, Payment, Review, and Message tables, reflecting real-world usage scenarios.
Files

seed.sql: Contains INSERT statements to populate the database with sample data:
User: 6 users (2 hosts, 3 guests, 1 admin).
Property: 3 properties owned by hosts.
Booking: 4 bookings with varied statuses (confirmed, pending, canceled).
Payment: 2 payments for confirmed bookings.
Review: 3 reviews for properties by guests.
Message: 3 messages between guests and hosts.
Data respects foreign key constraints, unique constraints, and ENUM/CHECK constraints.



Usage

Prerequisites:

Ensure the database schema is created using database-script-0x01/schema.sql.
Use a MySQL-compatible database (e.g., MySQL, MariaDB).


Run the Seed Script:

Execute the seed.sql file:mysql -u <8462> -p <database_name> < database-script-0x02/seed.sql


Replace <username> and <database_name> with your MySQL credentials and database name.


Verify Data:

Query the tables to confirm data insertion:SELECT * FROM User;
SELECT * FROM Property;
SELECT * FROM Booking;
SELECT * FROM Payment;
SELECT * FROM Review;
SELECT * FROM Message;





Notes

UUIDs: Simplified UUID-like strings (e.g., uuid-1) are used for readability. In production, use a UUID generator.
Real-World Scenarios: The data includes multiple users with different roles, properties in varied locations, bookings with different statuses, payments for some bookings, reviews by guests, and messages between users.
Constraints: The data adheres to foreign key constraints (ON DELETE CASCADE), unique constraints (User.email), and CHECK constraints (Review.rating between 1 and 5).
Normalization: The schema is normalized to 3NF, with Booking.total_price computed dynamically (see normalization.md).
