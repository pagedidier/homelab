terraform {
  backend "http" {}
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "19.5.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "5.13.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.5.0"
    }
  }
}

provider "gitlab" {
  token = var.gitlab_pat
}

provider "vault" {
  address = var.vault_addr
  token   = var.vault_token
}
provider "kubernetes" {
  config_path = "~/.kube/config"
}