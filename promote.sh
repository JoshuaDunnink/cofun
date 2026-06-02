#!/usr/bin/env bash
# promote.sh   Promote development site to production and remove development path
# Usage: ./promote.sh

set -euo pipefail

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
development_dir="${FTP_DEVELOPMENT_DIR:-/cofun/cofun/__development/}"
production_dir="${FTP_PRODUCTION_DIR:-/cofun/cofun/}"
backup_timestamp=$(date +%Y%m%d-%H%M%S)
backup_dir="${BACKUP_DIR:-$HOME/.cofun-backups}/production-${backup_timestamp}"

echo "=========================================="
echo "  CoFun Site Promotion to Production"
echo "=========================================="
echo ""
echo "Source:      ${development_dir}"
echo "Target:      ${production_dir}"
echo "Backup:      ${backup_dir}"
echo ""

# ensure lftp is installed; otherwise bail with instructions
if ! command -v lftp >/dev/null 2>&1; then
  cat <<'MSG'
Error: lftp is not installed. This promotion script requires lftp for
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

# Step 1: Create backup
echo "==> Step 1/5: Backing up current production..."
mkdir -p "${backup_dir}"

lftp -u "${FTP_USER},${FTP_PASS}" sftp://"${FTP_HOST}" <<LFTP > /dev/null 2>&1
set ssl:verify-certificate no
set sftp:auto-confirm yes
mirror --reverse --delete --verbose --parallel=4 \
  "${production_dir}" "${backup_dir}"
bye
LFTP

# Step 2: Update Astro config for production
production_site_url="https://cofun.nl/"
production_base="/"

if [ ! -f astro.config.mjs ]; then
  echo "Error: Astro config file not found: astro.config.mjs"
  exit 1
fi

# Use sed to update the config (works on both GNU and BSD sed)
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  sed -i '' "s|site: '[^']*'|site: '${production_site_url}'|g" astro.config.mjs
  sed -i '' "s|base: '[^']*'|base: '${production_base}'|g" astro.config.mjs
else
  # Linux
  sed -i "s|site: '[^']*'|site: '${production_site_url}'|g" astro.config.mjs
  sed -i "s|base: '[^']*'|base: '${production_base}'|g" astro.config.mjs
fi

echo "    ✓ Updated site URL to: ${production_site_url}"
echo "    ✓ Updated base path to: ${production_base}"

# Step 3: Rebuild site
echo "==> Step 3/5: Rebuilding site for production..."
npm run build

# Step 4: Upload files to production
echo "==> Step 4/5: Uploading files to production..."

lftp -u "${FTP_USER},${FTP_PASS}" sftp://"${FTP_HOST}" <<LFTP
set ssl:verify-certificate no
set sftp:auto-confirm yes
mirror --reverse --delete --verbose --parallel=4 \
  dist/ "${production_dir}"
bye
LFTP

# Step 5: Remove development directory
echo "==> Step 5/5: Cleaning up development directory..."

lftp -u "${FTP_USER},${FTP_PASS}" sftp://"${FTP_HOST}" <<LFTP > /dev/null 2>&1
set ssl:verify-certificate no
set sftp:auto-confirm yes
rmdir -r -f "${development_dir}"
bye
LFTP

# Save backup metadata
metadata_file="${BACKUP_DIR:-$HOME/.cofun-backups}/backups.json"
mkdir -p "$(dirname "$metadata_file")"

# Append backup metadata (simple JSON array)
backup_entry="{\"timestamp\": \"${backup_timestamp}\", \"backup_path\": \"${backup_dir}\", \"promotion_date\": \"$(date '+%Y-%m-%d %H:%M:%S')\", \"development_dir\": \"${development_dir}\", \"production_dir\": \"${production_dir}\"}"

if [ -f "$metadata_file" ]; then
  # Remove closing bracket and add new entry
  temp_file="${metadata_file}.tmp"
  head -c -2 "$metadata_file" > "$temp_file"
  echo ", $backup_entry]" >> "$temp_file"
  mv "$temp_file" "$metadata_file"
else
  echo "[$backup_entry]" > "$metadata_file"
fi

echo ""
echo "=========================================="
echo "✓ Promotion Complete!"
echo "=========================================="
echo ""
echo "Your site is now live in production!"
echo "Backup ID: ${backup_timestamp}"
echo ""
echo "To rollback if needed, run:"
echo "  ./rollback.sh -b ${backup_timestamp}"
echo ""
