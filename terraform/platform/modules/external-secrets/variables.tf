variable "vault_addr" {
  type = string
}

variable "vault_k8s_name" {
  type = string
}

variable "role_id" {
  type = string
}

variable "vault_app_role_name" {
  type = string
  default = "vault-approle-credentials"
}

variable "namespace" {
  type = string
  default = "external-secrets"
}