resource "kubernetes_manifest" "application" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind"       = "Application"
    "metadata" = {
      "name"      = "${var.application_name}"
      "namespace" = "argocd"
    }
    "spec" = {
      "project" = "default"
      "source" = {
        "repoURL"        = var.repo_url
        "targetRevision" = "HEAD"
        "path"           = "k8s/k3s_prod/${var.application_name}"
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
