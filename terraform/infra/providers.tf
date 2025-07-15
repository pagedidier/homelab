terraform {
  backend "http" {}
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.61.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
    infomaniak = {
      source  = "Infomaniak/infomaniak"
      version = "~> 1.0"
    }
  }
}

provider "infomaniak" {
  token = var.infomaniak_token
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
