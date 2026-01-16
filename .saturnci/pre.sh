#!/bin/bash
set -e

echo "=== Starting pre.sh setup script ==="
echo "Current directory: $(pwd)"
echo "Checking for package.json..."
ls -la package.json

# Install JavaScript dependencies
echo "=== Installing JavaScript dependencies ==="
echo "Yarn version: $(yarn --version)"
yarn install

echo "=== Verifying node_modules installation ==="
if [ -d "node_modules" ]; then
  echo "✓ node_modules directory exists"
  echo "node_modules size: $(du -sh node_modules | cut -f1)"
else
  echo "✗ ERROR: node_modules directory not found!"
  exit 1
fi

# Precompile assets using Vite
echo "=== Precompiling assets ==="
bundle exec rails vite:build_all

# Prepare the database
echo "=== Preparing database ==="
bundle exec rails db:prepare

echo "=== pre.sh setup script completed successfully ==="
