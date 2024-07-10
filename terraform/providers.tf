terraform {
  required_providers {
    haproxy = {
      source = "SepehrImanian/haproxy"
      version = "0.0.7"
    }
    proxmox = {
      source = "bpg/proxmox"
      version = "0.55.1"
    }
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "17.0.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.31.0"
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

provider "gitlab" {
  token = var.gitlab_pat
}

provider "haproxy" {
  url      = "http://srv1.${var.domain_name}:5555"
  username = var.haproxy_username
  password = var.haproxy_password
}