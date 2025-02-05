# Use the official PostgreSQL image
FROM postgres:latest

# Set build arguments (used during build)
ARG POSTGRES_USER
ARG POSTGRES_PASSWORD
ARG POSTGRES_DB

# Set environment variables (used at runtime)
ENV POSTGRES_USER=$POSTGRES_USER
ENV POSTGRES_PASSWORD=$POSTGRES_PASSWORD
ENV POSTGRES_DB=$POSTGRES_DB

# Create a directory for initialization scripts
RUN mkdir -p /docker-entrypoint-initdb.d/

# Copy initialization scripts
COPY init_scripts/*.sql /docker-entrypoint-initdb.d/

# ✅ Fix: Copy CSV files using correct relative path
COPY data/*.csv /docker-entrypoint-initdb.d/

# Ensure proper permissions
RUN chmod -R 755 /docker-entrypoint-initdb.d/

# Expose PostgreSQL internal port
EXPOSE 5432
