import os
from dotenv import load_dotenv

# Ensure the correct .env path is loaded
dotenv_path = os.path.abspath(os.path.join(os.path.dirname(__file__), "../docker/.env"))
load_dotenv(dotenv_path)

# Debugging: Print values
print("POSTGRES_DB:", os.getenv("POSTGRES_DB"))
print("POSTGRES_USER:", os.getenv("POSTGRES_USER"))
print("POSTGRES_PASSWORD:", os.getenv("POSTGRES_PASSWORD"))
print("POSTGRES_HOST:", os.getenv("POSTGRES_HOST"))
print("POSTGRES_PORT:", os.getenv("POSTGRES_PORT"))  # Check if it's None

# Construct the DATABASE_URL
DATABASE_URL = (
    f"dbname={os.getenv('POSTGRES_DB')} "
    f"user={os.getenv('POSTGRES_USER')} "
    f"password={os.getenv('POSTGRES_PASSWORD')} "
    f"host={os.getenv('POSTGRES_HOST')} "
    f"port={os.getenv('POSTGRES_PORT')} "
    f"sslmode=prefer"
)

print("DATABASE_URL:", DATABASE_URL)  # Debugging line

# Now try connecting to PostgreSQL
import psycopg2
conn = psycopg2.connect(DATABASE_URL)
print("✅ Connected successfully!")
