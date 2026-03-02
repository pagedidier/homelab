variable "ip" {
}
variable "username" {
}
variable "hostname" {
}
variable "port" {
  default = 22
}
variable "domain_name" {
  type    = string
  default = ""
}
variable "tags" {
  type        = list(string)
  description = "List of tags/groups for Ansible inventory"
}
