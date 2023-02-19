#!/bin/bash

# Set the name for the container
CONTAINER_NAME="my-postgres-container"

# Set the name for the image
IMAGE_NAME="my-postgres-image"

# Build the Docker image
docker build -t $IMAGE_NAME .

# Create and run the Docker container
docker run -d -p 5432:5432 --name $CONTAINER_NAME $IMAGE_NAME

# Wait for PostgreSQL to start up
echo "Waiting for PostgreSQL to start up..."
sleep 10

# Create a new database and user
echo "Creating database and user"
docker exec -it $CONTAINER_NAME psql -U postgres -c "CREATE DATABASE mydb;"
docker exec -it $CONTAINER_NAME psql -U postgres -c "CREATE USER myuser WITH ENCRYPTED PASSWORD 'mypassword';"
docker exec -it $CONTAINER_NAME psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;"

echo "PostgreSQL container is ready to use."
'chmod +x create-postgres-container.sh'
'./create-postgres-container.sh'