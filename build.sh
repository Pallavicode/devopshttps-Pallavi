#!/bin/bash

# Exit on any error
set -e

# Set image name and optional tag
IMAGE_NAME="my-react-app"
TAG="latest"

# Full image name
FULL_IMAGE_NAME="$IMAGE_NAME:$TAG"

echo "🐳 Building Docker image: $FULL_IMAGE_NAME"

# Run Docker build
docker build -t $FULL_IMAGE_NAME .

echo "✅ Docker image '$FULL_IMAGE_NAME' built successfully!"

