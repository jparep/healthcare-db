-- ✅ 1. Create Database Roles with Least Privilege Principle
CREATE ROLE admin_role WITH LOGIN CREATEDB CREATEROLE;
CREATE ROLE doctor_role;
CREATE ROLE nurse_role;
CREATE ROLE patient_role;
CREATE ROLE app_user NOLOGIN; -- Prevents direct login to the database

-- 🔒 2. Ensure Secure Defaults
ALTER ROLE admin_role SET search_path = public;
ALTER ROLE doctor_role SET search_path = public;
ALTER ROLE nurse_role SET search_path = public;
ALTER ROLE patient_role SET search_path = public;

-- ✅ 3. Grant Access Based on Roles (Least Privilege Model)
-- 🔹 Admin has FULL control over all tables
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_role;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_role;

-- 🔹 Doctors can create & update appointments and medical records
GRANT SELECT, INSERT, UPDATE ON appointments TO doctor_role;
GRANT SELECT, INSERT, UPDATE ON medical_records TO doctor_role;
GRANT SELECT ON users TO doctor_role; -- Can only view users (not modify)

-- 🔹 Nurses can view medical records & manage appointments
GRANT SELECT ON medical_records TO nurse_role;
GRANT SELECT, INSERT, UPDATE ON appointments TO nurse_role;

-- 🔹 Patients can ONLY view their own records (enforced via RLS)
GRANT SELECT ON patients TO patient_role;
GRANT SELECT ON appointments TO patient_role;

-- ✅ 4. Restrict Users from Creating Tables
REVOKE CREATE ON SCHEMA public FROM PUBLIC;

-- ✅ 5. Enforce Row-Level Security (RLS) for Data Privacy
ALTER TABLE patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE medical_records ENABLE ROW LEVEL SECURITY;

-- ✅ 6. Define Row-Level Security Policies

-- 🔹 Patients can only access their own records
CREATE POLICY patient_policy ON patients 
FOR SELECT USING (user_id = current_user::UUID);

CREATE POLICY patient_appointment_policy ON appointments 
FOR SELECT USING (patient_id IN (SELECT patient_id FROM patients WHERE user_id = current_user::UUID));

-- 🔹 Doctors can only view and update their assigned patients
CREATE POLICY doctor_policy ON appointments 
FOR SELECT, UPDATE USING (doctor_id = current_user::UUID);

CREATE POLICY doctor_medical_records_policy ON medical_records 
FOR SELECT, UPDATE USING (doctor_id = current_user::UUID);

-- 🔹 Nurses can see all appointments but only view medical records
CREATE POLICY nurse_appointments_policy ON appointments 
FOR SELECT USING (true);

CREATE POLICY nurse_medical_records_policy ON medical_records 
FOR SELECT USING (true);
