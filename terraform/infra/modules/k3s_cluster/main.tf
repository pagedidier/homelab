locals {
  ip = split("/", var.cidr)[0]
  mask = parseint(split("/", var.cidr)[1],10)
}

module "k3s_nodes_tmp" {
  count              = var.nb_node
  source             = "../vm"
  name               = "k3s-${format("%02d", count.index + 1)}.${var.environment}"
  node_name          = var.node_array[count.index]
  init_ssh_keys      = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes       = 8192

  ip = "${cidrhost(var.cidr, parseint(split(".", local.ip)[3], 10)+ count.index)}/${local.mask - 8}"
  gateway            = var.gateway
}

output "cluster" {
  value = [for node in module.k3s_nodes_tmp : {
    hostname = node.vm.name
    ip       = node.vm.ip
    username = node.vm.username
  }]
}

