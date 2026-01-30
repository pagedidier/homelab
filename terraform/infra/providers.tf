terraform {
  backend "http" {}
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.85.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
    infomaniak = {
      source  = "Infomaniak/infomaniak"
      version = "1.3.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }
  }
}


provider "infomaniak" {
  token = var.infomaniak_token
}

provider "proxmox" {
  endpoint = var.pvc["pvc01"].proxmox_endpoint
  username = var.pvc["pvc01"].proxmox_username
  password = var.pvc["pvc01"].proxmox_password
  insecure = true
  ssh {
    agent    = true
    username = var.pvc["pvc01"].proxmox_ssh_user
  }
}