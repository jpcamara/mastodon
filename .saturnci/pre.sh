#!/bin/bash
set -e

# Install JavaScript dependencies
echo "Installing JavaScript dependencies..."
yarn install

# Precompile assets using Vite
echo "Precompiling assets..."
bundle exec rails vite:build_all

# Prepare the database
echo "Preparing database..."
bundle exec rails db:prepare
