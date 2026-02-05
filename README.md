# ntnx-api-proxy

---

[![CI](https://github.com/nutanix-cloud-native/ntnx-api-proxy/actions/workflows/ci.yaml/badge.svg)](https://github.com/nutanix-cloud-native/ntnx-api-proxy/actions/workflows/ci.yaml)

[![release](https://img.shields.io/github/release-pre/nutanix-cloud-native/ntnx-api-proxy.svg)](https://github.com/nutanix-cloud-native/ntnx-api-proxy/releases)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/nutanix-cloud-native/ntnx-api-proxy/blob/master/LICENSE)
[![Releases](https://img.shields.io/github/downloads/nutanix-cloud-native/ntnx-api-proxy/total.svg)](https://github.com/nutanix-cloud-native/ntnx-api-proxy/releases)

---

Disclaimer: The software code configuration provided herein is intended solely for illustrative purposes and serves as an example. This configuration is not officially supported.  Users are advised that the example may not be adapted for production environments, and its use is at their own risk. It is recommended that users seek professional advice for configuring the software in a production or critical environment.

---

This tool allows the concentration of Prism Central API calls to a single point to simplify filtering and limit access.

This tool has been tested with the following components:

- CSI v3.0.0, v3.2.0
- CAPX v1.2.3, v1.5.3
- CCM v0.3.2, v0.5.0
- Openshift IPI 4.13
- NKP 2.14.0
- COSI 0.4.0

Tools and APIs call may evolve over time, which may require updating the proxy configuration before upgrading any dependent solutions.


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
      # - 8080:8080 #used for metrics export
    environment:
      FQDN: proxy-pc.demo.com
      NUTANIX_ENDPOINT: pc.demo.com
      # TRAEFIK_LOG_LEVEL: "info"
      #TRAEFIK_LOG_FORMAT: "json"
      #TRAEFIK_ACCESSLOG_FORMAT: "json"
      # TRAEFIK_SERVERSTRANSPORT_ROOTCAS: /etc/traefik/cert/ca.cer
      # DASHBOARD: enable
      # TRAEFIK_METRICS_PROMETHEUS: true
      # NOFILTER: true
    volumes:
      - ./cert:/etc/traefik/cert
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



Advanced configuration is possible using the following env variables:

| Name                                        | Description                             | Mandatory | Default |
|---------------------------------------------|-----------------------------------------|-----------|---------|
| DASHBOARD                                   | Set dashboard (enable/disable)          | false     | disable |
| TRAEFIK_LOG_LEVEL                           | Log level of proxy logs                 | false     | error   |
| TRAEFIK_SERVERSTRANSPORT_ROOTCAS            | Path of the CA file to validate backend | false     | *none*  |
| TRAEFIK_SERVERSTRANSPORT_INSECURESKIPVERIFY | Disable SSL certificate verification    | false     | false   |
| TRAEFIK_METRICS_PROMETHEUS                  | enable metrics export via Prometheus    | false     | false   |
| NOFILTER                                    | disable filter mode                     | false     | false   |


## Advanced configuration



#### Internal/self-signed CA

If you want to validate your backend server against an internal CA you need to set the env `TRAEFIK_SERVERSTRANSPORT_ROOTCAS` with your CA file path and present the corresponding file in your container.

ex: `TRAEFIK_SERVERSTRANSPORT_ROOTCAS=/etc/traefik/cert/ca.crt`



#### Proxy Dashboard

You can enable the proxy dashboard by setting `DASHBOARD` to `enable`.

Proxy will be available at the following address: `https://FQDN/dashboard/`



## Alternate install

You can explore the OpenTofu install method in this [folder](tofu).

## Contributing

See the [contributing docs](CONTRIBUTING.md).



## Support

### Community Plus

This code is developed in the open with input from the community through issues and PRs. A Nutanix engineering team serves as the maintainer. Documentation is available in the project repository.

Issues and enhancement requests can be submitted in the [Issues tab of this repository](../../issues). Please search for and review the existing open issues before submitting a new issue.



## License

The project is released under version 2.0 of the [Apache license](http://www.apache.org/licenses/LICENSE-2.0).
