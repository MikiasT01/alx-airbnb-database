Airbnb Clone Use Case Diagram
Overview
This directory contains the use case diagram for the Airbnb Clone backend project, visualizing the interactions between key actors and the system. The diagram use_case_diagram.png, created using Draw.io on June 30, 2025, at 02:59 PM EAT, captures the key functionalities outlined in the project requirements.
Actors and Use Cases

Actors:
Guest: Registers, logs in, manages profiles, searches properties, books, pays, reviews, and receives notifications.
Host: Registers, logs in, manages profiles, adds/edits/deletes listings, cancels bookings, receives payouts, responds to reviews, and receives notifications.
Admin: Registers, logs in, and monitors/manages the system.
System: Automates booking status tracking, payment processing, and notifications.


Use Cases:
User Registration
User Login and Authentication
Profile Management
Add Property Listing
Edit/Delete Property Listing
Search and Filter Properties
Create Booking
Cancel Booking
Track Booking Status
Process Payment
Submit/Respond to Reviews
Send Notifications
Monitor and Manage Dashboard


Relationships:
Associations: Actors interact directly with relevant use cases (e.g., Guest → Create Booking).
Includes: Create Booking includes Track Booking Status; Add Property Listing includes Track Booking Status; Monitor and Manage Dashboard includes all use cases.
Extends: Cancel Booking extends Create Booking.



Diagram
The use case diagram is available in use_case_diagram.png. It features:

Ovals for use cases within a "Airbnb Clone System" rectangle.
Stick figures for actors (Guest, Host, Admin, System) outside the boundary.
Solid arrows for associations, dashed arrows with "<>" or "<>" for relationships.
A legend indicating arrow types.

Usage

View use_case_diagram.png to understand actor-system interactions.
Use this diagram to guide the design, development, and testing of the Airbnb Clone backend, ensuring all interactions are implemented as of June 30, 2025.
