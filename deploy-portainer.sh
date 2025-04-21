#!/bin/bash

# Deploy Portainer using Docker Compose
echo "🚀 Deploying Portainer..."
cat > ~/homelab/portainer/docker-compose.yml << 'EOF'
version: '3'

services:
  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./data:/data
    ports:
      - 9000:9000
      - 8000:8000
    networks:
      - homelab

networks:
  homelab:
    driver: bridge
EOF

# Create a directory for Portainer data
mkdir -p ~/homelab/portainer/data

# Start Portainer
echo "🚀 Starting Portainer..."
cd ~/homelab/portainer
docker-compose up -d