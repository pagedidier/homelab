module "proxmox01" {
  source = "./modules/bare_metal"

  hostname = "proxmox01"
  ip       = "192.168.0.211"
  username = "root"
}

resource "infomaniak_record" "proxmox01" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.proxmox01.server.hostname
  type = "A"
  ttl = 300
  target = module.proxmox01.server.ip
}

module "proxmox21" {
  source = "./modules/bare_metal"

  hostname = "proxmox21"
  ip       = "51.154.10.38"
  username = "root"
}

resource "infomaniak_record" "proxmox21" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.proxmox21.server.hostname
  type = "A"
  ttl = 300
  target = module.proxmox21.server.ip
}

module "proxmox02" {
  source = "./modules/bare_metal"

  hostname = "proxmox01"
  ip       = "192.168.0.212"
  username = "root"
}

resource "infomaniak_record" "proxmox02" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.proxmox02.server.hostname
  type = "A"
  ttl = 300
  target = module.proxmox02.server.ip
}

module "proxmox03" {
  source = "./modules/bare_metal"

  hostname = "proxmox01"
  ip       = "192.168.0.213"
  username = "root"
}

resource "infomaniak_record" "proxmox03" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = module.proxmox03.server.hostname
  type = "A"
  ttl = 300
  target = module.proxmox03.server.ip
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