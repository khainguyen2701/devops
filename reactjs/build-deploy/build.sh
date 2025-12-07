#!/bin/bash

IMAGE_NAME="react-demo:build"
TEMP_CONTAINER="react-temp"

echo "🚀 Building image..."
sudo docker-compose build

echo "📦 Creating temp container..."
sudo docker create --name $TEMP_CONTAINER $IMAGE_NAME > /dev/null

echo "📁 Copying dist to host..."
sudo rm -rf ./dist
sudo docker cp $TEMP_CONTAINER:/output/dist ./dist

echo "🧹 Cleaning up..."
sudo docker rm $TEMP_CONTAINER > /dev/null

echo "🎉 Done! Dist is ready at ./dist"