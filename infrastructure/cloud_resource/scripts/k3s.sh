#!/bin/bash

# Author: Nnanna Samuel Ifeanyi
# Role: DevOps Engineer
# Purpose: This script initializes the K3s VM by installing the necessary dependencies

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

# Verify Docker installation
docker --version >> /var/log/docker-install.log 2>&1

# Reboot the instance
sudo reboot

# Install terraform

## set up repo
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common -y

#Install the HashiCorp GPG key.
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# verify key
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

## add official hashicorp repo
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

## Install Terraform

sudo apt-get install terraform

