variable "init_user_password" {
  type = string
  default = ""
}

variable "init_user_username" {
  type = string
  default = ""
}

variable "init_ssh_keys" {
  type = list(string)
}

variable "proxmox_endpoint" {}
variable "proxmox_username" {}
variable "proxmox_password" {}
variable "proxmox_ssh_key_path" {}
variable "proxmox_ssh_user" {}