resource "kubernetes_manifest" "cluster_secret_store_vault_infra_backend" {
  manifest = {
    apiVersion = "external-secrets.io/v1"
    kind       = "ClusterSecretStore"
    metadata = {
      name = "vault-infra-backend"
    }
    spec = {
      provider = {
        vault = {
          server  = var.vault_addr
          version = "v2"
          auth = {
            appRole = {
              path   = "approle/${var.vault_k8s_name}"
              roleId = var.role_id
              secretRef = {
                name      = var.vault_app_role_name
                namespace = var.namespace
                key       = "secret_id"
              }
            }
          }
        }
      }
    }
  }
}