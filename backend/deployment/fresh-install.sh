#!/bin/bash

DEPLOYMENT_DIR=$(dirname $0)
DB_DIR=${DEPLOYMENT_DIR}/../resources/db

echo -e -n "\n>> PostgreSQL password: "
read -s POSTGRES_PASSWORD
echo -e "\n"

echo -e "\n>> Copying files to the production server ..\n"
scp -r ${DEPLOYMENT_DIR}/tastymeals tastymeals:~
scp -r ${DB_DIR} tastymeals:~/tastymeals/

echo -e "\n>> Starting up the servers ..\n"
ssh tastymeals \
    "sed -i 's/POSTGRES_PASSWORD=.*/POSTGRES_PASSWORD=${POSTGRES_PASSWORD}/' ~/tastymeals/.env && " \
    "cd ~/tastymeals && " \
    "docker pull public.ecr.aws/o6b6o8s4/tastymeals && " \
    "docker-compose up -d"

echo -e "\n>> Waiting for PostgreSQL to start up ...\n"
sleep 10

${DEPLOYMENT_DIR}/migrate-db.sh

echo -e "\n\n>> Tasty Meals production system installation completed.\n"
