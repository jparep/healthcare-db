# Use the Official PostgreSQL image
FROM postgres:latest

# Set the environment variables
ENV POSTGRES_USER={POSTGRES_USER}
ENV POSTGRES_PASSWORD={POSTGRES_PASSWORD}
ENV POSTGRES_DB={POSTGRES_DB}

# Copy the SQL file to the container
COPY init_scripts/*.sql /docker-entrypoint-initdb.d/

# Expose the PostgreSQL port
EXPOSE 5432