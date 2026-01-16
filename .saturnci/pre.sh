#!/bin/bash
set -e

echo "=== Starting pre.sh setup script ==="
echo "Current directory: $(pwd)"

# Verify node_modules from Docker image is available
echo "=== Verifying node_modules from Docker image ==="
if [ -d "node_modules" ]; then
  echo "✓ node_modules directory exists (from Docker image)"
  echo "node_modules size: $(du -sh node_modules | cut -f1)"
else
  echo "✗ WARNING: node_modules not found, installing..."
  yarn install
fi

# Prepare the database
echo "=== Preparing database ==="
bundle exec rails db:prepare

echo "=== pre.sh setup script completed successfully ==="
