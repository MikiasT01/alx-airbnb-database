## Database Setup
To set up the database:
1. Install PostgreSQL or MySQL on your system.
2. Create a database named `airbnb_clone` using `CREATE DATABASE airbnb_clone;`.
3. Run the schema script: `psql -U postgres -d airbnb_clone -f schema.sql` (or equivalent for MySQL).
4. Populate the database with sample data: `psql -U postgres -d airbnb_clone -f seed.sql`.
5. Use the `joins_queries.sql` file to run the SQL queries for Task 0.