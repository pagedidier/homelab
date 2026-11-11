resource "vault_mount" "argocd" {
  path        = "argocd"
  type        = "kv"
  options     = { version = "2" }
}