#!/usr/bin/env bash
# rollback.sh   Rollback to a previous production backup
# Usage: ./rollback.sh [-b BACKUP_ID]

set -euo pipefail

backup_id=""
metadata_file="${BACKUP_DIR:-$HOME/.cofun-backups}/backups.json"

while getopts "b:" opt; do
  case $opt in
    b)
      backup_id="$OPTARG"
      ;;
    *)
      echo "Usage: $0 [-b BACKUP_ID]"
      exit 1
      ;;
  esac
done

if [ ! -f .env ]; then
  echo "Error: .env file not found. Copy .env.example and fill in your credentials."
  exit 1
fi

# shellcheck disable=SC1091
source .env

if [ -z "${FTP_USER:-}" ]; then
  read -r -p "FTP username: " FTP_USER
fi

if [ -z "${FTP_PASS:-}" ]; then
  read -r -s -p "FTP password: " FTP_PASS
  printf '\n'
fi

# determine remote directories locally so they expand correctly
production_dir="${FTP_PRODUCTION_DIR:-/cofun/cofun/}"

# If no backup ID provided, list available backups
if [ -z "$backup_id" ]; then
  echo "=========================================="
  echo "  Available Backups"
  echo "=========================================="
  echo ""
  
  if [ ! -f "$metadata_file" ]; then
    echo "No backups found."
    exit 1
  fi
  
  # Parse JSON and display backups
  jq -r '.[] | "ID:       \(.timestamp)\nDate:     \(.promotion_date)\nBackup:   \(.backup_path)\n"' "$metadata_file"
  
  echo "To rollback, run:"
  echo "  ./rollback.sh -b <ID>"
  echo ""
  exit 0
fi

# Verify backup exists
if [ ! -f "$metadata_file" ]; then
  echo "✗ No backups found"
  exit 1
fi

backup_info=$(jq -r ".[] | select(.timestamp == \"$backup_id\") | @json" "$metadata_file" 2>/dev/null || true)

if [ -z "$backup_info" ]; then
  echo "✗ Backup not found: $backup_id"
  echo ""
  echo "Available backups:"
  jq -r '.[] | "  - \(.timestamp)"' "$metadata_file"
  exit 1
fi

backup_path=$(echo "$backup_info" | jq -r '.backup_path')

if [ ! -d "$backup_path" ]; then
  echo "✗ Backup files not found: $backup_path"
  exit 1
fi

# ensure lftp is installed; otherwise bail with instructions
if ! command -v lftp >/dev/null 2>&1; then
  cat <<'MSG'
Error: lftp is not installed. This rollback script requires lftp for
secure FTP transfers.

On Debian/Ubuntu:
  sudo apt update && sudo apt install lftp

Alternatively, adjust this script to use another tool such as sftp/sshpass.
MSG
  exit 1
fi

# try to add the host key to the user's known_hosts (quietly).
if command -v ssh-keyscan >/dev/null 2>&1; then
  ssh-keyscan -H "${FTP_HOST}" >> "${HOME}/.ssh/known_hosts" 2>/dev/null || true
fi

try_again='yes'
while [ "$try_again" = 'yes' ]; do
  echo "=========================================="
  echo "  CoFun Site Rollback"
  echo "=========================================="
  echo ""
  echo "Backup ID:  $backup_id"
  echo "Backup:     $backup_path"
  echo "Target:     $production_dir"
  echo ""
  
  read -r -p "Are you sure you want to rollback? (yes/no): " confirm
  
  if [ "$confirm" != 'yes' ]; then
    echo "Rollback cancelled."
    exit 0
  fi
  
  try_again='no'
done

# Step 1: Restore Astro config to development settings
echo ""
echo "==> Step 1/2: Restoring Astro configuration to development settings..."

if [ ! -f astro.config.mjs ]; then
  echo "Error: Astro config file not found: astro.config.mjs"
  exit 1
fi

# Use sed to update the config
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  sed -i '' "s|site: '[^']*'|site: 'https://cofun.nl/cofun/__development/'|g" astro.config.mjs
  sed -i '' "s|base: '[^']*'|base: '/cofun/__development/'|g" astro.config.mjs
else
  # Linux
  sed -i "s|site: '[^']*'|site: 'https://cofun.nl/cofun/__development/'|g" astro.config.mjs
  sed -i "s|base: '[^']*'|base: '/cofun/__development/'|g" astro.config.mjs
fi

echo "    ✓ Updated site URL to: https://cofun.nl/cofun/__development/"
echo "    ✓ Updated base path to: /cofun/__development/"

# Step 2: Restore backup files
echo "==> Step 2/2: Restoring backup files to production..."

lftp -u "${FTP_USER},${FTP_PASS}" sftp://"${FTP_HOST}" <<LFTP
set ssl:verify-certificate no
set sftp:auto-confirm yes
mirror --reverse --delete --verbose --parallel=4 \
  "${backup_path}" "${production_dir}"
bye
LFTP

echo ""
echo "=========================================="
echo "✓ Rollback Complete!"
echo "=========================================="
echo ""
echo "Your site has been restored to the previous version."
echo ""
