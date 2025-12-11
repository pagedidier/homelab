module "vpn" {
  source = "./modules/ct"

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password

  name = "vpn"
  node_name = module.proxmox13.proxmox_data.node_name
  node_ip =  module.proxmox13.proxmox.ip


  cpu_cores = 2
  disk_size = 20
  memory = 1024
  swap = 512

  file_template_id = "isos-templates:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  operating_system_type = "ubuntu"

  network_interface_bridge = "vmbr0"
  network_interface_name = "eth0"

  gateway = "192.168.0.254"
  ip      = "192.168.0.1/16"
  volume_name = "vm-disks"
  domain_name = infomaniak_zone.twop.fqdn
}

resource "infomaniak_record" "vpn" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.vpn.container.name
  type = "A"
  ttl = 300
  target = module.vpn.container.ip
}

resource "proxmox_virtual_environment_haresource" "vpn-main" {
  depends_on = [
    proxmox_virtual_environment_hagroup.main
  ]
  resource_id = "ct:${module.vpn.container.id}"
  state       = "started"
  group       = proxmox_virtual_environment_hagroup.main.id
  comment     = "Managed by Terraform"
}