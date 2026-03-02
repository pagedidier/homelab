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
  type    = map(string)
  default = {}
}

variable "image_storage_name" {
  default = "isos-templates"
}

variable "enable_usb" {
  type    = bool
  default = false
}
variable "usb_host" {
  default = ""
}

variable "use_usb3" {
  default = false
}
variable "iso_filename" {
  default = "noble-server-cloudimg-amd64.img"
}

variable "cpu_architecture" {
  type    = string
  default = "x86_64"
}

variable "disk_size" {
  default = 20
}

variable "attached_disk" {
  type = list(object({
    datastore_id = string
    interface    = string
    disk_size    = number
    iothread     = bool
    backup       = bool
  }))
  default = []
}
variable "domain_name" {
  type    = string
  default = ""
}

variable "main_disk_backup" {
  type    = bool
  default = true
}

variable "tags" {
  type        = list(string)
  description = "List of tags/groups for Ansible inventory"
}

variable "port" {
  default = 22
  type    = number
}
