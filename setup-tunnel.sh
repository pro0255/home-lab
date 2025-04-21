docker run -d \
  --name cloudflared \
  --network homelab \
  --restart unless-stopped \
  cloudflare/cloudflared:latest tunnel --no-autoupdate run --token $TOKEN