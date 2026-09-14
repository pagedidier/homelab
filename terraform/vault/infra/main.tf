resource "vault_auth_backend" "gitlab_repository" {
  type = "approle"
  path = "approle/gitlab_repo"
}

module "gameserverrental" {
  source       = "./modules/vault/role/repos"
  repo_name    = "gameserverrental"
  auth_path    = vault_auth_backend.gitlab_repository.path
  vault_addr   = var.vault_addr
  gitlab_group = "two-p"
  extra_policies = [
    {
      path        = "/kubernetes/*"
      capabilites = ["read"]
    }
  ]
}

module "homelab" {
  source       = "./modules/vault/role/repos"
  repo_name    = "homelab"
  auth_path    = vault_auth_backend.gitlab_repository.path
  vault_addr   = var.vault_addr
  gitlab_group = "two-p"
  extra_policies = [
    {
      path        = "/kubernetes/*"
      capabilites = ["read"]
    }
  ]
}

resource "vault_mount" "transit" {
  path        = "transit"
  type        = "transit"
  description = "Transit secrets engine for auto-unseal"
}

resource "vault_transit_secret_backend_key" "autounseal" {
  backend    = vault_mount.transit.path
  name       = "autounseal"
  exportable = false
}


data "vault_policy_document" "autounseal-policy-document" {
  rule {
    capabilities = ["update"]
    path         = "transit/encrypt/autounseal"
  }
  rule {
    capabilities = ["update"]
    path         = "transit/decrypt/autounseal"
  }
}

resource "vault_policy" "autounseal-policy" {
  name   = "autounseal"
  policy = data.vault_policy_document.autounseal-policy-document.hcl
}

resource "vault_token" "autounseal" {
  policies  = [vault_policy.autounseal-policy.name]
  period    = "24h"
  no_parent = true
}

output "autounseal_token" {
  value     = vault_token.autounseal.client_token
  sensitive = true
}