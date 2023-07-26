# Terraform Deployment

## Prerequisite

- Collect static IP for the API-Proxy
- Create a DNS-record pointing to that IP
- put necessary SSL-Certs as `tls.crt`, `tls.key` and `ca.crt` in `cert` Subfolder
- Download, extract and upload flatcar-image into Nutanix Image Service
  (https://stable.release.flatcar-linux.net/amd64-usr/current/flatcar_production_openstack_image.img.gz)

## Deployment

First customize `terraform.tfvars` by your demand and initialize Terraform with:

```
terraform init
```

Apply the terraform manifest by running

```
terraform apply
```

## Cleanup

To remove the API-Proxy run

```
terraform destroy
```

## Things to know and current limitations
- Initial boot of the appliance will take up to 6min.
- The appliance will pull the container image from public registry, so it needs internet access.

## ToDo
- make container-image customizable
- add pull secrets when using internal registry