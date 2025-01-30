# Healthcare Database Setup with PostgreSQL and Docker

This guide will help you set up a PostgreSQL database using Docker for the healthcare project.

## Prerequisites

- Docker installed on your machine
- Docker Compose installed on your machine

## Steps

1. **Clone the Repository**

    ```sh
    git clone https://github.com/jparep/healthcare-db.git
    cd healthcare-db
    ```

2. **Create a Docker Compose File**

    Create a `docker-compose.yml` file with the following content:

    ```yaml
    version: '3.1'

    services:
      db:
         image: postgres:latest
         environment:
            POSTGRES_USER: yourusername
            POSTGRES_PASSWORD: yourpassword
            POSTGRES_DB: healthcare
         ports:
            - "5432:5432"
         volumes:
            - db_data:/var/lib/postgresql/data

    volumes:
      db_data:
    ```

3. **Start the PostgreSQL Container**

    Run the following command to start the PostgreSQL container:

    ```sh
    docker-compose up -d
    ```

4. **Access the PostgreSQL Database**

    You can access the PostgreSQL database using any PostgreSQL client. Use the following credentials:

    - Host: `localhost`
    - Port: `5432`
    - Username: `yourusername`
    - Password: `yourpassword`
    - Database: `healthcare`

5. **Stop the PostgreSQL Container**

    To stop the PostgreSQL container, run:

    ```sh
    docker-compose down
    ```

## Additional Information

- To view logs, use `docker-compose logs`.
- To access the running container, use `docker exec -it <container_id> bash`.

For more information on Docker and PostgreSQL, refer to their official documentation.
