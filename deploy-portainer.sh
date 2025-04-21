#!/bin/bash

# Deploy Portainer using Docker Compose
echo "🚀 Deploying Portainer..."
cat > ~/homelab/portainer/docker-compose.yml << 'EOF'
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
    external: true
EOF

# Create a directory for Portainer data
mkdir -p ~/homelab/portainer/data

# Start Portainer
echo "🚀 Starting Portainer..."
cd ~/homelab/portainer

# This lets you run Docker without needing sudo every time
sudo usermod -aG docker $USER

docker compose up -d