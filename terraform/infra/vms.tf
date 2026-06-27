module "glrunner" {
  source    = "./modules/vm"
  name      = "glrunner"
  node_name = module.proxmox12.proxmox_data.node_name

  init_ssh_keys      = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes       = 2048
  ip                 = "192.168.1.120/16"
  gateway            = "192.168.0.254"
  volume_name        = "vm-disks"
  domain_name        = infomaniak_zone.twop.fqdn
  main_disk_backup   = false
  tags               = ["glrunners"]

}

resource "infomaniak_record" "glrunner" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source    = module.glrunner.vm.name
  type      = "A"
  ttl       = 300
  target    = module.glrunner.vm.ip
}
