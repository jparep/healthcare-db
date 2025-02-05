# Use the official PostgreSQL image
FROM postgres:latest

# Set environment variables
ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
ENV POSTGRES_DB=${POSTGRES_DB}

# Create a directory inside the container for initialization scripts
RUN mkdir -p /docker-entrypoint-initdb.d/

# Copy initialization SQL scripts
COPY init_scripts/*.sql /docker-entrypoint-initdb.d/

# Copy CSV files for data loading
COPY ../data/*.csv /docker-entrypoint-initdb.d/

# Ensure proper permissions for execution
RUN chmod -R 755 /docker-entrypoint-initdb.d/

# Expose PostgreSQL default port
EXPOSE 5432
