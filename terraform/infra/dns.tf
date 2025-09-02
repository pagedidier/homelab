data "infomaniak_zone" "twop" {
  fqdn = "twop.ch"
}
data "infomaniak_zone" "nohanbudry" {
  fqdn = "nohanbudry.com"
}

resource "infomaniak_record" "proxy01_public" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = "proxy01.public"
  type = "A"
  ttl = 300
  target = "144.2.101.99"
}

resource "infomaniak_record" "proxy01_private" {
  zone_name = data.infomaniak_zone.twop.fqdn
  source = "proxy01.private"
  type = "A"
  ttl = 300
  target = "192.168.0.21"
}