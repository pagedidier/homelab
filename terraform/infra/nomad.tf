module "nomad-server01" {
  source = "./modules/vm"
  name   = "nomad-server01.prod"
  node_name = module.proxmox12.proxmox_data.node_name
  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.0.131/16"
  gateway = "192.168.0.254"
  agent_enable = true
  volume_name = "vm-disks"

}

resource "infomaniak_record" "nomad-server01" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.nomad-server01.vm.hostname
  type = "A"
  ttl = 300
  target = module.nomad-server01.vm.ip
}

module "nomad-client01" {
  source = "./modules/vm"
  name   = "nomad-client01.prod"
  node_name = module.proxmox12.proxmox_data.node_name
  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.0.141/16"
  gateway = "192.168.0.254"
  agent_enable = true
  volume_name = "vm-disks"

}

resource "infomaniak_record" "nomad-client01" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.nomad-client01.vm.hostname
  type = "A"
  ttl = 300
  target = module.nomad-client01.vm.ip
}