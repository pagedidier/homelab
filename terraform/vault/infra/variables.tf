variable "gitlab_pat" {
  type = string
  sensitive = true
}
variable "vault_addr" {
  type = string
}
variable "vault_token" {
  type = string
  sensitive = true
}