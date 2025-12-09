resource "helm_release" "kubernetes_dashboard-dev" {
  name       = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"

  namespace  = "kubernetes-dashboard"
  create_namespace = true
  provider = helm.k3s_dev
}

resource "kubernetes_service_account" "admin_user-dev" {
  metadata {
    name      = "admin-user"
    namespace = "kubernetes-dashboard"
  }
  provider = kubernetes.k3s_dev

}

resource "kubernetes_cluster_role_binding" "admin_user-dev" {
  metadata {
    name = "admin-user"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.admin_user.metadata[0].name
    namespace = kubernetes_service_account.admin_user.metadata[0].namespace
  }
  provider = kubernetes.k3s_dev

}

# resource "kubernetes_namespace" "vault-dev" {
#   metadata {
#     name = "vault"
#   }
#   provider = kubernetes.k3s_dev
# }

resource "helm_release" "vault-dev" {
  name       = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  namespace  = "vault"
  create_namespace = true

  set {
    name  = "global.externalVaultAddr"
    value = "http://192.168.0.111:8300"
  }
  # depends_on = [kubernetes_namespace.vault-dev]
  provider = helm.k3s_dev

}

resource "kubernetes_secret" "vault_token-dev" {
  metadata {
    name = "vault-token-g955r"
    namespace  = "vault"
    annotations = {
      "kubernetes.io/service-account.name" = "vault"
    }
  }

  type = "kubernetes.io/service-account-token"
  provider = kubernetes.k3s_dev

}