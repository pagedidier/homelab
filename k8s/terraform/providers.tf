terraform {
  required_providers {
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


provider "gitlab" {
  token = var.gitlab_pat
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}
# provider "vault" {
#    address = "https://vault.twop.ch"
#   token = var.vault_token
# }