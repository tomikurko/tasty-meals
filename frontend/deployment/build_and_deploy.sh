#!/bin/bash

FRONTEND_DIR=`pwd`/$(dirname $0)/..

cd ${FRONTEND_DIR} && \
  flutter build web --web-renderer canvaskit --base-href "/" && \
  aws s3 sync --delete build/web/ s3://www.tastymeals.site
