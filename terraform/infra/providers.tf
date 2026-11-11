terraform {
  backend "http" {}
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.119.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.3.2"
    }
    infomaniak = {
      source  = "Infomaniak/infomaniak"
      version = "1.4.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.14.2"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "19.5.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "5.13.0"
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

provider "gitlab" {
  token = var.gitlab_pat
}

provider "vault" {
  address = var.vault_addr
  token   = var.vault_token
}