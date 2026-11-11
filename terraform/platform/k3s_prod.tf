resource "helm_release" "headlamp" {
  name       = "headlamp"
  repository = "https://kubernetes-sigs.github.io/headlamp/"
  chart      = "headlamp"

  namespace        = "headlamp"
  create_namespace = true
}

resource "kubernetes_service_account_v1" "admin_user_headlamp" {
  metadata {
    name      = "admin-user"
    namespace = "headlamp"
  }
  depends_on = [helm_release.headlamp]
}


resource "kubernetes_cluster_role_binding_v1" "admin_user" {
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
    name      = kubernetes_service_account_v1.admin_user_headlamp.metadata[0].name
    namespace = kubernetes_service_account_v1.admin_user_headlamp.metadata[0].namespace
  }
}

resource "helm_release" "vault" {
  name             = "vault"
  repository       = "https://helm.releases.hashicorp.com"
  chart            = "vault"
  namespace        = "vault"
  create_namespace = true

  set = [{
    name  = "global.externalVaultAddr"
    value = "https://vault.twop.ch"
  }]
}

resource "kubernetes_secret_v1" "vault_token" {
  metadata {
    name      = "vault-token-g955r"
    namespace = "vault"
    annotations = {
      "kubernetes.io/service-account.name" = "vault"
    }
  }

  type = "kubernetes.io/service-account-token"
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  force_update = true

  values = [
    file("${path.module}/values/argocd-values.yaml")
  ]
}

resource "helm_release" "external_secrets" {
  name       = "external-secrets"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"

  namespace        = "external-secrets"
  create_namespace = true
}

module "k3s_prod_external_infra_cluster_store" {
  source = "./modules/external-secrets"
  role_id = "0459aa97-0bdb-88b6-6c92-f1751c964714"
  vault_addr = "https://vault.infra.twop.ch"
  vault_k8s_name = "k3s_prod"
}

module "k3s_prod_argo_homelab_repository" {
  source = "./modules/argocd/repository-secret"

  name               = "homelab-repository-es"
  namespace          = "argocd"
  git_url            = "https://gitlab.com/two-p/infrastructure/homelab.git"
  vault_secret_key   = "argocd/argocd.twop.ch"
  secret_store_name  = "vault-infra-backend"
}