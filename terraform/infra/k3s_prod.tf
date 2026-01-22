module "k3s-server01-prod" {
  source    = "./modules/vm_ci"
  name      = "k3s-server01.prod"
  node_name = module.proxmox11.proxmox_data.node_name

  init_ssh_keys      = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes       = 8192
  ip                 = "192.168.1.51/16"
  gateway            = "192.168.0.254"
  agent_enable       = true
  disk_size          = 30
  user_data_file_id  = proxmox_virtual_environment_file.user_data_cloud_config.id
  domain_name        = infomaniak_zone.twop.fqdn

}



resource "infomaniak_record" "k3s-server01-prod" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source    = module.k3s-server01-prod.vm.name
  type      = "A"
  ttl       = 300
  target    = module.k3s-server01-prod.vm.ip
}

module "k3s-server02-prod" {
  source    = "./modules/vm_ci"
  name      = "k3s-server02.prod"
  node_name = module.proxmox12.proxmox_data.node_name

  init_ssh_keys      = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes       = 8192
  ip                 = "192.168.1.52/16"
  gateway            = "192.168.0.254"
  agent_enable       = true
  disk_size          = 30
  user_data_file_id  = proxmox_virtual_environment_file.user_data_cloud_config.id
  domain_name        = infomaniak_zone.twop.fqdn

}

resource "infomaniak_record" "k3s-server02-prod" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source    = module.k3s-server02-prod.vm.name
  type      = "A"
  ttl       = 300
  target    = module.k3s-server02-prod.vm.ip
}


module "k3s-server03-prod" {
  source    = "./modules/vm_ci"
  name      = "k3s-server03.prod"
  node_name = module.proxmox13.proxmox_data.node_name

  init_ssh_keys      = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes       = 8192
  ip                 = "192.168.1.53/16"
  gateway            = "192.168.0.254"
  agent_enable       = true
  disk_size          = 30
  user_data_file_id  = proxmox_virtual_environment_file.user_data_cloud_config.id

  domain_name = infomaniak_zone.twop.fqdn

}

resource "infomaniak_record" "k3s-server03-prod" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source    = module.k3s-server03-prod.vm.name
  type      = "A"
  ttl       = 300
  target    = module.k3s-server03-prod.vm.ip
}