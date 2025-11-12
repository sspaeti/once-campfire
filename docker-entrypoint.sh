#!/bin/bash
set -e

# Fix ownership of the storage volume (Railway volumes are owned by root)
if [ "$(id -u)" = "0" ]; then
    echo "Fixing permissions on /rails/storage..."
    mkdir -p /rails/storage
    chown -R rails:rails /rails/storage
    echo "Switching to rails user..."
    # Drop to rails user and execute the command
    exec gosu rails "$@"
else
    # Already running as non-root
    exec "$@"
fi
