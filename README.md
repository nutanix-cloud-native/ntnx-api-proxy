# ntnx-api-proxy

This tool allows the concentration of Prism Central API calls to a single point to simplify filtering and limit access.

This tool has been validated with the following components:

PC v1 & v2 API
- CSI 3.0

PC v3 API:
- CAPX v1.2.3
- CCM v0.3.2
- Openshift IPI 4.13
- CSI 3.0

PC v4 API:
- CSI 3.0
- vm-operator (beta)

## How to use this image

Start a `ntnx-api-proxy` instance via [`docker-compose`](https://github.com/docker/compose) or [`docker stack deploy`](https://docs.docker.com/engine/reference/commandline/stack_deploy/)

Basic example `docker-compose.yml` for `ntnx-api-proxy`:

```yaml
version: '3.1'

services:

  ntnx-api-proxy:
    image: ghcr.io/nutanix-cloud-native/ntnx-api-proxy
    restart: always
    ports:
      - 9440:9440
    environment:
      FQDN: proxy-pc.demo.com
      NUTANIX_ENDPOINT: pc.demo.com
      # TRAEFIK_LOG_LEVEL: "info"
      # TRAEFIK_SERVERSTRANSPORT_ROOTCAS: /etc/traefik/cert/ca.cer
      # AUTH_PROXY: enable
      # NUTANIX_USERNAME: admin
      # NUTANIX_PASSWORD: Bik7Tr750!
      # DASHBOARD: enable
    volumes:
      - ./cert:/etc/traefik/cert
      # - ./auth:/etc/traefik/auth
```

Valid certificate files are required in the file locations below:

`/etc/traefik/cert/tls.crt`: Certificate used by the proxy to expose the service

`/etc/traefik/cert/tls.key`:  Key related to the proxy certificate



## Configuring the proxy

Proxy configuration is configured using the following env variables:

| Name | Description                                              | Mandatory | Default |
|------|----------------------------------------------------------|-----------|---------|
| FQDN | Fully Qualified Domain Name used to expose proxy service | true      | *none*  |




Backend connection is configured using the following env variables:

| Name             | Description                                                  | Mandatory | Default |
|------------------|--------------------------------------------------------------|-----------|---------|
| NUTANIX_ENDPOINT | Fully Qualified Domain Name used to connect to Prism Central | true      | *none*  |
| NUTANIX_PORT     | Port to connect to Prism Central                             | false     | 9440    |
| NUTANIX_USERNAME | Username to connect to Prism Central if AUTH_PROXY enable    | false     | admin   |
| NUTANIX_PASSWORD | Password to connect to Prism Central if AUTH_PROXY enable    | false     | *none*  |



Advanced configuration is possible using the following env variables:

| Name                                        | Description                                         | Mandatory | Default |
|---------------------------------------------|-----------------------------------------------------|-----------|---------|
| AUTH_PROXY                                  | Set authentication circuit breaker (enable/disable) | false     | disable |
| DASHBOARD                                   | Set dashboard (enable/disable)                      | false     | disable |
| TRAEFIK_LOG_LEVEL                           | Log level of proxy logs                             | false     | error   |
| TRAEFIK_SERVERSTRANSPORT_ROOTCAS            | Path of the CA file to validate backend             | false     | *none*  |
| TRAEFIK_SERVERSTRANSPORT_INSECURESKIPVERIFY | Disable SSL certificate verification                | false     | false   |



## Advanced configuration



#### Internal/self-signed CA

If you want to validate your backend server against an internal CA you need to set the env `TRAEFIK_SERVERSTRANSPORT_ROOTCAS` with your CA file path and present the corresponding file in your container.

ex: `TRAEFIK_SERVERSTRANSPORT_ROOTCAS=/etc/traefik/cert/ca.crt`



#### Authentication circuit breaker

You can decide to implement separate authentication at the proxy level. To do this, follow the procedure below:

- Create a file that contains the authorized users for the proxy. The file content is a list of `name:hashed-password`. Passwords must be hashed using MD5, SHA1, or BCrypt (use `htpasswd` to generate the passwords).
- Provide the file in the following path `/etc/traefik/auth/usersfile`.
- Set `NUTANIX_USERNAME` and `NUTANIX_PASSWORD` env to connect to the backend Prism Central.
- Set  `AUTH_PROXY` env to `enable`.



#### Proxy Dashboard

You can enable the proxy dashboard by setting `DASHBOARD` to `enable`.

Proxy will be available at the following address: `https://FQDN:9440/dashboard/`

If `AUTH_PROXY` is enabled the same users will be used to connect to the dashboard.



## Contributing

See the [contributing docs](CONTRIBUTING.md).



## Support

### Community Plus

This code is developed in the open with input from the community through issues and PRs. A Nutanix engineering team serves as the maintainer. Documentation is available in the project repository.

Issues and enhancement requests can be submitted in the [Issues tab of this repository](../../issues). Please search for and review the existing open issues before submitting a new issue.



## License

The project is released under version 2.0 of the [Apache license](http://www.apache.org/licenses/LICENSE-2.0).