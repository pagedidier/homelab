module "test-ha" {
  source = "./modules/ct"

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password

  name = "test-ha"
  node_name = module.proxmox12.proxmox_data.node_name
  node_ip =  module.proxmox12.proxmox.ip


  cpu_cores = 2
  disk_size = 20
  memory = 2048
  swap = 512

  file_template_id = "isos-templates:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  operating_system_type = "ubuntu"

  network_interface_bridge = "vmbr0"
  network_interface_name = "eth0"

  gateway = "192.168.0.254"
  ip      = "192.168.100.10/16"
  volume_name = "vm-disks"
}

resource "proxmox_virtual_environment_haresource" "test-ha-main" {
  depends_on = [
    proxmox_virtual_environment_hagroup.main
  ]
  resource_id = "ct:${module.test-ha.container.id}"
  state       = "started"
  group       = proxmox_virtual_environment_hagroup.main.id
  comment     = "Managed by Terraform"
}

