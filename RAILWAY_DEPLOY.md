# Deploying Campfire to Railway

This repo includes `railway.toml` which automatically configures build and deployment settings.

## What's Automated ✓

The `railway.toml` file configures:
- Docker build settings
- Start command (bin/boot)
- Health check settings
- Restart policy

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
SECRET_KEY_BASE=<generate with: rails secret>
RAILS_MASTER_KEY=<from config/master.key or generate new>

# Recommended
DISABLE_SSL=true  # Railway handles SSL for you
```

**Optional variables** (see `.env.railway.example`):
- `VAPID_PUBLIC_KEY` / `VAPID_PRIVATE_KEY` - For push notifications
- `SENTRY_DSN` - For error tracking

### 3. Generate Secrets

```bash
# Generate SECRET_KEY_BASE
rails secret
# or
openssl rand -hex 64

# For VAPID keys (after deployment, run in Railway shell)
./script/admin/create-vapid-key
```


## First-Time Setup

After first deployment:
1. Visit your Railway URL
2. You'll be guided through creating an admin account
3. The admin email will show on the login page for password resets

