resource "kubernetes_manifest" "external_secret" {
  manifest = {
    apiVersion = "external-secrets.io/v1"
    kind       = "ExternalSecret"
    metadata = {
      name      = var.name
      namespace = var.namespace
    }
    spec = {
      refreshInterval = var.refresh_interval
      secretStoreRef = {
        name = var.secret_store_name
        kind = var.secret_store_kind
      }
      target = {
        name           = var.target_secret_name
        creationPolicy = "Owner"
        template = {
          type = "Opaque"
          metadata = {
            labels = var.target_labels
          }
          data = {
            type     = "git"
            url      = var.git_url
            password = "{{ .token }}"
            username = "{{ .username }}"
          }
        }
      }
      data = [
        {
          secretKey = "token"
          remoteRef = {
            key      = var.vault_secret_key
            property = var.vault_token_property
          }
        },
        {
          secretKey = "username"
          remoteRef = {
            key      = var.vault_secret_key
            property = var.vault_username_property
          }
        }
      ]
    }
  }
}