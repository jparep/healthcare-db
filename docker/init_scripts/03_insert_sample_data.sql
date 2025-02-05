-- ✅ Insert Users with UUIDs
INSERT INTO users (user_id, first_name, last_name, email, password_hash, role) VALUES
('fdf5a9ab-be20-4825-b1bc-0d614ba40401', 'John', 'Doe', 'john.doe@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'admin'),
('08ceabfc-8407-4225-8a41-de7b19b01f01', 'Alice', 'Smith', 'alice.smith@example.com', 'c6ba91b90d922e159893f46c387e5dc1b3dc5c101a5a4522f03b987177a24a91', 'doctor'),
('9528344b-183d-4621-b123-01d721e86248', 'Bob', 'Johnson', 'bob.johnson@example.com', '5efc2b017da4f7736d192a74dde5891369e0685d4d38f2a455b6fcdab282df9c', 'patient');

-- ✅ Insert Patient Linked to User
INSERT INTO patients (patient_id, user_id, date_of_birth, gender, phone, address)
VALUES 
('c61e0e67-6174-44cf-81f3-f8416520bee6', '9528344b-183d-4621-b123-01d721e86248', '1990-05-15', 'Male', '123-456-7890', '123 Main St, City, Country');

-- ✅ Insert Appointment Linked to Patient & Doctor
INSERT INTO appointments (appointment_id, patient_id, doctor_id, appointment_date)
VALUES 
('993c8530-118f-4cf4-bac8-4db6518d15dd', 'c61e0e67-6174-44cf-81f3-f8416520bee6', '08ceabfc-8407-4225-8a41-de7b19b01f01', '2025-03-01 14:00:00');

-- ✅ Insert Medical Record Linked to Appointment
INSERT INTO medical_records (record_id, patient_id, doctor_id, diagnosis, treatment)
VALUES 
('f21c22b5-a5df-4490-8e8f-36b3eca9c667', 'c61e0e67-6174-44cf-81f3-f8416520bee6', '08ceabfc-8407-4225-8a41-de7b19b01f01', 'Flu', 'Rest and hydration');
