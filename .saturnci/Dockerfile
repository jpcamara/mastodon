# SaturnCI Test Environment Docker Image
#
# This Dockerfile creates the container image that SaturnCI uses to run
# your tests. It includes all necessary dependencies for a Rails application with
# PostgreSQL and handles asset precompilation during the build process.
#
# This image is used by .saturnci/docker-compose.yml to create the test execution environment.

# Use ruby:3.3.5-slim as the base image. This provides a pre-built Linux
# environment with Ruby already installed. The "slim" version contains only
# essential packages, making it smaller and faster to download.
FROM ruby:3.3.5-slim

# Set /app as the working directory. All subsequent commands will run from here.
WORKDIR /app

ENV RAILS_ENV=test

# Update the package list to get the latest available packages.
RUN apt-get update && apt-get install -y \
    # Install compilers and build tools needed for native gem compilation.
    build-essential \
    # Install PostgreSQL client libraries for database connections.
    libpq-dev \
    # Install version control system for dependency management.
    git \
    # Install curl for downloading Node.js setup script.
    curl \
    # Install additional dependencies for Mastodon gems
    libidn-dev \
    libicu-dev \
    libssl-dev \
    libgdbm-dev \
    libglib2.0-dev \
    libgmp-dev \
    libyaml-dev \
    pkg-config \
    shared-mime-info \
    # libvips for image processing
    libvips42 \
    libvips-dev \
    libcgif-dev \
    libexif-dev \
    libexpat1-dev \
    libgirepository1.0-dev \
    libheif-dev \
    libhwy-dev \
    libimagequant-dev \
    libjpeg62-turbo-dev \
    liblcms2-dev \
    libspng-dev \
    libtiff-dev \
    libwebp-dev \
    # Clean up package cache to reduce image size.
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20.x (required for Mastodon)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Enable Corepack for yarn (Mastodon uses yarn 4.12.0)
RUN corepack enable

COPY Gemfile Gemfile.lock ./
RUN bundle install && rm -rf /usr/local/bundle/cache/*

# Copy all application files. Use .dockerignore to exclude unnecessary files.
COPY . ./

# For tests, we don't need to precompile assets during build.
# Assets will be compiled on-demand or can be precompiled in the test setup.
# This significantly reduces build time.

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
