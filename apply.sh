#!/bin/bash
set -euo pipefail
source .env
kubectl create secret generic redis-secret \
  --from-literal=redis-password="$REDIS_PASSWORD" \
  --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f ./kuber/sec-redis.yml
kubectl apply -f ./kuber/dep-redis.yml
kubectl apply -f ./kuber/service_redis.yml
kubectl wait --for=condition=ready pod -l app=redis --timeout=20s
kubectl apply -f ./kuber/dep-nest.yml
kubectl apply -f ./kuber/service-nest.yml
kubectl apply -f ./kuber/ingress.yml

