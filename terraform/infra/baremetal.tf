module "proxmox01" {
  source = "./modules/bare_metal"

  hostname = "proxmox01"
  ip       = "192.168.0.211"
  username = "root"
}

module "proxmox02" {
  source = "./modules/bare_metal"

  hostname = "proxmox01"
  ip       = "192.168.0.212"
  username = "root"
}

module "proxmox03" {
  source = "./modules/bare_metal"

  hostname = "proxmox01"
  ip       = "192.168.0.213"
  username = "root"
}

module "pbs01" {
  source = "./modules/bare_metal"

  hostname = "pbs01"
  ip       = "192.168.0.214"
  username = "root"
}

module "proxy01" {
  source = "./modules/bare_metal"


  hostname = "proxy01"
  ip       = "192.168.0.20"
  username = "root"
  port = 5789
}