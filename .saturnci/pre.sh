#!/bin/bash
set -e

echo "=== Starting pre.sh setup script ==="
echo "Current directory: $(pwd)"

# Verify node_modules from Docker image is available via named volume
echo "=== Verifying node_modules ==="
if [ -d "node_modules" ]; then
  echo "✓ node_modules exists"
  echo "node_modules size: $(du -sh node_modules 2>/dev/null | cut -f1 || echo 'unable to calculate')"
else
  echo "✗ ERROR: node_modules not found!"
  exit 1
fi

# Prepare the database
echo "=== Preparing database ==="
bundle exec rails db:prepare

echo "=== pre.sh setup script completed successfully ==="
