#!/usr/bin/env bash
# deploy.sh — Manual FTP deployment fallback (requires lftp)
# Usage: ./deploy.sh

set -euo pipefail

if [ ! -f .env ]; then
  echo "Error: .env file not found. Copy .env.example and fill in your credentials."
  exit 1
fi

# shellcheck disable=SC1091
source .env

echo "==> Building site..."
npm run build

echo "==> Deploying to ${FTP_HOST}..."
lftp -u "${FTP_USER},${FTP_PASS}" "${FTP_HOST}" <<EOF
set ssl:verify-certificate no
mirror --reverse --delete --verbose --parallel=4 \
  dist/ ${FTP_REMOTE_DIR:-/httpdocs/}
bye
EOF

echo "==> Deployment complete!"
