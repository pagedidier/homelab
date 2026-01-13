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