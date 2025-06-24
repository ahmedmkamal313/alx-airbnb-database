
# 🏡 ALX AirBnB Database Project

This repository contains the full database design and implementation for an AirBnB-like platform, including:

- Entity-Relationship Diagram (ERD)
- Normalization process to Third Normal Form (3NF)
- SQL schema (DDL) scripts
- Sample data insertion (DML) scripts

---

## 📁 Repository Structure

alx-airbnb-database/
- [ERD/](/ERD/)
    - [airbnb_erd.png](/ERD/airbnb_erd.PNG) # ER diagram image.
    - [requirements.md](/ERD/requirements.md) # ERD details with entities, attributes, and relationships.
- [database-script-0x01/](/database-script-0x01/)
    - [schema.sql](/database-script-0x01/schema.sql) # Full schema DDL script with constraints and indexes.
    - [README.md](/database-script-0x01/README.md) # Notes on schema and implementation details.
- [database-script-0x02/](/database-script-0x02/)
    - [seed.sql](/database-script-0x02/seed.sql) # Sample data INSERTs for all tables.
    - [README.md](/database-script-0x02/README.md) # Explanation of how the seed data works.


- [normalization.md](normalization.md) # Normalization process up to 3NF.
- [README.md](README.md) # Main project documentation (this file).


---

## 🧠 Project Goals

- Model a real-world AirBnB-style relational database
- Apply sound relational design and indexing
- Normalize all tables to **Third Normal Form (3NF)**
- Use SQL (MySQL-compatible) to define and populate the database schema

---

## 📌 Entity-Relationship Diagram (ERD)

The ER diagram visualizes the relationships between major entities:

- **Users** (guests, hosts, admins)
- **Properties** listed by hosts
- **Bookings** made by guests
- **Payments**, **Reviews**, and **Messages**

![ERD](./ERD/airbnb_erd.png)

> 🧾 Full breakdown of entities, attributes, relationships, and cardinalities:  
> [ERD/requirements.md](./ERD/requirements.md)

---

## ✅ Database Normalization (3NF)

The design follows database normalization principles to eliminate redundancy and ensure data integrity.

- **1NF**: Atomic attributes, no repeating groups  
- **2NF**: No partial dependencies (no composite PKs)  
- **3NF**: No transitive dependencies  

Each table’s structure is explained in detail in the [normalization.md](./normalization.md) file.

---

## 🏗️ Database Schema (DDL)

File: [`database-script-0x01/schema.sql`](./database-script-0x01/schema.sql)

- Includes `CREATE TABLE` statements for:
  - Users
  - Properties
  - Bookings
  - Payments
  - Reviews
  - Messages

- All relationships are defined with foreign keys
- Includes constraints (e.g., CHECK, ENUM) and performance indexes
- Tailored for **MySQL** with UUIDs and ENUM types

> 📘 More details in: [`database-script-0x01/README.md`](./database-script-0x01/README.md)

---

## 🧪 Sample Seed Data (DML)

File: [`database-script-0x02/seed.sql`](./database-script-0x02/seed.sql)

- Adds multiple:
  - Users (with `host`, `guest`, and `admin` roles)
  - Properties (linked to hosts)
  - Bookings (linked to users and properties)
  - Payments (only for confirmed bookings)
  - Reviews (linked to both properties and users)
  - Messages (between users)

- Designed for development/testing environments
- Includes realistic use cases and interlinked data

> 📘 More details in: [`database-script-0x02/README.md`](./database-script-0x02/README.md)

---

## 🔗 Related Files

- ER Diagram: [`./ERD/airbnb_erd.png`](./ERD/airbnb_erd.png)
- ERD Metadata: [`./ERD/requirements.md`](./ERD/requirements.md)
- Schema: [`./database-script-0x01/schema.sql`](./database-script-0x01/schema.sql)
- Normalization: [`./normalization.md`](./normalization.md)
- Seed Data: [`./database-script-0x02/seed.sql`](./database-script-0x02/seed.sql)

---
### 👤 Author
[🔗 GitHub: Ahmed Kamal](https://github.com/ahmedmkamal313)
