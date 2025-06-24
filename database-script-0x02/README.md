# 🏡 Airbnb Database – Sample Data

This folder contains the `seed.sql` script used to populate the Airbnb MySQL database with realistic sample data for testing and development purposes.

## 📄 Files

- `seed.sql` – Populates all six tables (Users, Properties, Bookings, Payments, Reviews, Messages)

## 💡 What’s Inside

- 5 sample users (guests, hosts, admin)
- 3 sample properties hosted by users
- 3 bookings with different statuses
- 1 payment linked to a confirmed booking
- 3 reviews from users
- 4 messages exchanged between users

## 📌 Notes
UUIDs are hardcoded for consistency across foreign keys

## 🔗 Related Files

- [📄 schema.sql](../database-script-0x01/schema.sql) – Full SQL schema definition.
- [📁 ERD Folder](../ERD/) – Contains the Entity Relationship Diagram (ERD) and requirements documentation.
