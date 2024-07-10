terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "17.0.1"
    }
  }
}

data "gitlab_project" "project" {
  id = var.project_id
}

resource "gitlab_deploy_token" "k3s_deploy_token" {
  project    = data.gitlab_project.project.path_with_namespace
  name       = "k3s ${data.gitlab_project.project.name} deploy token ${var.environment_name}"
  username   = "k3s-${data.gitlab_project.project.name}-${var.environment_name}"

  scopes = ["read_registry"]
}

resource "kubernetes_secret" "example" {
  metadata {
    name = "regcred-${data.gitlab_project.project.name}-${var.environment_name}"
    namespace = var.environment_name
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