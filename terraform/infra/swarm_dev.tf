module "swarm-node1-dev" {
  source = "./modules/vm"
  name   = "swarm-01.dev"
  node_name = module.proxmox12.proxmox_data.node_name

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.1.111/16"
  gateway = "192.168.0.254"
  agent_enable = false
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

resource "infomaniak_record" "swarm-node1-dev" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.swarm-node1-dev.vm.hostname
  type = "A"
  ttl = 300
  target = module.swarm-node1-dev.vm.ip
}


module "swarm-node2-dev" {
  source = "./modules/vm"
  name   = "swarm-02.dev"
  node_name = module.proxmox13.proxmox_data.node_name

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.1.112/16"
  gateway = "192.168.0.254"
  agent_enable = false
  disk_size = 30
  attached_disk = [
    {
      datastore_id = "local-lvm"
      interface    = "virtio1"
      disk_size    = 40
      iothread = true
    }
  ]
}

resource "infomaniak_record" "swarm-node2-dev" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.swarm-node2-dev.vm.hostname
  type = "A"
  ttl = 300
  target = module.swarm-node2-dev.vm.ip
}


module "swarm-node3-dev" {
  source = "./modules/vm"
  name   = "swarm-03.dev"
  node_name = module.proxmox11.proxmox_data.node_name

  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.1.113/16"
  gateway = "192.168.0.254"
  agent_enable = false
  disk_size = 30
  attached_disk = [
    {
      datastore_id = "local-lvm"
      interface    = "virtio1"
      disk_size    = 40
      iothread = true
    }
  ]
}

resource "infomaniak_record" "swarm-node3-dev" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = module.swarm-node3-dev.vm.hostname
  type = "A"
  ttl = 300
  target = module.swarm-node3-dev.vm.ip
}