-- schema.sql

-- This SQL script defines the database schema for the AirBnB project.
-- It includes CREATE TABLE statements for all entities, along with
-- primary keys, foreign keys, data types, constraints, and indexes
-- as per the provided database specification and ER diagram (./ERD/airbnb_erd.png).

-- Drop tables if they exist to allow for clean re-creation
-- Order matters due to foreign key dependencies.
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Messages;
DROP TABLE IF EXISTS Properties;
DROP TABLE IF EXISTS Users;

-- 1. Users Table
-- Stores user information, including guests, hosts, and administrators.
CREATE TABLE Users (
    user_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index on email for faster lookup and uniqueness enforcement
CREATE INDEX idx_users_email ON Users (email);


-- 2. Properties Table
-- Stores details about properties listed by hosts.
CREATE TABLE Properties (
    property_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    host_id CHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Index on property_id for faster lookups (already primary key, but specified for clarity)
-- PRIMARY KEY automatically creates an index. This is redundant but explicitly fulfilling the "additional indexes" request for property_id.
-- If the system does not automatically index PK, this would ensure it.
CREATE INDEX idx_properties_property_id ON Properties (property_id);


-- 3. Bookings Table
-- Stores booking information for properties.
CREATE TABLE Bookings (
    booking_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    CHECK (end_date >= start_date)
);

-- Indexes on foreign keys for performance in joins and lookups
CREATE INDEX idx_bookings_property_id ON Bookings (property_id);
CREATE INDEX idx_bookings_user_id ON Bookings (user_id);
-- Index on booking_id (already PK, but specified for clarity as additional index)
CREATE INDEX idx_bookings_booking_id ON Bookings (booking_id);


-- 4. Payments Table
-- Records payment details for bookings.
CREATE TABLE Payments (
    payment_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    booking_id CHAR(36) NOT NULL UNIQUE,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE
);

-- Index on booking_id for faster lookups
CREATE INDEX idx_payments_booking_id ON Payments (booking_id);


-- 5. Reviews Table
-- Stores user reviews for properties.
CREATE TABLE Reviews (
    review_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Indexes on foreign keys for performance
CREATE INDEX idx_reviews_property_id ON Reviews (property_id);
CREATE INDEX idx_reviews_user_id ON Reviews (user_id);


-- 6. Messages Table
-- Stores messages exchanged between users.
CREATE TABLE Messages (
    message_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    sender_id CHAR(36) NOT NULL,
    recipient_id CHAR(36) NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    CHECK (sender_id != recipient_id)
);

-- Indexes on foreign keys for performance
CREATE INDEX idx_messages_sender_id ON Messages (sender_id);
CREATE INDEX idx_messages_recipient_id ON Messages (recipient_id);
