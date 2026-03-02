terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.85.1"
    }
  }
}
data "proxmox_virtual_environment_node" "node" {
  node_name = var.hostname
}

output "proxmox" {
  value = {
    "ip" : var.ip,
    "username" : var.username
    "name" : var.hostname
    "hostname" = "${var.hostname}${var.domain_name != "" ? ".${var.domain_name}" : ""}"
    "port" : var.port
    "tags" = var.tags
  }
}

output "proxmox_data" {
  value = data.proxmox_virtual_environment_node.node
}
