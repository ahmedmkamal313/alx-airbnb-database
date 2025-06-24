-- seed.sql

-- This SQL script populates the AirBnB MySQL database with sample data.
-- It must be run *after* `schema.sql` has created the tables.

-- Disable foreign key checks to safely truncate all tables (clean re-run)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Payments;
TRUNCATE TABLE Bookings;
TRUNCATE TABLE Reviews;
TRUNCATE TABLE Messages;
TRUNCATE TABLE Properties;
TRUNCATE TABLE Users;
SET FOREIGN_KEY_CHECKS = 1;

-- Insert sample users
INSERT INTO Users (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Alice', 'Smith', 'alice.smith@example.com', 'hashedpass1', '1112223333', 'host'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Bob', 'Johnson', 'bob.j@example.com', 'hashedpass2', '4445556666', 'guest'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Charlie', 'Brown', 'charlie.b@example.com', 'hashedpass3', NULL, 'guest'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Diana', 'Prince', 'diana.p@example.com', 'hashedpass4', '7778889999', 'admin'),
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Eve', 'Adams', 'eve.a@example.com', 'hashedpass5', '0001112222', 'host');

-- Insert sample properties
INSERT INTO Properties (property_id, host_id, name, description, location, pricepernight) VALUES
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Cozy Downtown Apartment', 'A beautiful and cozy apartment in the heart of the city.', 'New York, NY', 150.00),
('g0eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Spacious Beach House', 'Enjoy the ocean breeze in this large beach house.', 'Malibu, CA', 300.50),
('h0eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Rustic Cabin in the Woods', 'Perfect getaway for nature lovers.', 'Asheville, NC', 100.00);

-- Insert sample bookings
INSERT INTO Bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
('i0eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', '2025-07-10', '2025-07-15', 750.00, 'confirmed'),
('j0eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'g0eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '2025-08-01', '2025-08-07', 1803.00, 'pending'),
('k0eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'h0eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', '2025-09-01', '2025-09-03', 200.00, 'canceled');

-- Insert sample payments
INSERT INTO Payments (payment_id, booking_id, amount, payment_method) VALUES
('l0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'i0eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 750.00, 'credit_card');

-- Insert sample reviews
INSERT INTO Reviews (review_id, property_id, user_id, rating, comment) VALUES
('m0eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 5, 'Absolutely loved the place! Very clean and centrally located.'),
('n0eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'h0eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 4, 'Nice quiet cabin, great for a relaxing weekend.'),
('o0eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 3, 'Good location, but could use some updates.');

-- Insert sample messages
INSERT INTO Messages (message_id, sender_id, recipient_id, message_body) VALUES
('p0eebc99-9c0b-4ef8-bb6d-6bb9bd380a26', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Hi Alice, is the apartment available for earlier check-in?'),
('q0eebc99-9c0b-4ef8-bb6d-6bb9bd380a27', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Hello Bob, yes, early check-in is possible for an extra fee.'),
('r0eebc99-9c0b-4ef8-bb6d-6bb9bd380a28', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Is the beach house pet-friendly?'),
('s0eebc99-9c0b-4ef8-bb6d-6bb9bd380a29', 'e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Unfortunately, we do not allow pets at this property.');
