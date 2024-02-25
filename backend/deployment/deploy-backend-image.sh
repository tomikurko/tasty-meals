#!/bin/bash

BACKEND_DIR=`pwd`/$(dirname $0)/..

cd ${BACKEND_DIR} && \
  echo -e "\n>> Building image ..\n" &&
  docker compose build server && \
  echo -e "\n\n>> Pushing image to AWS Elastic Container Registry ..\n" &&
  aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/o6b6o8s4 &&
  docker image tag tastymeals/server:latest public.ecr.aws/o6b6o8s4/tastymeals:latest && \
  docker image push public.ecr.aws/o6b6o8s4/tastymeals:latest

echo -e "\n>> Done.\n"
