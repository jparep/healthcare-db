INSERT INTO users (first_name, last_name, email, password_hash, role)
VALUES 
('John', 'Doe', 'john.doe@example.com', 'hashedpassword123', 'admin'),
('Alice', 'Smith', 'alice.smith@example.com', 'hashedpassword456', 'doctor'),
('Bob', 'Johnson', 'bob.johnson@example.com', 'hashedpassword789', 'patient');

INSERT INTO patients (user_id, date_of_birth, gender, phone, address)
VALUES 
(3, '1990-05-15', 'Male', '123-456-7890', '123 Main St, City, Country');

INSERT INTO appointments (patient_id, doctor_id, appointment_date)
VALUES 
(1, 2, '2025-03-01 14:00:00');

INSERT INTO medical_records (patient_id, doctor_id, diagnosis, treatment)
VALUES 
(1, 2, 'Flu', 'Rest and hydration');
