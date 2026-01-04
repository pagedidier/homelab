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
resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.name
  node_name = var.node_name

  keyboard_layout = "fr-ch"

  initialization {
    user_account {
      username = var.init_user_username
      password = var.init_user_password
      keys = var.init_ssh_keys
    }

    ip_config {
      ipv4 {
        address = var.ip
        gateway = var.gateway
      }
    }
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
      backup = disk.value.backup

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
    "username": proxmox_virtual_environment_vm.vm.initialization[0].user_account[0].username,
    "name": proxmox_virtual_environment_vm.vm.name,
    "hostname" = "${proxmox_virtual_environment_vm.vm.name}${var.domain_name != "" ? ".${var.domain_name}" : ""}"  }
}