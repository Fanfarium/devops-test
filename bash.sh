#!/bin/bash
set -euo pipefail

if [ -z "${REDIS_PASSWORD:-}" ]; then
  echo "ERROR: REDIS_PASSWORD is not set"
  exit 1
fi

REDIS_PASSWORD_B64=$(echo -n "$REDIS_PASSWORD" | base64)

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: redis-secret
type: Opaque
data:
  redis-password: $REDIS_PASSWORD_B64
EOF

echo "Redis secret applied"
