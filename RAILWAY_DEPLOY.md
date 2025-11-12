# Deploying Campfire to Railway

This repo includes `railway.toml` which automatically configures build and deployment settings.

## What's Automated ✓

The `railway.toml` file configures:
- Docker build settings
- Start command (bin/boot)
- Health check settings
- Restart policy

The `docker-entrypoint.sh` script automatically:
- Fixes volume permissions (Railway volumes are owned by root)
- Drops privileges to the `rails` user before starting the app
- This solves the "Permission denied @ dir_s_mkdir" error

## What You Need to Configure Manually

### 1. Create a Volume (Required)

Campfire needs persistent storage for the SQLite database and file attachments.

**In Railway Dashboard:**
1. Right-click project canvas → "Create Volume" (or use ⌘K)
2. Mount path: `/rails/storage`
3. Recommended size: 10GB+ (depending on expected file attachments)

### 2. Set Environment Variables (Required)

**In Railway Dashboard → Variables tab, add:**

```bash
# Required
SECRET_KEY_BASE=<paste the generated value below>

# Recommended
DISABLE_SSL=true  # Railway handles SSL for you
```

**Optional variables** (see `.env.railway.example`):
- `VAPID_PUBLIC_KEY` / `VAPID_PRIVATE_KEY` - For push notifications
- `SENTRY_DSN` - For error tracking

### 3. Generate SECRET_KEY_BASE

Run this command on your local machine (no Ruby needed):

```bash
openssl rand -hex 64
```

Copy the output and paste it into Railway's `SECRET_KEY_BASE` environment variable.

**Optional: Generate VAPID keys for push notifications**

After deployment, open Railway shell and run:
```bash
./script/admin/create-vapid-key
```

Then add the output to Railway environment variables.


## First-Time Setup

After first deployment:
1. Visit your Railway URL
2. You'll be guided through creating an admin account
3. The admin email will show on the login page for password resets

