#!/bin/bash
set -euo pipefail

if [ -z "${REDIS_PASSWORD:-}" ]; then
  read -s -p "Enter Redis password: " REDIS_PASSWORD
  echo
fi
REDIS_CONTAINER_NAME="my-redis"
NEST_CONTAINER_NAME="nestjs-app"
NEST_IMAGE="manyok007/devops-test:latest"
NETWORK_NAME="my-network"
if ! docker network inspect $NETWORK_NAME >/dev/null 2>&1; then
  docker network create $NETWORK_NAME
fi
if docker ps -a --format '{{.Names}}' | grep -Eq "^${REDIS_CONTAINER_NAME}$"; then
  echo "Stopping and removing existing Redis container..."
  docker rm -f $REDIS_CONTAINER_NAME
fi
docker run -d --name $REDIS_CONTAINER_NAME --network $NETWORK_NAME \
  -e REDIS_PASSWORD="$REDIS_PASSWORD" \
  redis:7 redis-server --requirepass "$REDIS_PASSWORD"
if docker ps -a --format '{{.Names}}' | grep -Eq "^${NEST_CONTAINER_NAME}$"; then
  echo "Stopping and removing existing NestJS container..."
  docker rm -f $NEST_CONTAINER_NAME
fi
docker run -d --name $NEST_CONTAINER_NAME --network $NETWORK_NAME -p 3000:3000 \
  -e REDIS_HOST=$REDIS_CONTAINER_NAME \
  -e REDIS_PASSWORD="$REDIS_PASSWORD" \
  $NEST_IMAGE
echo "Containers are running:"
docker ps --filter "name=$REDIS_CONTAINER_NAME" --filter "name=$NEST_CONTAINER_NAME"
