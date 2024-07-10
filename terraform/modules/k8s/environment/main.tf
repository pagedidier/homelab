terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "17.0.1"
    }
  }
}

resource "kubernetes_namespace" "environment_name" {
  metadata {
    name = var.environment_name
  }
}



resource "kubernetes_role" "gitlab_deployment_pipeline_role" {
  metadata {
    name      = "gitlab-deployment-pipeline-role-${var.environment_name}"
    namespace = var.environment_name
  }

  rule {
    api_groups = [""]
    resources  = ["deployments", "services", "ingresses", "secrets", "middlewares","pods"]
    verbs      = ["create", "delete", "get", "list", "patch", "update", "watch"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments"]
    verbs      = ["create", "delete", "get", "list", "patch", "update", "watch"]
  }

  rule {
    api_groups = ["extensions"]
    resources  = ["deployments"]
    verbs      = ["create", "delete", "get", "list", "patch", "update", "watch"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["create", "delete", "get", "list", "patch", "update", "watch"]
  }

  rule {
    api_groups = ["traefik.containo.us"]
    resources  = ["middlewares"]
    verbs      = ["create", "delete", "get", "list", "patch", "update", "watch"]
  }
  depends_on = [kubernetes_namespace.environment_name]

}

resource "kubernetes_role_binding" "deployment_pipeline_binding" {
  metadata {
    name      = "deployment-pipeline-binding-${var.environment_name}"
    namespace = var.environment_name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.gitlab_deployment_pipeline_service_account.metadata[0].name
    namespace = var.environment_name
  }

  role_ref {
    kind     = "Role"
    name     = kubernetes_role.gitlab_deployment_pipeline_role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
  depends_on = [kubernetes_service_account.gitlab_deployment_pipeline_service_account, kubernetes_role.gitlab_deployment_pipeline_role]

}

resource "kubernetes_secret" "gitlab_deployment_pipeline_service_account_token" {
  metadata {
    name      = "gitlab-deployment-pipeline-service-account-token-${var.environment_name}"
    namespace = var.environment_name

    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.gitlab_deployment_pipeline_service_account.metadata[0].name
    }
  }

  depends_on = [kubernetes_service_account.gitlab_deployment_pipeline_service_account]
  wait_for_service_account_token = true

  type = "kubernetes.io/service-account-token"
}

resource "kubernetes_service_account" "gitlab_deployment_pipeline_service_account" {
  metadata {
    name      = "gitlab-deployment-pipeline-service-account-${var.environment_name}"
    namespace = var.environment_name
  }
  depends_on = [kubernetes_namespace.environment_name]
}



resource "gitlab_group_variable" "example" {
  group             = var.gitlab_group
  key               = "KUBECONFIG_${upper(var.environment_name)}"
  value             = base64encode(templatefile("${path.module}/templates/kubeconfig.tpl", {
                      server    = "https://k3s.${var.domain_name}:6443"
                      cluster   = "default"
                      token     = kubernetes_secret.gitlab_deployment_pipeline_service_account_token.data["token"]
                      namespace = var.environment_name
                      }))
  protected         = false
  masked            = false
  environment_scope = "*"
}


