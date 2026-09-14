variable "application_name" {

}

variable "gitlab_project" {

}
variable "helm_config" {
}


variable "repo_url" {
  default = "https://gitlab.com/two-p/homelab.git"
}

variable "argocd_namespace" {
  default = "argocd"
}
