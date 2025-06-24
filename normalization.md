# Database Normalization: Achieving Third Normal Form (3NF)

This document explains the principles of database normalization, specifically focusing on First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF).  
It then reviews the current AirBnB database design (as depicted in the ER Diagram) to demonstrate how it already adheres to 3NF.

---

## 📘 What is Normalization?

Database normalization is the process of organizing columns and tables in a relational database to minimize redundancy and improve data integrity.  
This often involves dividing large tables into smaller, well-structured tables and defining relationships between them.

> The normal forms (1NF, 2NF, 3NF, BCNF, etc.) are a series of guidelines to achieve efficient database design.

---

## ✅ Normal Forms Explained

### 1. First Normal Form (1NF)

A table is in **1NF** if:
- Each column contains **atomic (indivisible)** values.
- There are **no repeating groups** or multi-valued attributes.
- Each row is **unique**, usually enforced by a **Primary Key (PK)**.

**📌 Application in the Schema:**
- All attributes (e.g., `first_name`, `email`, `pricepernight`, `start_date`) hold single, atomic values.
- Each table defines a clear PK: `user_id`, `property_id`, `booking_id`, etc.

✔️ **Conclusion:** All tables satisfy 1NF.

---

### 2. Second Normal Form (2NF)

A table is in **2NF** if:
- It is already in **1NF**.
- **Every non-key attribute is fully functionally dependent** on the entire primary key.
  - This mainly applies to **composite primary keys**.

**📌 Application in the Schema:**
- All tables use **single-column UUIDs** as primary keys.
- Since there are no composite keys, there can be no partial dependencies.

✔️ **Conclusion:** All tables satisfy 2NF.

---

### 3. Third Normal Form (3NF)

A table is in **3NF** if:
- It is in **2NF**.
- **No transitive dependencies** exist.
  - Every non-key attribute must depend **only on the primary key**, not on other non-key attributes.

**📌 Application in the Schema:**

#### 🧑‍💼 User Table
- PK: `user_id`
- Other fields (`first_name`, `email`, `role`, etc.) directly describe the user.
- No attribute depends on another non-key attribute.

#### 🏠 Property Table
- PK: `property_id`
- Describes the property directly (name, description, price, etc.)
- FK `host_id` links to `users` without introducing redundancy.

#### 📅 Booking Table
- PK: `booking_id`
- Describes the booking (dates, price, status).
- FKs `user_id` and `property_id` are correctly used to reference external data.

#### 💳 Payment Table
- PK: `payment_id`
- Attributes describe the payment directly.
- FK `booking_id` is correctly normalized and avoids duplication.

#### 🌟 Review Table
- PK: `review_id`
- Fields like `rating`, `comment`, and `created_at` describe the review.
- FKs `user_id` and `property_id` maintain normalized links.

#### 💬 Message Table
- PK: `message_id`
- Fields describe the message.
- FKs `sender_id` and `recipient_id` correctly model relationships without redundancy.

✔️ **Conclusion:** All tables satisfy 3NF.

---

## ✅ Final Summary

The current AirBnB database schema:
- Is in **First Normal Form (1NF)**: Atomic values, unique rows.
- Is in **Second Normal Form (2NF)**: Full dependency on single-column primary keys.
- Is in **Third Normal Form (3NF)**: No transitive dependencies; non-key attributes describe the PK only.

🎯 **Result:** No changes are needed — the schema is already normalized to 3NF.
