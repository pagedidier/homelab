terraform {
  backend "http" {}
  required_providers {
    mysql = {
      source = "petoju/mysql"
      version = "3.0.78"
    }
    haproxy = {
      source = "SepehrImanian/haproxy"
      version = "0.0.7"
    }
    proxmox = {
      source = "bpg/proxmox"
      version = "0.61.1"
    }
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "17.0.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.31.0"
    }
    dns = {
      source = "hashicorp/dns"
      version = "3.4.3"
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

provider "kubernetes" {
  config_path    = "~/.kube/config"
}
# provider "vault" {
#    address = "https://vault.twop.ch"
#   token = var.vault_token
# }
