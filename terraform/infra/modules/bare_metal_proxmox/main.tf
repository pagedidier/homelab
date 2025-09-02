terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.82.1"
    }
  }
}
data "proxmox_virtual_environment_node" "node" {
  node_name = var.hostname
}

output "proxmox" {
  value = {
    "ip": var.ip,
    "username": var.username
    "hostname": var.hostname
    "port": var.port
  }
}

output "proxmox_data" {
  value = data.proxmox_virtual_environment_node.node
}