module "ai-worker" {
  source    = "./modules/vm"
  name      = "ai-worker"
  node_name = module.proxmox13.proxmox_data.node_name

  init_ssh_keys      = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes       = 8192
  nb_cpus            = 4
  ip                 = "192.168.11.11/16"
  gateway            = "192.168.0.254"
  volume_name        = "vm-disks"
  domain_name        = infomaniak_zone.twop.fqdn
  main_disk_backup   = true
  tags               = ["ai-worker"]

}

resource "infomaniak_record" "ai-worker" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source    = module.ai-worker.vm.name
  type      = "A"
  ttl       = 300
  target    = module.ai-worker.vm.ip
}