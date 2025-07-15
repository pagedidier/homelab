module "swarm-node1" {
  source = "./modules/vm"
  name   = "swarm-01.prod"
  node_name = data.proxmox_virtual_environment_node.node12.node_name
  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.0.111/16"
  gateway = "192.168.0.254"
  agent_enable = true
}

resource "infomaniak_record" "swarm-node1" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.swarm-node1.vm.hostname
  type = "A"
  ttl = 300
  target = module.swarm-node1.vm.ip
}

module "swarm-node2" {
  source = "./modules/vm"
  name   = "swarm-02.prod"
  node_name = data.proxmox_virtual_environment_node.node13.node_name
  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.0.112/16"
  gateway = "192.168.0.254"
  agent_enable = true

}

resource "infomaniak_record" "swarm-node2" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.swarm-node2.vm.hostname
  type = "A"
  ttl = 300
  target = module.swarm-node2.vm.ip
}

module "swarm-node3" {
  source = "./modules/vm"
  name   = "swarm-03.prod"
  node_name = data.proxmox_virtual_environment_node.node11.node_name
  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.0.113/16"
  gateway = "192.168.0.254"
  agent_enable = true
}

resource "infomaniak_record" "swarm-node3" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.swarm-node3.vm.hostname
  type = "A"
  ttl = 300
  target = module.swarm-node3.vm.ip
}