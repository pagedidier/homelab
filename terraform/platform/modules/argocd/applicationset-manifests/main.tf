resource "kubernetes_manifest" "application_set" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind"       = "ApplicationSet"
    "metadata" = {
      "name"      = var.application_name
      "namespace" = var.argocd_namespace
    }
    "spec" = {
      "generators" = [
        {
          "pullRequest" = {
            "gitlab" = {
              "project"          = var.gitlab_project
              "api"              = "https://gitlab.com"
              "pullRequestState" = "opened"
              "tokenRef" = {
                "secretName" = "gitlab-token"
                "key"        = "token"
              }
            }
            "filters" = [
              {
                "branchMatch" = "^\\d+-.+$"
              }
            ]
          }
        }
      ]
      "template" = {
        "metadata" = {
          "name" = "${var.application_name}-mr-{{number}}"
        }
        "spec" = {
          "project" = "default"
          "source" = {
            "repoURL"        = var.repo_url
            "targetRevision" = "HEAD"
            "path"           = "charts/${var.application_name}"
            "helm": var.helm_config
          }
          "destination" = {
            "server"    = "https://kubernetes.default.svc"
            "namespace" = var.application_name
          }
          "syncPolicy" = {
            "automated" = {
              "prune"    = true
              "selfHeal" = true
            }
          }
        }
      }
    }
  }
}