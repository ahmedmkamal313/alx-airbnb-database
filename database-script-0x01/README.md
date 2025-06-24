# 📦 Database Schema – AirBnB Clone

This directory contains the SQL script that defines the database schema for the AirBnB project.  
It includes all `CREATE TABLE` statements, data types, constraints, and indexes necessary to implement the normalized schema as described in the ERD and normalization documentation.

---

## 📄 Files

- `schema.sql` — SQL script to create the full database schema.
- `README.md` — Overview and structure of the schema.

---

## 🧱 Tables Defined

The schema includes the following normalized entities:

| Table      | Description                                     |
|------------|-------------------------------------------------|
| **Users**      | Represents platform users: guests, hosts, and admins.       |
| **Properties** | Listings created by hosts                       |
| **Bookings**   | Reservations made by users for properties.                      |
| **Payments**   | Payment records for confirmed bookings.                    |
| **Reviews**    | User feedback and ratings for properties.             |
| **Messages**   | Communication between users on the platform.        |

---

## ✅ Features & Constraints

- **UUID primary keys** for all tables.
- **Foreign key relationships** with `ON DELETE CASCADE`.
- **Enumerated types** for roles, statuses, and payment methods.
- **Timestamps** for creation and update tracking.
- **Validation constraints** (e.g., rating between 1 and 5, start date ≤ end date).
- **Indexes** on primary and foreign key fields to optimize query performance.

---

## 📚 Related Documentation

Refer to the following files for more context:

- [`ERD/requirements.md`](../ERD/requirements.md): Entity-Relationship Diagram specification
- [`normalization.md`](../normalization.md): Explanation of schema normalization and 3NF compliance

---
