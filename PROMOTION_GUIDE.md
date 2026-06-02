# Promotion & Rollback Guide

## Overview

The promotion system allows you to safely move your site from the `__development/` environment to production while maintaining the ability to rollback.

### Key Features
- ✅ **Automatic config updates** - Updates `astro.config.mjs` to production URLs
- ✅ **Automatic backups** - Creates timestamped backups before each promotion
- ✅ **Idempotent** - Safe to run multiple times (backups are unique per run)
- ✅ **Rollback capability** - Can restore any previous backup
- ✅ **Error handling** - Automatically restores config on failure

## Workflow

### 1. **Develop and Test**
```bash
npm run dev          # Local development
.\deploy.cmd         # Deploy to __development/ for testing
```

### 2. **Promote to Production**

**Windows:**
```powershell
.\promote.cmd
# Or with PowerShell directly:
.\promote.ps1
```

**Mac/Linux:**
```bash
chmod +x promote.sh rollback.sh
./promote.sh
```

The promote script will:
1. ✓ Backup current production to timestamped folder
2. ✓ Update `astro.config.mjs` for production:
   - `site: 'https://cofun.nl/cofun/'`
   - `base: '/cofun/'`
3. ✓ Rebuild the site
4. ✓ Upload to production
5. ✓ Remove the `__development/` directory

### **⚠️ CRITICAL: Clear Browser Cache After Promotion**

After promotion completes, you **MUST clear your browser cache** to see the new production site:

**Instructions:**
1. Press `Ctrl+Shift+Delete` (Windows/Linux) or `Cmd+Shift+Delete` (Mac)
2. Select "All time" or "Everything"
3. Check: Cookies, Cached images and files
4. Click "Clear data"
5. Go to your site and press `Ctrl+F5` (Windows) or `Cmd+Shift+R` (Mac) for a hard refresh

**Why?** The old development site (`__development/`) may be cached in your browser's local storage, service workers, or cookies. The navigation links are correct in the new production site, but old caches can interfere with page navigation.

### 3. **Rollback (if needed)**

**List available backups:**
```powershell
# Windows
.\rollback.cmd

# Mac/Linux
./rollback.sh
```

**Restore a specific backup:**
```powershell
# Windows
.\rollback.ps1 -BackupId 20260602-214325

# Mac/Linux
./rollback.sh -b 20260602-214325
```

The rollback script will:
1. ✓ Restore `astro.config.mjs` to development settings
2. ✓ Upload backup files back to production
3. ✓ Restore the previous state

## Backup Storage

- **Windows:** `%LOCALAPPDATA%\CoFun\promote-backups`
- **Mac/Linux:** `~/.cofun-backups/`

Each backup is named with a timestamp: `production-YYYYMMDD-HHMMSS`

A metadata file tracks all backups for easy reference.

## Configuration

Default paths are:
- Development: `/cofun/cofun/__development/`
- Production: `/cofun/cofun/`

Override in `.env`:
```env
FTP_DEVELOPMENT_DIR=/cofun/cofun/__development/
FTP_PRODUCTION_DIR=/cofun/cofun/
```

## Idempotency

The scripts are idempotent, meaning you can:
- Run promotion multiple times (each creates a unique backup)
- Rollback and then promote again
- Cancel a promotion and try again

No data will be lost due to running scripts multiple times.

## Troubleshooting

**Navigation still broken after promotion:**
1. Clear your browser cache (Ctrl+Shift+Delete)
2. Hard refresh the page (Ctrl+F5)
3. Check for service worker/offline data in DevTools

**Build fails:** Fix the build errors, then run promote again. Config is restored on failure.

**Upload fails:** Run promote again. The backup still exists so you can rollback.

**Need to view changes:** Check `astro.config.mjs` - you'll see the site and base URLs updated to production or development depending on the last operation.

## Required Tools

- **Windows:** WinSCP (auto-located from PATH or Program Files)
- **Mac/Linux:** lftp and jq (for reading backup metadata)

Install missing tools:
```bash
# Mac
brew install lftp jq

# Linux (Debian/Ubuntu)
sudo apt install lftp jq
```
