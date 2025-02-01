# Use the official PostgreSQL image
FROM postgres:latest

# Set environment variables
ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
ENV POSTGRES_DB=${POSTGRES_DB}

# Copy initialization scripts to the PostgreSQL container
COPY init_scripts/*.sql /docker-entrypoint-initdb.d/

# Expose PostgreSQL port
EXPOSE 5432
