#!/bin/bash
set -e

echo "======================================"
echo " Multi-Architecture Docker Build      "
echo "======================================"

IMAGE_NAME="lc1868/wacrm:latest"

# Setup buildx builder if it doesn't exist
docker buildx create --name multiarch-builder --use || true

# Get the absolute path to the project root
PROJECT_ROOT=$(cd "$(dirname "$0")/.." && pwd)

echo "Building and pushing multi-arch images (amd64, arm64) for $IMAGE_NAME..."
# Using the project root as the build context
docker buildx build --platform linux/amd64,linux/arm64 -t $IMAGE_NAME --push "$PROJECT_ROOT"

echo "======================================"
echo " Build and push complete!             "
echo "======================================"
