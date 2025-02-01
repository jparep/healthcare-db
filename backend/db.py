import os
import psycopg2
from dotenv import load_dotenv

load_dotenv("../docker/.env")

DATABASE_URL = f"dbname={os.getenv('POSTGRES_DB')} user={os.getenv('POSTGRES_USER')} password={os.getenv('POSTGRES_PASSWORD')} host={os.getenv('POSTGRES_HOST')}"

def get_db_connection():
    conn = psycopg2.connect(DATABASE_URL)
    return conn
