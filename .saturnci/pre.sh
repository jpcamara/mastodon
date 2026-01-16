#!/bin/bash
set -e

echo "=== Starting pre.sh setup script ==="
echo "Current directory: $(pwd)"

# Install JavaScript dependencies into mounted directory
# This ensures all parallel test containers can use the same node_modules
echo "=== Installing JavaScript dependencies ==="
if [ -d "node_modules" ]; then
  echo "✓ node_modules already exists, skipping install"
  echo "node_modules size: $(du -sh node_modules | cut -f1)"
else
  echo "Installing node_modules..."
  yarn install
  echo "✓ node_modules installed"
  echo "node_modules size: $(du -sh node_modules | cut -f1)"
fi

# Prepare the database
echo "=== Preparing database ==="
bundle exec rails db:prepare

echo "=== pre.sh setup script completed successfully ==="
