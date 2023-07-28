data "nutanix_subnet" "net" {

  subnet_name = var.nutanix_subnet
}

data "nutanix_cluster" "cluster" {

  name = var.nutanix_cluster
}

data "nutanix_image" "flatcar" {

  image_name = var.flatcar_image

}

resource "nutanix_virtual_machine" "ntnx-api-proxy" {

  name                 = var.vm_name
  num_vcpus_per_socket = 2
  num_sockets          = 1
  memory_size_mib      = 4096

  cluster_uuid = data.nutanix_cluster.cluster.id

  nic_list {
    subnet_uuid = data.nutanix_subnet.net.id
    ip_endpoint_list {
      ip   = var.vm_ip
      type = "ASSIGNED"
    }
  }

  disk_list {
    disk_size_mib   = 10000
    data_source_reference = {
        kind = "image"
        uuid = data.nutanix_image.flatcar.id
      }
  
    device_properties {
      disk_address = {
        device_index = 0
        adapter_type = "SCSI"
      }

      device_type = "DISK"
    }
  }


  guest_customization_cloud_init_user_data = base64encode(data.ct_config.ignition.rendered)
}

data "ct_config" "ignition" {
  content = templatefile("ignition.tftpl", {
    nutanix_endpoint                 = var.nutanix_endpoint
    ssh_key                          = file(var.ssh_key)
    fqdn                             = var.fqdn
    additional_ca                      = indent(10,file("${path.module}/cert/additional_ca.crt"))
    ca                               = indent(10,file("${path.module}/cert/ca.crt"))
    cert                             = indent(10,file("${path.module}/cert/tls.crt"))
    key                              = indent(10,file("${path.module}/cert/tls.key"))
    traefik_log_level                = var.traefik_log_level
    traefik_serverstransport_rootcas = var.traefik_serverstransport_rootcas
    auth_proxy                       = var.auth_proxy
    nutanix_username                 = var.nutanix_username
    nutanix_password                 = var.nutanix_password
    dashboard                        = var.dashboard
    container_image                  = "${var.container_registry}/${var.container_image}"
    docker_config                    = indent(10,templatefile("docker.config.tftpl", {
      container_registry = var.container_registry
      container_auth     = base64encode("${var.registry_user}:${var.registry_pass}")
    }))
  })
  strict       = true
}