module "nlb01_vm" {
  source    = "./modules/vm_ci"
  name      = "nlb01"
  node_name = module.proxmox11.proxmox_data.node_name

  init_ssh_keys      = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes       = 1024
  ip                 = "192.168.1.241/16"
  gateway            = "192.168.0.254"
  agent_enable       = true
  disk_size          = 10
  user_data_file_id  = proxmox_virtual_environment_file.user_data_cloud_config.id
  domain_name        = infomaniak_zone.twop.fqdn
  volume_name        = "vm-disks"

}

resource "infomaniak_record" "nlb01" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source    = module.nlb01_vm.vm.name
  type      = "A"
  ttl       = 300
  target    = module.nlb01_vm.vm.ip
}