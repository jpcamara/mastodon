#!/bin/bash
set -e

# Precompile assets using Vite
echo "Precompiling assets..."
bundle exec rails vite:build_all

# Prepare the database
echo "Preparing database..."
bundle exec rails db:prepare
