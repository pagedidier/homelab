terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.85.1"
    }
  }
}

locals {
  formated_prometheus_extra_labels = join(",", [for k, v in var.formated_prometheus_extra_labels : "${k}:${v}"])
  description = <<-EOT
    formated_prometheus_extra_labels: ${local.formated_prometheus_extra_labels}
  EOT
}

resource "proxmox_virtual_environment_file" "meta_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "isos-templates"
  node_name    = var.node_name

  source_raw {
    data = <<-EOF
    #cloud-config
    local-hostname: ${var.name}
    EOF

    file_name = "metadata-cloud-config-${var.name}.yaml"
  }
}


resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.name
  node_name = var.node_name

  keyboard_layout = "fr-ch"

  initialization {
    ip_config {
      ipv4 {
        address = var.ip
        gateway = var.gateway
      }
    }

    user_data_file_id = var.user_data_file_id
    meta_data_file_id = proxmox_virtual_environment_file.meta_data_cloud_config.id
  }

  cpu {
    cores = var.nb_cpus
    type = "host"
    #architecture = var.cpu_architecture
  }

  memory {
    dedicated = var.ram_in_bytes
  }

  operating_system {
    type = "l26"
  }

  disk {
    datastore_id = var.volume_name
    file_id      = "${var.image_storage_name}:iso/${var.iso_filename}"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.disk_size
  }

  dynamic "disk" {
    for_each = var.attached_disk
    content {
      datastore_id = disk.value.datastore_id
      interface    = disk.value.interface
      size         = disk.value.disk_size
      iothread     = disk.value.iothread

    }
  }

  network_device {
    bridge = "vmbr0"
  }
  agent {
    enabled = var.agent_enable
    timeout = "30s"
  }

  dynamic "usb" {
    for_each = var.enable_usb ? [1] : []
    content {
      host = var.usb_host
      usb3 = var.use_usb3
    }
  }

  description = local.description

}
output "vm" {
  value = {
    "id": proxmox_virtual_environment_vm.vm.id
    "ip": split("/",proxmox_virtual_environment_vm.vm.initialization[0].ip_config[0].ipv4[0].address)[0],
    "username": "ubuntu"
    "hostname": proxmox_virtual_environment_vm.vm.name
  }
}