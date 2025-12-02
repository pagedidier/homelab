terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "17.0.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.38.0"
    }
  }
}

resource "kubernetes_namespace" "project_name" {
  metadata {
    name = var.project_name
  }
}

resource "kubernetes_service_account" "vault_service_account" {
  metadata {
    name = "vault-${var.project_name}"
    namespace = kubernetes_namespace.project_name.metadata[0].name
  }
}

resource "kubernetes_secret" "vault_token" {
  metadata {
    name = "vault-token-g955r"
    namespace = kubernetes_namespace.project_name.metadata[0].name
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.vault_service_account.metadata[0].name
    }
  }

  type = "kubernetes.io/service-account-token"
}



resource "kubernetes_role" "gitlab_deployment_pipeline_role" {
  metadata {
    name      = "gitlab-deployment-pipeline-role-${var.project_name}"
    namespace = kubernetes_namespace.project_name.metadata[0].name
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
  depends_on = [kubernetes_namespace.project_name]

}

resource "kubernetes_role_binding" "deployment_pipeline_binding" {
  metadata {
    name      = "deployment-pipeline-binding-${var.project_name}"
    namespace = kubernetes_namespace.project_name.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.gitlab_deployment_pipeline_service_account.metadata[0].name
    namespace = kubernetes_namespace.project_name.metadata[0].name
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
    name      = "gitlab-deployment-pipeline-service-account-token-${var.project_name}"
    namespace = kubernetes_namespace.project_name.metadata[0].name

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
    name      = "gitlab-deployment-pipeline-service-account-${var.project_name}"
    namespace = kubernetes_namespace.project_name.metadata[0].name
  }
  depends_on = [kubernetes_namespace.project_name]
}



resource "gitlab_project_variable" "example" {
  key               = "KUBECONFIG_CONTENT"
  value             = base64encode(templatefile("${path.module}/templates/kubeconfig.tpl", {
                      server    = "https://k3s.${var.domain_name}:6443"
                      cluster   = "default"
                      token     = kubernetes_secret.gitlab_deployment_pipeline_service_account_token.data["token"]
                      namespace = var.project_name
                      }))
  protected         = true
  masked            = true
  environment_scope = "*"
  project           = var.gitlab_project_id
}

data "gitlab_project" "project" {
  id = var.gitlab_project_id
}


resource "gitlab_deploy_token" "k3s_deploy_token" {
  project    = data.gitlab_project.project.path_with_namespace
  name       = "k3s-${data.gitlab_project.project.name}-deploy-token"
  username   = "k3s-${data.gitlab_project.project.name}"

  scopes = ["read_registry"]
}

resource "kubernetes_secret" "example" {
  metadata {
    name = "regcred-${var.project_name}"
    namespace = kubernetes_namespace.project_name.metadata[0].name
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        (var.registry_server) = {
          "username" = gitlab_deploy_token.k3s_deploy_token.username
          "password" = gitlab_deploy_token.k3s_deploy_token.token
          "email"    = "d+gitlab.${var.domain_name}"
          "auth"     = base64encode("${gitlab_deploy_token.k3s_deploy_token.username}:${gitlab_deploy_token.k3s_deploy_token.token}")
        }
      }
    })
  }
}