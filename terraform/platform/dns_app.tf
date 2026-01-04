resource "infomaniak_record" "twop_grafana" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "grafana"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.private.twop.ch"
}

resource "infomaniak_record" "twop_homepage" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "homepage"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.private.twop.ch"
}

resource "infomaniak_record" "twop_prometheus" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "prometheus"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.private.twop.ch"
}

resource "infomaniak_record" "twop_traefik" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "traefik"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.private.twop.ch"
}

resource "infomaniak_record" "twop_uptimekuma" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "uptimekuma"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.private.twop.ch"
}

resource "infomaniak_record" "twop_checkmk" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "checkmk"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.private.twop.ch"
}

resource "infomaniak_record" "twop_vault" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "vault"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.private.twop.ch"
}

resource "infomaniak_record" "twop_vault_infra" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "vault.infra"
  type = "CNAME"
  ttl = "300"
  target = "vps01.twop.ch"
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

resource "infomaniak_record" "twop_k3s_api" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "k3s.api.prod"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.private.twop.ch"
}

resource "infomaniak_record" "twop_k3s_prod" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "k3s.prod"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.private.twop.ch"
}

resource "infomaniak_record" "twop_k3s_dev" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "k3s.dev"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.private.twop.ch"
}

resource "infomaniak_record" "twop_k3s" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "k3s"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.private.twop.ch"
}

resource "infomaniak_record" "zabbix" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "zabbix"
  type = "CNAME"
  ttl = "300"
  target = "vps01.ovh.twop.ch"
}

resource "infomaniak_record" "timer-dev" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "timer.dev"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.private.twop.ch"
}

resource "infomaniak_record" "twop_traefik_k3s_prod" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "traefik.k3s.prod"
  type = "CNAME"
  ttl = "300"
  target = "k3s-server01.prod.twop.ch"
}

resource "infomaniak_record" "autodel" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "autodel"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.public.twop.ch"
}

resource "infomaniak_record" "audiobookshelf" {
  zone_fqdn = infomaniak_zone.twop.fqdn
  source = "audio-new"
  type = "CNAME"
  ttl = "300"
  target = "proxy01.public.twop.ch"
}