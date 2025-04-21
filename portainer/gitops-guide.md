# GitOps with Portainer: Simplifying Self-Hosted Application Deployment

This guide explains how to set up a GitOps workflow with Portainer for your home lab. Using GitOps, you can manage all your self-hosted applications through Git repositories, making deployments reproducible and version-controlled.

## Prerequisites

- Portainer CE installed and running
- GitHub account
- Basic knowledge of Docker Compose

## Setting Up GitOps Workflow

### 1. Create a GitHub Repository

First, create a repository to store your stack definitions:

1. Go to [GitHub](https://github.com) and create a new repository
2. Name it something like `homelab-stacks`
3. Make it private if your configurations contain sensitive information

### 2. Structure Your Repository

Organize your repository with a clear structure:

```
homelab-stacks/
├── README.md
├── media/
│   └── docker-compose.yml
├── monitoring/
│   └── docker-compose.yml
├── databases/
│   └── docker-compose.yml
└── other-services/
    └── docker-compose.yml
```

Each folder represents a logical group of services with its own `docker-compose.yml` file.

### 3. Add Stack Definitions

Create Docker Compose files for each stack you want to deploy. Here's an example for a media stack:

```yaml
version: '3'

services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    restart: unless-stopped
    volumes:
      - ./config:/config
      - ./media:/media
    ports:
      - 8096:8096
    networks:
      - homelab

networks:
  homelab:
    external: true
```

### 4. Connect Portainer to Your GitHub Repository

1. Log in to Portainer
2. Navigate to "Stacks" in the sidebar
3. Click "Add stack"
4. Select "Git repository" as the build method
5. Configure the repository settings:
   - Repository URL: Your GitHub repository URL
   - Reference: `refs/heads/main` (or your branch)
   - Repository authentication: Use your GitHub credentials or a Personal Access Token
   - Compose path: Path to the compose file (e.g., `media/docker-compose.yml`)

6. Click "Deploy the stack"

### 5. Automated Updates

To have Portainer automatically update your stacks when changes are pushed to GitHub:

1. In your stack settings, enable "Auto update"
2. Set a polling interval (e.g., every hour)
3. Choose which webhook URLs to trigger

Alternatively, you can set up GitHub webhooks to trigger updates when you push changes.

## Best Practices

1. **Use Environment Variables**: Store sensitive information in environment files
2. **Version Pinning**: Use specific version tags for container images
3. **Volume Management**: Use named volumes for persistent data
4. **Network Isolation**: Create separate networks for related services
5. **Documentation**: Document your services in the README.md

## Example Stacks

Here are some stacks you might want to add to your home lab:

### Monitoring Stack

```yaml
version: '3'

services:
  grafana:
    image: grafana/grafana:latest
    ports:
      - 3000:3000
    volumes:
      - ./grafana:/var/lib/grafana
    networks:
      - homelab

  prometheus:
    image: prom/prometheus:latest
    ports:
      - 9090:9090
    volumes:
      - ./prometheus:/etc/prometheus
    networks:
      - homelab

networks:
  homelab:
    external: true
```

### Development Stack

```yaml
version: '3'

services:
  code-server:
    image: linuxserver/code-server:latest
    ports:
      - 8443:8443
    volumes:
      - ./config:/config
    environment:
      - PUID=1000
      - PGID=1000
    networks:
      - homelab

networks:
  homelab:
    external: true
```

## Troubleshooting

- **Stack Deployment Failures**: Check the logs in Portainer for detailed error information
- **Git Connection Issues**: Verify your authentication credentials and repository URL
- **Container Networking**: Ensure your networks are properly configured across stacks

## References

- [Portainer Documentation](https://docs.portainer.io/)
- [Docker Compose Reference](https://docs.docker.com/compose/compose-file/) 