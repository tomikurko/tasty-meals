#!/bin/bash

BACKEND_DIR=$(dirname $0)/..

cd ${BACKEND_DIR} && \
  echo -e "\n>> Migrating production database ..\n" && \
  ssh tastymeals \
      "cd ~/tastymeals && " \
      "docker compose exec postgres /db/run-migrations.sh"
