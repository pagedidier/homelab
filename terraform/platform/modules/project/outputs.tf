output "vault_k8s_service_account" {
  value = kubernetes_service_account_v1.vault_service_account.metadata[0].name
}