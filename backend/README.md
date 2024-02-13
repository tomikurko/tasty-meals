# Tasty Meals backend

## Running the application

    $ docker compose up -d
    $ lein run

## Migrating the database

    $ docker compose exec postgres /db/run-migrations.sh

## Debugging

Clojure REPL can be launched as follows:

    $ lein repl

PostgreSQL database can be debugged using the psql tool:

    $ docker compose exec postgres /db/run-psql.sh
