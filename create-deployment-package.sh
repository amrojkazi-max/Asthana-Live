#!/bin/bash

echo "Creating deployment package for Asthana Live..."

# Create a temporary directory
mkdir -p /tmp/asthana-live-deploy

# Copy project files excluding unnecessary items
rsync -av --progress \
  --exclude 'node_modules' \
  --exclude '.git' \
  --exclude '*.log' \
  --exclude '.replit' \
  --exclude 'replit.nix' \
  --exclude '.config' \
  --exclude '.cache' \
  --exclude 'dist' \
  --exclude '.next' \
  --exclude 'create-deployment-package.sh' \
  /home/runner/workspace/ \
  /tmp/asthana-live-deploy/

# Create the zip file
cd /tmp
zip -r asthana-live-hostinger.zip asthana-live-deploy/

# Move to workspace for download
mv asthana-live-hostinger.zip /home/runner/workspace/

# Cleanup
rm -rf /tmp/asthana-live-deploy

echo "✅ Package created: asthana-live-hostinger.zip"
echo "📦 You can download this file from the Files panel"
ls -lh /home/runner/workspace/asthana-live-hostinger.zip
