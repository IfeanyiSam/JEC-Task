#!/bin/bash

# Author: Nnanna Samuel Ifeanyi
# Role: DevOps Engineer
# Purpose: This script initializes the Rancher VM by installing the necessary dependencies

# Update system and install prerequisites
sudo apt-get update -y
sudo apt-get install ca-certificates curl -y

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list with Docker repository
sudo apt-get update -y

# Install Docker packages
sudo apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

# Create docker group and add ubuntu user
sudo groupadd docker || true
sudo usermod -aG docker ubuntu

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Wait for Docker to be ready
while ! sudo docker info > /dev/null 2>&1; do
    echo "Waiting for Docker to be ready..."
    sleep 5
done

# Install and run Rancher
echo "Starting Rancher container..."
sudo docker run --privileged -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher

# Wait briefly for container to start
sleep 10
