# Docker - DDNS Duckdns-updater
Updates you duckdns.org subdomain with your public IP-address 

## Commandline
``` bash
$ sudo docker pull mikygus/duckdns-updater:1.0
$ sudo docker run -e DUCKDNS_ENV_DOMAINS="my-domain" \
  -e DUCKDNS_ENV_TOKEN="my-duckdns-token" \
  mikygus/duckdns-updater:1.0
```

## Docker Compose
```$(DUCKDNS_TOKEN)``` takes the value from the file .env
### docker-compose.yaml
```yaml
version: '3'
services:
  duckdns:
    container_name: Duckdns
    image: mikygus/duckdns-updater:1.0
    restart: unless-stopped
    hostname: duckdns
    environment:
      DUCKDNS_ENV_DOMAINS: "my-awesome-subdomain"
      DUCKDNS_ENV_TOKEN: "${DUCKDNS_TOKEN}"
```
### .env
```bash
DUCKDNS_TOKEN="enter-your-duckdns-token-here"
```

## Environment variables
| Variable    | Mandatory | Default value |
| -------- | ------- |  ------- | 
| DUCKDNS_ENV_DOMAINS | YES |  |
| DUCKDNS_ENV_TOKEN | YES |  |
