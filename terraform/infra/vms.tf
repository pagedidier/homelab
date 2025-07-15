module "k3s-node1" {
  source = "./modules/vm"
  name   = "k3s-01.prod"
  node_name = data.proxmox_virtual_environment_node.node11.node_name
  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 8192
  ip="192.168.1.51/16"
  gateway = "192.168.0.254"
}

resource "infomaniak_record" "k3s-node1" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.k3s-node1.vm.hostname
  type = "A"
  ttl = 300
  target = module.k3s-node1.vm.ip
}

module "k3s-node2" {
  source = "./modules/vm"
  name   = "k3s-02.prod"
  node_name = data.proxmox_virtual_environment_node.node12.node_name
  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 8192
  ip="192.168.1.52/16"
  gateway = "192.168.0.254"
}

resource "infomaniak_record" "k3s-node2" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.k3s-node2.vm.hostname
  type = "A"
  ttl = 300
  target = module.k3s-node2.vm.ip
}

module "k3s-node3" {
  source = "./modules/vm"
  name   = "k3s-03.prod"
  node_name = data.proxmox_virtual_environment_node.node13.node_name
  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 8192
  ip="192.168.1.53/16"
  gateway = "192.168.0.254"
}

resource "infomaniak_record" "k3s-node3" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.k3s-node3.vm.hostname
  type = "A"
  ttl = 300
  target = module.k3s-node3.vm.ip
}

