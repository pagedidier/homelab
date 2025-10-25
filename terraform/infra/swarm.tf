module "swarm-node1" {
  source = "./modules/vm"
  name   = "swarm-01.prod"
  node_name = module.proxmox12.proxmox_data.node_name

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.0.111/16"
  gateway = "192.168.0.254"
  agent_enable = true
  disk_size = 30
  attached_disk = [
    {
      datastore_id = "local-lvm"
      interface    = "virtio1"
      disk_size    = 60
      iothread = true
    }
  ]

}

resource "infomaniak_record" "swarm-node1" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.swarm-node1.vm.hostname
  type = "A"
  ttl = 300
  target = module.swarm-node1.vm.ip
}

resource "time_sleep" "wait_30_seconds1" {
  depends_on = [module.swarm-node1]

  create_duration = "30s"
}

module "swarm-node2" {
  source = "./modules/vm"
  name   = "swarm-02.prod"
  node_name = module.proxmox13.proxmox_data.node_name

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.0.112/16"
  gateway = "192.168.0.254"
  agent_enable = true
  disk_size = 30
  attached_disk = [
    {
      datastore_id = "local-lvm"
      interface    = "virtio1"
      disk_size    = 40
      iothread = true
    }
  ]

  depends_on = [time_sleep.wait_30_seconds1]
}

resource "infomaniak_record" "swarm-node2" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.swarm-node2.vm.hostname
  type = "A"
  ttl = 300
  target = module.swarm-node2.vm.ip
}

resource "time_sleep" "wait_30_seconds2" {
  depends_on = [module.swarm-node2]

  create_duration = "30s"
}

module "swarm-node3" {
  source = "./modules/vm"
  name   = "swarm-03.prod"
  node_name = module.proxmox11.proxmox_data.node_name

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.0.113/16"
  gateway = "192.168.0.254"
  agent_enable = true
  disk_size = 30
  attached_disk = [
    {
      datastore_id = "local-lvm"
      interface    = "virtio1"
      disk_size    = 40
      iothread = true
    }
  ]
  depends_on = [time_sleep.wait_30_seconds2]
}

resource "infomaniak_record" "swarm-node3" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.swarm-node3.vm.hostname
  type = "A"
  ttl = 300
  target = module.swarm-node3.vm.ip
}

module "swarm-node11" {
  source = "./modules/vm"
  name   = "swarm-11.prod"
  node_name = module.proxmox21.proxmox_data.node_name

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.1.48/16"
  gateway = "192.168.1.1"
  agent_enable = true
  image_storage_name = "local"
  enable_usb = true
  usb_host = "2-3"
  providers = {
    proxmox = proxmox.pvc02,
  }

}

resource "infomaniak_record" "swarm-node11" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.swarm-node11.vm.hostname
  type = "A"
  ttl = 300
  target = module.swarm-node11.vm.ip
}

resource "infomaniak_record" "swarm-node11-plex" {
  zone_fqdn = infomaniak_zone.nohanbudry.fqdn
  source = "plex"
  type = "A"
  ttl = 300
  target = module.swarm-node11.vm.ip
}
