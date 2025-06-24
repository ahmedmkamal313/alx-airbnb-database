# AirBnB Database ER Diagram Requirements

This document outlines the Entity-Relationship Diagram (ERD) for the AirBnB database, detailing the entities, their attributes, and the relationships between them, based on the provided database specification.

---

## 📊 Visual ER Diagram

Below is the visual representation of the ER Diagram.

![AirBnB ER Diagram](https://github.com/ahmedmkamal313/alx-airbnb-database/blob/main/ERD/airbnb_erd.PNG)

---

## 📦 1. Entities and Attributes

Each entity is presented with its attributes.  
**Primary Keys (PK)** are marked explicitly, and **Foreign Keys (FK)** indicate the relationship to another entity’s primary key. Data types and constraints are included for completeness.

---

### 🧑‍💼 User

- `user_id` (PK, UUID, Indexed)  
- `first_name` (VARCHAR, NOT NULL)  
- `last_name` (VARCHAR, NOT NULL)  
- `email` (VARCHAR, UNIQUE, NOT NULL, Indexed)  
- `password_hash` (VARCHAR, NOT NULL)  
- `phone_number` (VARCHAR, NULL)  
- `role` (ENUM: 'guest', 'host', 'admin', NOT NULL)  
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)  

---

### 🏠 Property

- `property_id` (PK, UUID, Indexed)  
- `host_id` (FK → User.user_id)  
- `name` (VARCHAR, NOT NULL)  
- `description` (TEXT, NOT NULL)  
- `location` (VARCHAR, NOT NULL)  
- `pricepernight` (DECIMAL, NOT NULL)  
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)  
- `updated_at` (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)  

---

### 📅 Booking

- `booking_id` (PK, UUID, Indexed)  
- `property_id` (FK → Property.property_id, Indexed)  
- `user_id` (FK → User.user_id)  
- `start_date` (DATE, NOT NULL)  
- `end_date` (DATE, NOT NULL)  
- `total_price` (DECIMAL, NOT NULL)  
- `status` (ENUM: 'pending', 'confirmed', 'canceled', NOT NULL)  
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)  

---

### 💳 Payment

- `payment_id` (PK, UUID, Indexed)  
- `booking_id` (FK → Booking.booking_id, Indexed)  
- `amount` (DECIMAL, NOT NULL)  
- `payment_date` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)  
- `payment_method` (ENUM: 'credit_card', 'paypal', 'stripe', NOT NULL)  

---

### 🌟 Review

- `review_id` (PK, UUID, Indexed)  
- `property_id` (FK → Property.property_id)  
- `user_id` (FK → User.user_id)  
- `rating` (INTEGER, NOT NULL, CHECK: rating >= 1 AND rating <= 5)  
- `comment` (TEXT, NOT NULL)  
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)  

---

### 💬 Message

- `message_id` (PK, UUID, Indexed)  
- `sender_id` (FK → User.user_id)  
- `recipient_id` (FK → User.user_id)  
- `message_body` (TEXT, NOT NULL)  
- `sent_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)  

---

## 🔗 2. Relationships (Crow's Foot Notation)

This section describes the relationships between entities, indicating the cardinality using Crow’s Foot notation.

---

### A. User ↔ Property (Hosts)

**Relationship Name:** `Hosts`  
- **User side:** 1 (One and Only One) – A property must have exactly one host  
- **Property side:** 0..N (Zero or More) – A user can host zero or many properties  
- **Foreign Key:** `Property.host_id` → `User.user_id`  

---

### B. User ↔ Booking (Makes)

**Relationship Name:** `Makes`  
- **User side:** 1 (One and Only One) – A booking is made by one user  
- **Booking side:** 0..N (Zero or More) – A user can make many bookings  
- **Foreign Key:** `Booking.user_id` → `User.user_id`  

---

### C. Property ↔ Booking (Is For)

**Relationship Name:** `Is For`  
- **Property side:** 1 (One and Only One) – A booking is for one property  
- **Booking side:** 0..N (Zero or More) – A property can have many bookings  
- **Foreign Key:** `Booking.property_id` → `Property.property_id`  

---

### D. Booking ↔ Payment (Has Payment)

**Relationship Name:** `Has Payment`  
- **Booking side:** 1 (One and Only One) – A payment is for one booking  
- **Payment side:** 0..1 (Zero or One) – A booking may or may not have a payment yet  
- **Foreign Key:** `Payment.booking_id` → `Booking.booking_id`  

---

### E. User ↔ Review (Writes)

**Relationship Name:** `Writes`  
- **User side:** 1 (One and Only One) – A review is written by one user  
- **Review side:** 0..N (Zero or More) – A user can write many reviews  
- **Foreign Key:** `Review.user_id` → `User.user_id`  

---

### F. Property ↔ Review (Receives)

**Relationship Name:** `Receives`  
- **Property side:** 1 (One and Only One) – A review is for one property  
- **Review side:** 0..N (Zero or More) – A property can receive many reviews  
- **Foreign Key:** `Review.property_id` → `Property.property_id`  

---

### G. User ↔ Message (Sends)

**Relationship Name:** `Sends`  
- **User side:** 1 (One and Only One) – A message is sent by one user  
- **Message side:** 0..N (Zero or More) – A user can send many messages  
- **Foreign Key:** `Message.sender_id` → `User.user_id`  

---

### H. User ↔ Message (Receives)

**Relationship Name:** `Receives`  
- **User side:** 1 (One and Only One) – A message is received by one user  
- **Message side:** 0..N (Zero or More) – A user can receive many messages  
- **Foreign Key:** `Message.recipient_id` → `User.user_id`  
