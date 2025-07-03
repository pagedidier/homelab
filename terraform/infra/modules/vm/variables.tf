variable "init_user_password" {
}

variable "init_user_username" {
}

variable "init_ssh_keys" {
}

variable "node_name" {

}

variable "name" {}
variable "volume_name" {
  default = "local-lvm"
}
variable "nb_cpus" {
  default = 2
}

variable "ram_in_bytes" {
  default = 4096
}

variable "ip" {
  default = "dhcp"
}

variable "gateway" {
  default = ""
}

variable "agent_enable" {
  default = false
}

variable "formated_prometheus_extra_labels" {
  type = map(string)
  default = {}
}