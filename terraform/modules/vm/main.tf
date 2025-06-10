terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.61.1"
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
  }

  memory {
    dedicated = var.ram_in_bytes
  }

  operating_system {
    type = "l26"
  }

  disk {
    datastore_id = var.volume_name
    file_id      = "isos-templates:iso/noble-server-cloudimg-amd64.img"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }
  agent {
    enabled = var.agent_enable
  }
  description = local.description
}
