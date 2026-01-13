data "vault_policy_document" "k8s-role-policy-document" {
  rule {
    capabilities = ["read"]
    path         = "projects/data/${var.project_name}/${var.environment_name}/${var.service_name}"
  }
}

resource "vault_policy" "k8s-role-policy" {
  name   = "k8s-${var.project_name}-${var.service_name}-${var.environment_name}"
  policy = data.vault_policy_document.k8s-role-policy-document.hcl
}

resource "vault_kubernetes_auth_backend_role" "k8s-test" {
  backend                          = var.backend
  bound_service_account_names      = [var.vault_k8s_service_account]
  bound_service_account_namespaces = [var.project_name]
  token_policies                   = [vault_policy.k8s-role-policy.name]
  token_ttl                        = "24"
  role_name                        = "${var.project_name}-${var.service_name}-${var.environment_name}"
}