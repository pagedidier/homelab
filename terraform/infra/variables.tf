variable "init_user_password" {
  type    = string
  default = ""
}

variable "init_user_username" {
  type    = string
  default = ""
}

variable "init_ssh_keys" {
  type = list(string)
}

variable "infomaniak_token" {}


variable "pvc" {
  type = map(object({
    proxmox_endpoint     = string
    proxmox_username     = string
    proxmox_password     = string
    proxmox_ssh_user     = string
    proxmox_ssh_key_path = string
  }))
}
