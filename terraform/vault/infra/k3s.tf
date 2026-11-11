resource "vault_auth_backend" "approle_k3s_prod" {
  type = "approle"
  path = "approle/k3s_prod"
}

data "vault_policy_document" "argocd_k3s_prod_read" {
  rule {
    capabilities = ["read"]
    path         = vault_kv_secret_v2.argocd_k3s_prod.path
  }
}

resource "vault_policy" "argocd_read" {
  name   = "argocd-k3s-prod-read"
  policy = data.vault_policy_document.argocd_k3s_prod_read.hcl
}

resource "vault_approle_auth_backend_role" "k3s_prod_external_secrets" {
  backend = vault_auth_backend.approle_k3s_prod.path
  role_name                        = "k3s-prod-external-secrets"
  token_policies                   = [vault_policy.argocd_read.name]
  token_ttl      = 3600
  token_max_ttl  = 7200
}

resource "vault_approle_auth_backend_role_secret_id" "k3s_prod_external_secrets" {
  backend   = vault_auth_backend.approle_k3s_prod.path
  role_name = vault_approle_auth_backend_role.k3s_prod_external_secrets.role_name
}

resource "kubernetes_secret" "vault_approle_credentials" {
  metadata {
    name      = "vault-approle-credentials"
    namespace = "external-secrets"
  }

  data = {
    role_id   = vault_approle_auth_backend_role.k3s_prod_external_secrets.role_id
    secret_id = vault_approle_auth_backend_role_secret_id.k3s_prod_external_secrets.secret_id
  }

  type = "Opaque"
}