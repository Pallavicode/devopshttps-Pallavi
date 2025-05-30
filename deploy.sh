#!/bin/bash

# Exit if any command fails
set -e

# Configuration - replace with your Docker Hub username and repo
DOCKER_USERNAME="pallavidocker2024"
REPO_NAME="my-react-app"
TAG="latest"

# Docker image names
LOCAL_IMAGE="$REPO_NAME:$TAG"
REMOTE_IMAGE="$DOCKER_USERNAME/$REPO_NAME:$TAG"
CONTAINER_NAME="react-container"

echo "📦 Starting deployment..."

# Step 1: Docker login
echo "🔐 Logging into Docker Hub..."
docker login -u pallavidocker2024 -p dckr_pat_Y1hiaiJBkVErpE4WGqi0zLu0roc

# Step 2: Build Docker image
echo "🐳 Building Docker image: $LOCAL_IMAGE"
docker build -t $LOCAL_IMAGE .

# Step 3: Tag the image
echo "🏷️ Tagging image as: $REMOTE_IMAGE"
docker tag $LOCAL_IMAGE $REMOTE_IMAGE

# Step 4: Push to Docker Hub
echo "📤 Pushing image to Docker Hub..."
docker push $REMOTE_IMAGE

# Step 5: Stop and remove existing container (if any)
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
  echo "🛑 Stopping and removing existing container..."
  docker stop $CONTAINER_NAME
  docker rm $CONTAINER_NAME
fi

# Step 6: Run new container from pushed image
echo "🚀 Running container: $CONTAINER_NAME"
docker run -d -p 80:80 --name $CONTAINER_NAME $REMOTE_IMAGE

echo "✅ Deployment complete! App is running at: http://localhost"

