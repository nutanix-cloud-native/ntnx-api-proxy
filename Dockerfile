FROM traefik:v2.10

ENV TRAEFIK_PROVIDERS_FILE_DIRECTORY="/etc/traefik/traefik.d/" 
ENV TRAEFIK_ENTRYPOINTS_proxy_ADDRESS=":9440"
ENV TRAEFIK_LOG_LEVEL="INFO"
ENV TRAEFIK_ACCESSLOG=true
ENV TRAEFIK_API=true

COPY traefik.d/* /etc/traefik/traefik.d/