variable "name" {
  description = "Name of the ExternalSecret resource."
  type        = string
  default     = "homelab-repository-es"
}

variable "namespace" {
  description = "Namespace where the ExternalSecret and target Kubernetes secret will be created."
  type        = string
  default     = "argocd"
}

variable "refresh_interval" {
  description = "The interval at which the ExternalSecret should refresh."
  type        = string
  default     = "1m"
}

variable "secret_store_name" {
  description = "Name of the SecretStore or ClusterSecretStore."
  type        = string
  default     = "vault-infra-backend"
}

variable "secret_store_kind" {
  description = "Kind of the SecretStore (e.g., SecretStore or ClusterSecretStore)."
  type        = string
  default     = "ClusterSecretStore"
}

variable "target_secret_name" {
  description = "Name of the resulting Kubernetes Secret."
  type        = string
  default     = "homelab-repository"
}

variable "git_url" {
  description = "Git repository URL for the ArgoCD repository secret template."
  type        = string
  default     = "https://gitlab.com/two-p/infrastructure/homelab.git"
}

variable "vault_secret_key" {
  description = "Vault path/key where the repository credentials are stored."
  type        = string
  default     = "argocd/argocd.twop.ch"
}

variable "vault_token_property" {
  description = "Property name in Vault for the token/password."
  type        = string
  default     = "token"
}

variable "vault_username_property" {
  description = "Property name in Vault for the username."
  type        = string
  default     = "username"
}

variable "target_labels" {
  description = "Labels to apply to the target Kubernetes secret."
  type        = map(string)
  default = {
    "argocd.argoproj.io/secret-type" = "repository"
  }
}