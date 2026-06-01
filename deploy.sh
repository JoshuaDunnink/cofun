#!/usr/bin/env bash
# deploy.sh   Manual FTP deployment fallback (requires lftp)
# Usage: ./deploy.sh [production|staging]

set -euo pipefail

if [ ! -f .env ]; then
  echo "Error: .env file not found. Copy .env.example and fill in your credentials."
  exit 1
fi

# shellcheck disable=SC1091
source .env

# Optional first argument overrides DEPLOY_ENV from .env
deploy_env="${DEPLOY_ENV:-production}"
if [ "${1:-}" != "" ]; then
  deploy_env="$1"
fi

case "${deploy_env}" in
  production|staging)
    ;;
  *)
    echo "Error: DEPLOY_ENV must be 'production' or 'staging' (received: ${deploy_env})."
    exit 1
    ;;
esac

if [ "${deploy_env}" = "staging" ]; then
  build_cmd="npm run build:staging"
  default_remote_dir="/httpdocs/cofun/__development/"
else
  build_cmd="npm run build:prod"
  default_remote_dir="/httpdocs/"
fi

echo "==> Environment: ${deploy_env}"
echo "==> Building site (${build_cmd})..."
${build_cmd}

echo "==> Deploying to ${FTP_HOST}..."

# ensure lftp is installed; otherwise bail with instructions
if ! command -v lftp >/dev/null 2>&1; then
  cat <<'MSG'
Error: lftp is not installed. This deployment script requires lftp for
secure FTP transfers.

On Debian/Ubuntu:
  sudo apt update && sudo apt install lftp

Alternatively, adjust this script to use another tool such as sftp/sshpass.
MSG
  exit 1
fi

# use lftp for the transfer; credentials go with -u and we use sftp protocol.
# ensure the host key is known or auto-confirmed to avoid "Host key verification failed".
# we can add it to ~/.ssh/known_hosts or ask lftp to auto-confirm.

# try to add the host key to the user's known_hosts (quietly).
if command -v ssh-keyscan >/dev/null 2>&1; then
  ssh-keyscan -H "${FTP_HOST}" >> "${HOME}/.ssh/known_hosts" 2>/dev/null || true
fi

# determine remote directory locally so it expands correctly
remote_dir="${FTP_REMOTE_DIR:-${default_remote_dir}}"

echo "==> Target directory: ${remote_dir}"

lftp -u "${FTP_USER},${FTP_PASS}" sftp://"${FTP_HOST}" <<LFTP
set ssl:verify-certificate no
set sftp:auto-confirm yes
mirror --reverse --delete --verbose --parallel=4 \
  dist/ "${remote_dir}"
bye
LFTP

echo "==> Deployment complete!"
