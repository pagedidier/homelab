variable "repo_name" {
  type = string
}
variable "auth_path" {
  type = string
}
variable "gitlab_group" {
  type = string
}
variable "vault_addr" {
  type = string
}
variable "extra_policies" {
  type = list(object({
    path        = string
    capabilites = list(string)
  }))
  default = []
}