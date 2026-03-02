module "vps01" {
  source = "./modules/bare_metal"

  hostname    = "vps01"
  ip          = "83.228.212.138"
  username    = "ansible"
  domain_name = infomaniak_zone.twop.fqdn

  tags = ["vps"]

}

resource "infomaniak_record" "vps01" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source    = module.vps01.server.name
  type      = "A"
  ttl       = 300
  target    = module.vps01.server.ip
}
