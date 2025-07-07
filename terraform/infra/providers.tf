terraform {
  backend "http" {}
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.61.1"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  username = var.proxmox_username
  password = var.proxmox_password
  insecure = true
  ssh {
    agent = true
    username = var.proxmox_ssh_user
    private_key = file(var.proxmox_ssh_key_path)
  }
}
