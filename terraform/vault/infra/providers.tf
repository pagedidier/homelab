terraform {
  backend "http" {}
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "17.11.0"
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