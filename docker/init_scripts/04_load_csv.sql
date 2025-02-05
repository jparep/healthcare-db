-- Ensure the PostgreSQL `uuid-ossp` extension is available for UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Load Users Data
COPY users(user_id, first_name, last_name, email, password_hash, role)
FROM '/docker-entrypoint-initdb.d/users.csv'
DELIMITER ',' CSV HEADER;

-- Load Patients Data
COPY patients(patient_id, user_id, date_of_birth, gender, phone, address)
FROM '/docker-entrypoint-initdb.d/patients.csv'
DELIMITER ',' CSV HEADER;

-- Load Appointments Data
COPY appointments(appointment_id, patient_id, doctor_id, appointment_date, status)
FROM '/docker-entrypoint-initdb.d/appointments.csv'
DELIMITER ',' CSV HEADER;

-- Load Medical Records Data
COPY medical_records(record_id, patient_id, doctor_id, diagnosis, treatment, created_at)
FROM '/docker-entrypoint-initdb.d/medical_records.csv'
DELIMITER ',' CSV HEADER;

-- Verify Data Import
SELECT COUNT(*) FROM users;
SELECT COUNT(*) FROM patients;
SELECT COUNT(*) FROM appointments;
SELECT COUNT(*) FROM medical_records;
