module "k3s-node1-dev" {
  source = "./modules/vm_ci"
  name   = "k3s-01.dev"
  node_name = module.proxmox12.proxmox_data.node_name

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.2.51/16"
  gateway = "192.168.0.254"
  agent_enable = true
  disk_size = 30
  user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
}

resource "infomaniak_record" "k3s-node1-dev" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.k3s-node1-dev.vm.hostname
  type = "A"
  ttl = 300
  target = module.k3s-node1-dev.vm.ip
}


module "k3s-node2-dev" {
  source = "./modules/vm_ci"
  name   = "k3s-02.dev"
  node_name = module.proxmox13.proxmox_data.node_name

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.2.52/16"
  gateway = "192.168.0.254"
  agent_enable = true
  disk_size = 30
  user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id

}

resource "infomaniak_record" "k3s-node2-dev" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.k3s-node2-dev.vm.hostname
  type = "A"
  ttl = 300
  target = module.k3s-node2-dev.vm.ip
}


module "k3s-node3-dev" {
  source = "./modules/vm_ci"
  name   = "k3s-03.dev"
  node_name = module.proxmox11.proxmox_data.node_name

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.2.53/16"
  gateway = "192.168.0.254"
  agent_enable = true
  disk_size = 30
  user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id

}

resource "infomaniak_record" "k3s-node3-dev" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.k3s-node3-dev.vm.hostname
  type = "A"
  ttl = 300
  target = module.k3s-node3-dev.vm.ip
}