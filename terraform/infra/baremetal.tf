module "proxmox11" {
  source = "./modules/bare_metal_proxmox"

  hostname = "proxmox11"
  ip       = "192.168.0.211"
  username = "root"
}

resource "infomaniak_record" "proxmox11" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.proxmox11.proxmox.hostname
  type = "A"
  ttl = 300
  target = module.proxmox11.proxmox.ip
}

module "proxmox21" {
  source = "./modules/bare_metal_proxmox"

  hostname = "proxmox21"
  ip       = "51.154.10.38"
  username = "root"
  port = 5789
  providers = {
    proxmox = proxmox.pvc02,
  }
}

resource "infomaniak_record" "proxmox21" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.proxmox21.proxmox.hostname
  type = "A"
  ttl = 300
  target = module.proxmox21.proxmox.ip
}

module "proxmox12" {
  source = "./modules/bare_metal_proxmox"

  hostname = "proxmox12"
  ip       = "192.168.0.212"
  username = "root"
}

resource "infomaniak_record" "proxmox12" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.proxmox12.proxmox.hostname
  type = "A"
  ttl = 300
  target = module.proxmox12.proxmox.ip
}

module "proxmox13" {
  source = "./modules/bare_metal_proxmox"

  hostname = "proxmox13"
  ip       = "192.168.0.213"
  username = "root"
}

resource "infomaniak_record" "proxmox13" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.proxmox13.proxmox.hostname
  type = "A"
  ttl = 300
  target = module.proxmox13.proxmox.ip
}

module "pbs01" {
  source = "./modules/bare_metal"

  hostname = "pbs01"
  ip       = "192.168.0.214"
  username = "root"
}

resource "infomaniak_record" "pbs01" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.pbs01.server.hostname
  type = "A"
  ttl = 300
  target = module.pbs01.server.ip
}

module "proxy01" {
  source = "./modules/bare_metal"
  hostname = "proxy01"
  ip       = "192.168.0.20"
  username = "root"
  port = 5789
}

resource "infomaniak_record" "proxy01" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.proxy01.server.hostname
  type = "A"
  ttl = 300
  target = module.proxy01.server.ip
}

module "nas01" {
  source = "./modules/bare_metal"
  hostname = "nas01"
  ip       = "192.168.0.29"
  username = "root"
  port = 22
}

resource "infomaniak_record" "nas01" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.nas01.server.hostname
  type = "A"
  ttl = 300
  target = module.nas01.server.ip
}

resource "infomaniak_record" "pvc01" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = "pvc01"
  type = "A"
  ttl = 300
  target = infomaniak_record.proxy01_private.target
}

resource "infomaniak_record" "pbc01" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = "pbc01"
  type = "A"
  ttl = 300
  target = infomaniak_record.proxy01_private.target
}