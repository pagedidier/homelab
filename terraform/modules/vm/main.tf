terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.55.1"
    }
  }
}
resource "proxmox_virtual_environment_vm" "k3s-node-1" {
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
        address = "dhcp"
      }
    }
  }

  cpu {
    cores = 2
    type = "host"
  }

  memory {
    dedicated = 4096
  }

  operating_system {
    type = "l26"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = "local:iso/noble-server-cloudimg-amd64.img"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }
}
