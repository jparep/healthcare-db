-- 🏥 Create Users Table with RBAC Role
CREATE TABLE users (
    user_id UUID DEFAULT gen_random_uuid() PRIMARY KEY, -- Use UUID instead of SERIAL for uniqueness across distributed databases
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    password_hash TEXT NOT NULL,
    role VARCHAR(50) CHECK (role IN ('admin', 'doctor', 'nurse', 'patient')) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 🏥 Create Patients Table
CREATE TABLE patients (
    patient_id UUID DEFAULT gen_random_uuid() PRIMARY KEY, -- Use UUID instead of SERIAL for uniqueness across distributed databases
    user_id UUID UNIQUE REFERENCES users(user_id) ON DELETE CASCADE, -- Ensures one-to-one mapping with users
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')) NOT NULL,
    phone VARCHAR(20) CHECK (phone ~ '^[+]?[0-9\s\-]+$'), -- Ensures phone number format validation
    address TEXT
);

-- 🏥 Create Appointments Table
CREATE TABLE appointments (
    appointment_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    patient_id UUID REFERENCES patients(patient_id) ON DELETE CASCADE,
    doctor_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    appointment_date TIMESTAMP NOT NULL CHECK (appointment_date > NOW()), -- Ensures only future appointments
    status VARCHAR(20) CHECK (status IN ('Scheduled', 'Completed', 'Cancelled')) DEFAULT 'Scheduled',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 🏥 Create Medical Records Table
CREATE TABLE medical_records (
    record_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    patient_id UUID REFERENCES patients(patient_id) ON DELETE CASCADE,
    doctor_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    diagnosis TEXT NOT NULL,
    treatment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 🔑 Indexing for Performance Optimization
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_patient_user ON patients(user_id);
CREATE INDEX idx_appointment_date ON appointments(appointment_date);
CREATE INDEX idx_medical_records_patient ON medical_records(patient_id);
