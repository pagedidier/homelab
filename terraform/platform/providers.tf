terraform {
  backend "http" {}
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "17.0.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.38.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.2"
    }
    mysql = {
      source = "petoju/mysql"
      version = "~> 3.0.72"
    }
    vault = {
      source = "hashicorp/vault"
      version = "5.3.0"
    }
    infomaniak = {
      source  = "Infomaniak/infomaniak"
      version = "1.1.9"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
}

provider "infomaniak" {
  token = var.infomaniak_token
}

provider "mysql" {
  endpoint = var.database["database.prod"].endpoint
  username = var.database["database.prod"].username
  password = var.database["database.prod"].password
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
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "vault" {
  address = var.vault_addr
  token = var.vault_token
}