terraform {
  backend "http" {}
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "17.0.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.31.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.2"
    }
  }
}

provider "haproxy" {
  url         = "http://192.168.0.20:5555"
  username    = "admin"
  password    = "adminpwd"
}

provider "gitlab" {
  token = var.gitlab_pat
}

provider "docker" {
  host     = "ssh://ubuntu@192.168.0.111"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}
# provider "vault" {
#    address = "https://vault.twop.ch"
#   token = var.vault_token
# }