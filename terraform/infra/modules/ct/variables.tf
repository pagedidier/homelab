variable "init_user_password" {
}

variable "init_ssh_keys" {
}

variable "node_name" {

}
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
variable "ip" {}
variable "gateway" {}
variable "volume_name" {
  default = "local-lvm"
}
# variable "secret_mount" {
# }