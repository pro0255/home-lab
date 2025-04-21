#!/bin/bash
set -e

echo "==============================================="
echo "🏡 Setting up Home Lab with Portainer"
echo "==============================================="

# Update and upgrade system
echo "🔄 Updating system packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install nano -y

echo "📦 Installing dependencies..."
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release