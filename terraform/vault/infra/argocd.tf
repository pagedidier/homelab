data "gitlab_project" "homelab" {
  id = 54910045
}

resource "gitlab_project_deploy_token" "argocd_k3s_prod" {
  project   = data.gitlab_project.homelab.id
  name       = "Read token for argocd k3s prod"
  scopes = ["read_repository"]
}

resource "vault_kv_secret_v2" "argocd_k3s_prod" {
  mount = vault_mount.argocd.id
  name = "argocd.twop.ch"

  data_json = jsonencode({
    "token": gitlab_project_deploy_token.argocd_k3s_prod.token,
    "username": gitlab_project_deploy_token.argocd_k3s_prod.username
  })
}