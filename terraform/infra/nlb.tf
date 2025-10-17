module "nlb01" {
  source = "./modules/ct"

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password

  name = "nlb01"
  node_name = module.proxmox11.proxmox_data.node_name
  node_ip =  module.proxmox11.proxmox.ip


  cpu_cores = 2
  disk_size = 20
  memory = 2048
  swap = 512

  file_template_id = "isos-templates:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  operating_system_type = "ubuntu"

  network_interface_bridge = "vmbr0"
  network_interface_name = "eth0"

  gateway = "192.168.0.254"
  ip      = "192.168.1.241/16"
  volume_name = "local-lvm"
}

resource "infomaniak_record" "nlb01" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.nlb01.container.hostname
  type = "A"
  ttl = 300
  target = module.nlb01.container.ip
}

module "nlb02" {
  source = "./modules/ct"

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password

  name = "nlb02"
  node_name = module.proxmox13.proxmox_data.node_name
  node_ip =  module.proxmox13.proxmox.ip


  cpu_cores = 2
  disk_size = 20
  memory = 2048
  swap = 512

  file_template_id = "isos-templates:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  operating_system_type = "ubuntu"

  network_interface_bridge = "vmbr0"
  network_interface_name = "eth0"

  gateway = "192.168.0.254"
  ip      = "192.168.1.242/16"
  volume_name = "local-lvm"
}

resource "infomaniak_record" "nlb02" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.nlb02.container.hostname
  type = "A"
  ttl = 300
  target = module.nlb02.container.ip
}