module "glrunner" {
  source    = "./modules/vm"
  name      = "glrunner"
  node_name = module.proxmox12.proxmox_data.node_name

  init_ssh_keys      = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes       = 8192
  nb_cpus            = 4
  ip                 = "192.168.1.120/16"
  gateway            = "192.168.0.254"
  volume_name        = "vm-disks"
  domain_name        = infomaniak_zone.twop.fqdn
  main_disk_backup   = false
  tags               = ["glrunners"]
  disk_size          = 50

}

resource "infomaniak_record" "glrunner" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source    = module.glrunner.vm.name
  type      = "A"
  ttl       = 300
  target    = module.glrunner.vm.ip
}

module "anywhere" {
  source    = "./modules/vm"
  name      = "anywhere"
  node_name = module.proxmox11.proxmox_data.node_name

  init_ssh_keys      = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes       = 8192
  ip                 = "192.168.200.1/16"
  gateway            = "192.168.0.254"
  volume_name        = "vm-disks"
  domain_name        = infomaniak_zone.twop.fqdn
  main_disk_backup   = false
  started = false
  tags               = []
}

# module "test-upgrade" {
#   source    = "./modules/vm"
#   name      = "test-upgrade"
#   node_name = module.proxmox13.proxmox_data.node_name
#
#   init_ssh_keys      = var.init_ssh_keys
#   init_user_password = var.init_user_password
#   init_user_username = var.init_user_username
#   ram_in_bytes       = 8192
#   nb_cpus            = 4
#   ip                 = "192.168.100.100/16"
#   gateway            = "192.168.0.254"
#   domain_name        = infomaniak_zone.twop.fqdn
#   main_disk_backup   = false
#   tags               = ["test-upgrade"]
#   disk_size          = 20
#
# }
#
# resource "infomaniak_record" "test-upgrade" {
#   zone_fqdn = infomaniak_zone.twop.fqdn
#   source    = module.test-upgrade.vm.name
#   type      = "A"
#   ttl       = 300
#   target    = module.test-upgrade.vm.ip
# }