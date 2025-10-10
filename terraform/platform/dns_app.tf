resource "infomaniak_record" "twop_grafana" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "grafana"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.public.twop.ch"
}
resource "infomaniak_record" "twop_vault" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "vault"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.public.twop.ch"
}

resource "infomaniak_record" "twop_pvc01" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "pvc01"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.private.twop.ch"
}

resource "infomaniak_record" "twop_pbc01" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "pbc01"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.private.twop.ch"
}