import os
import psycopg2
import pandas as pd
from dotenv import load_dotenv

# Load environment variables
load_dotenv("../docker/.env")

DATABASE_URL = (
    f"dbname={os.getenv('POSTGRES_DB')} "
    f"user={os.getenv('POSTGRES_USER')} "
    f"password={os.getenv('POSTGRES_PASSWORD')} "
    f"host={os.getenv('POSTGRES_HOST')} "
    f"port={os.getenv('POSTGRES_PORT')} "
    f"sslmode=prefer"
)

# Connect to PostgreSQL
conn = psycopg2.connect(DATABASE_URL)
cur = conn.cursor()

# Function to load CSV into table
def load_csv_to_db(file_path, table_name, columns):
    df = pd.read_csv(file_path)
    insert_query = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({', '.join(['%s'] * len(columns))}) ON CONFLICT DO NOTHING;"
    cur.executemany(insert_query, df.values.tolist())
    conn.commit()

# Load CSVs into tables
load_csv_to_db("../data/users.csv", "users", ["user_id", "first_name", "last_name", "email", "password_hash", "role"])
load_csv_to_db("../data/patients.csv", "patients", ["patient_id", "user_id", "date_of_birth", "gender", "phone", "address"])
load_csv_to_db("../data/appointments.csv", "appointments", ["appointment_id", "patient_id", "doctor_id", "appointment_date", "status"])
load_csv_to_db("../data/medical_records.csv", "medical_records", ["record_id", "patient_id", "doctor_id", "diagnosis", "treatment", "created_at"])

cur.close()
conn.close()
print("✅ Successfully inserted CSV data into PostgreSQL!")
