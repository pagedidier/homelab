variable "init_user_password" {
}

variable "init_ssh_keys" {
}

variable "node_name" {

}
variable "started" {
  type    = bool
  default = true
}
variable "node_ip" {}
variable "name" {}


variable "disk_size" {
}
variable "cpu_cores" {
}

variable "memory" {}
variable "swap" {}
variable "file_template_id" {}

variable "operating_system_type" {}

variable "network_interface_name" {}
variable "network_interface_bridge" {}



variable "use_dhcp" {
  type    = bool
  default = false
}
variable "ip" {
  type     = string
  default  = null
  nullable = true

}
variable "gateway" {
  type     = string
  default  = null
  nullable = true
}
variable "volume_name" {
  default = "local-lvm"
}
# variable "secret_mount" {
# }

variable "domain_name" {
  type    = string
  default = ""
}

variable "tags" {
  type        = list(string)
  description = "List of tags/groups for Ansible inventory"
}

variable "port" {
  default = 22
  type    = number
}

variable "username" {
  default = "root"
  type    = string
}
