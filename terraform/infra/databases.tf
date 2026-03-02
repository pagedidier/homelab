module "database-prod" {
  source = "./modules/ct"

  init_ssh_keys      = var.init_ssh_keys
  init_user_password = var.init_user_password

  name      = "database.prod"
  node_name = module.proxmox12.proxmox_data.node_name
  node_ip   = module.proxmox12.proxmox.ip

  cpu_cores = 2
  disk_size = 20
  memory    = 2048
  swap      = 512

  file_template_id      = "isos-templates:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  operating_system_type = "ubuntu"

  network_interface_bridge = "vmbr0"
  network_interface_name   = "eth0"

  gateway     = "192.168.0.254"
  ip          = "192.168.1.110/16"
  volume_name = "vm-disks"
  domain_name = infomaniak_zone.twop.fqdn

  tags = ["databases"]

}

resource "infomaniak_record" "database-prod" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source    = module.database-prod.container.name
  type      = "A"
  ttl       = 300
  target    = module.database-prod.container.ip
}