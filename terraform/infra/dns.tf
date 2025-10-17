resource "infomaniak_zone" "twop" {
  fqdn = "twop.ch"
}

resource "infomaniak_zone" "nohanbudry" {
  fqdn = "nohanbudry.com"
}

resource "infomaniak_record" "nbl_ff" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "nlb.ff"
  type = "A"
  ttl = 300
  target = "144.2.101.99"
}

resource "infomaniak_record" "proxy01_public" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "proxy01.public"
  type = "CNAME"
  ttl = 300
  target = "nlb.ff.${infomaniak_zone.twop.fqdn}"
}

resource "infomaniak_record" "proxy01_private" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "proxy01.private"
  type = "CNAME"
  ttl = 300
  target = "nlb.fip.private.${infomaniak_zone.twop.fqdn}"
}

resource "infomaniak_record" "nlb_fip_private" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "nlb.fip.private"
  type = "A"
  ttl = 300
  target = "192.168.1.253"
}


resource "infomaniak_record" "nlb_fip_public" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "nlb.fip.public"
  type = "A"
  ttl = 300
  target = "192.168.1.246" # DMZ by the router same as nlb.ff
}

