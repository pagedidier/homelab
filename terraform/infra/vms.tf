module "k3s-node1" {
  source = "./modules/vm"
  name   = "k3s-01.prod"
  node_name = module.proxmox11.proxmox_data.node_name

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 8192
  ip="192.168.1.51/16"
  gateway = "192.168.0.254"
  volume_name = "vm-disks"

}

resource "infomaniak_record" "k3s-node1" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.k3s-node1.vm.hostname
  type = "A"
  ttl = 300
  target = module.k3s-node1.vm.ip
}

module "k3s-node2" {
  source = "./modules/vm"
  name   = "k3s-02.prod"
  node_name = module.proxmox12.proxmox_data.node_name

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 8192
  ip="192.168.1.52/16"
  gateway = "192.168.0.254"
  volume_name = "vm-disks"

}

resource "infomaniak_record" "k3s-node2" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.k3s-node2.vm.hostname
  type = "A"
  ttl = 300
  target = module.k3s-node2.vm.ip
}

module "k3s-node3" {
  source = "./modules/vm"
  name   = "k3s-03.prod"
  node_name = module.proxmox13.proxmox_data.node_name

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 8192
  ip="192.168.1.53/16"
  gateway = "192.168.0.254"
  volume_name = "vm-disks"

}

resource "infomaniak_record" "k3s-node3" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.k3s-node3.vm.hostname
  type = "A"
  ttl = 300
  target = module.k3s-node3.vm.ip
}

module "glrunner" {
  source = "./modules/vm"
  name   = "glrunner"
  node_name = module.proxmox13.proxmox_data.node_name

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 2048
  ip="192.168.1.120/16"
  gateway = "192.168.0.254"
  volume_name = "vm-disks"

}

resource "infomaniak_record" "glrunner" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.glrunner.vm.hostname
  type = "A"
  ttl = 300
  target = module.glrunner.vm.ip
}

# module "test" {
#   source = "./modules/vm"
#   name   = "test.prod"
#   node_name = module.proxmox11.proxmox_data.node_name
#
#   init_ssh_keys = var.init_ssh_keys
#   init_user_password = var.init_user_password
#   init_user_username = var.init_user_username
#   ram_in_bytes = 4096
#   ip="192.168.1.121/16"
#   gateway = "192.168.0.254"
#   volume_name = "vm-disks"
#   user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
#   agent_enable = true
# }
