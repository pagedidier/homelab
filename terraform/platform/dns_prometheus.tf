locals {
  inventory = yamldecode(file("${path.module}/inventory.yaml"))
}

module "dns_twop_node_exporter" {
  for_each   = toset(local.inventory["roles"]["node_exporter"])
  source     = "./modules/dns/srv"
  zone_fqdn  = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_node-exporter"
  target     = each.key
  port       = 9100
}

module "dns_twop_graphite_exporter" {
  for_each   = toset(local.inventory["roles"]["graphite_exporter"])
  source     = "./modules/dns/srv"
  zone_fqdn  = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_graphite-exporter"
  target     = each.key
  port       = 9108
}

module "dns_twop_ceph_exporter" {
  for_each   = toset(concat(local.inventory["roles"]["ceph_exporter"], local.inventory["roles"]["microceph_exporter"]))
  source     = "./modules/dns/srv"
  zone_fqdn  = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_ceph-exporter"
  target     = each.key
  port       = 9128
}


module "dns_twop_cadvisor_lxc" {
  for_each   = toset(local.inventory["roles"]["cadvisor/lxc"])
  source     = "./modules/dns/srv"
  zone_fqdn  = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_cadvisor-lxc"
  target     = each.key
  port       = 9163
}

module "dns_twop_cadvisor_docker" {
  for_each   = toset(local.inventory["roles"]["cadvisor/docker"])
  source     = "./modules/dns/srv"
  zone_fqdn  = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_cadvisor-docker"
  target     = each.key
  port       = 9192
}

module "dns_twop_blackbox_exporter" {
  source     = "./modules/dns/srv_list"
  zone_fqdn  = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_blackbox-exporter"
  targets = [
    "grafana.twop.ch",
    "audio.twop.ch",
    "k3s.prod.twop.ch",
    "nxtcld.twop.ch",
    "plex.twop.ch",
    "pvc01.twop.ch",
    "uptimekuma.twop.ch",
    "vault.twop.ch",
    "transmission.twop.ch"
  ]
  port = 443
}

module "dns_twop_prometheus_federation" {
  source     = "./modules/dns/srv_list"
  zone_fqdn  = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_prometheus-federation"
  targets = [
    "prometheus.k3s.prod.twop.ch",
  ]
  port = 443
}