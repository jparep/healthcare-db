import os
import psycopg2
import psycopg2.extras
from dotenv import load_dotenv
from contextlib import contextmanager

# ✅ 1. Load Environment Variables Securely
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
load_dotenv(os.path.join(BASE_DIR, "../docker/.env"))

# ✅ 2. Construct the Database Connection String Securely
DATABASE_URL = (
    f"dbname={os.getenv('POSTGRES_DB')} "
    f"user={os.getenv('POSTGRES_USER')} "
    f"password={os.getenv('POSTGRES_PASSWORD')} "
    f"host={os.getenv('POSTGRES_HOST')} "
    f"port={os.getenv('POSTGRES_PORT')} "
    f"sslmode=prefer"  # Enables SSL if available
)

# ✅ 3. Context Manager for Database Connection (Auto-Close & Error Handling)
@contextmanager
def get_db_connection():
    conn = None
    try:
        conn = psycopg2.connect(DATABASE_URL, cursor_factory=psycopg2.extras.DictCursor)
        yield conn
    except psycopg2.Error as e:
        print(f"❌ Database connection error: {e}")
    finally:
        if conn:
            conn.close()
