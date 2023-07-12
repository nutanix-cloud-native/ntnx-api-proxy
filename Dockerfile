FROM traefik:latest

COPY cert* /etc/traefik/
COPY traefik.yml /etc/traefik/
COPY traefik.d/* /etc/traefik/traefik.d/