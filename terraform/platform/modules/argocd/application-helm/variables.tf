variable "application_name" {

}

variable "environment" {

}

variable "repo_url" {
  default = "https://gitlab.com/two-p/infrastructure/homelab.git"
}

variable "argocd_namespace" {
  default = "argocd"
}