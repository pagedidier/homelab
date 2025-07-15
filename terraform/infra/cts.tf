module "prometheus-prod" {
  source = "./modules/ct"

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password

  name = "prometheus.prod"
  node_name = data.proxmox_virtual_environment_node.node11.node_name

  cpu_cores = 2
  disk_size = 20
  memory = 2048
  swap = 512

  file_template_id = "isos-templates:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  operating_system_type = "ubuntu"

  network_interface_bridge = "vmbr0"
  network_interface_name = "eth0"

  gateway = "192.168.0.254"
  ip      = "192.168.1.100/16"
}

resource "infomaniak_record" "prometheus-prod" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.prometheus-prod.container.hostname
  type = "A"
  ttl = 300
  target = module.prometheus-prod.container.ip
}


