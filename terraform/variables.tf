variable "vm_name" {
  type = string
}

variable "vm_ip" {
  type = string
}

variable "nutanix_username" {
  type = string
}

variable "nutanix_endpoint" {
  type = string
}

variable "nutanix_password" {
  type = string
}

variable "nutanix_insecure" {
  type = string
}

variable "nutanix_subnet" {
  type = string
}

variable "nutanix_cluster" {
  type = string
}

variable "flatcar_image" {
  type = string
}

variable "ssh_key" {
  type = string
}

variable "dashboard" {
  type = string
}

variable "auth_proxy" {
  type = string
  default = ""
}

variable "traefik_serverstransport_rootcas" {
  type = string
  default = ""
}

variable "traefik_log_level" {
  type = string
}

variable "fqdn" {
  type = string
}

variable "container_image" {
  type = string
}

variable "container_registry" {
  type = string
  default = ""
}

variable "registry_pass" {
  type = string
  default = ""
}
variable "registry_user" {
  type = string
  default = ""
}