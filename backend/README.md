# Tasty Meals backend

## Running the application

    $ docker compose up -d

Docker launches both the backend server and the PostgreSQL database.

## Migrating the database

    $ docker compose exec postgres /db/run-migrations.sh

## Debugging

Clojure REPL can be launched as follows:

    $ lein repl

PostgreSQL database can be debugged using the psql tool:

    $ docker compose exec postgres /db/run-psql.sh

## Deployment

### Prerequisites

In order to be able to deploy to AWS, we have to log in first:

    $ aws sso login

The deployment scripts also require that the user's SSH configuration (~/.ssh/config)
contains a configuration for host 'tastymeals'.

    $ cat ~/.ssh/config
    Host tastymeals
        HostName <server-address-here>
        User <user-here>
        Port <port-here>

### Deployment scripts

First, the backend image needs to be built and deployed:

    $ deployment/deploy-backend-image.sh

Possible existing installation can be removed as follows:

    $ deployment/purge-installation.sh

A fresh install can be done as follows:

    $ deployment/fresh-install.sh

If there is a need to run database migrations separately, it can be done with
the following script:

    $ deployment/migrate-db.sh
