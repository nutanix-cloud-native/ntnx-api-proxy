terraform {
  required_version = ">= 0.14.0"
  required_providers {
    nutanix = {
      source = "nutanix/nutanix"
    }
    ct = {
      source  = "poseidon/ct"
      version = "0.12.0"
    }
  }
}


# Configure the Nutanix Provider
provider "nutanix" {
  username  = var.nutanix_username
  password  = var.nutanix_password
  endpoint  = var.nutanix_endpoint
  insecure  = var.nutanix_insecure
  port      = 9440
}

