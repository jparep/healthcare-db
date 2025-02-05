-- Load data from CSV into users
COPY users(user_id, first_name, last_name, email, password_hash, role)
FROM '/docker-entrypoint-initdb.d/users.csv'
DELIMITER ',' CSV HEADER;

-- Load data from CSV into patients
COPY patients(patient_id, user_id, date_of_birth, gender, phone, address)
FROM '/docker-entrypoint-initdb.d/patients.csv'
DELIMITER ',' CSV HEADER;

-- Load data from CSV into appointments
COPY appointments(appointment_id, patient_id, doctor_id, appointment_date, status)
FROM '/docker-entrypoint-initdb.d/appointments.csv'
DELIMITER ',' CSV HEADER;

-- Load data from CSV into medical_records
COPY medical_records(record_id, patient_id, doctor_id, diagnosis, treatment, created_at)
FROM '/docker-entrypoint-initdb.d/medical_records.csv'
DELIMITER ',' CSV HEADER;
