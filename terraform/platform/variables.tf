
variable "gitlab_pat" {
  default = ""
}

variable "registry_server" {
  default = "registry.gitlab.com"
}
variable "domain_name" {}
variable "vault_token" {}
variable "vault_addr" {}

variable "database" {
  type = map(object({
    endpoint = string
    username = string
    password = string
  }))
}
variable "infomaniak_token" {
  type = string
}
