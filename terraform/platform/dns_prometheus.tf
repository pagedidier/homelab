module "graphite_exporter_proxmox11" {
  source = "./modules/dns/srv"
  zone_fqdn = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_graphite-exporter"
  target = "proxmox11.twop.ch"
  port = 9108
}

module "graphite_exporter_proxmox12" {
  source = "./modules/dns/srv"
  zone_fqdn = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_graphite-exporter"
  target = "proxmox12.twop.ch"
  port = 9108
}

module "graphite_exporter_proxmox13" {
  source = "./modules/dns/srv"
  zone_fqdn = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_graphite-exporter"
  target = "proxmox13.twop.ch"
  port = 9108
}

module "node_exporter_proxmox11" {
  source = "./modules/dns/srv"
  zone_fqdn = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_node-exporter"
  target = "proxmox11.twop.ch"
  port = 9100
}

module "node_exporter_proxmox12" {
  source = "./modules/dns/srv"
  zone_fqdn = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_node-exporter"
  target = "proxmox12.twop.ch"
  port = 9100
}

module "node_exporter_proxmox13" {
  source = "./modules/dns/srv"
  zone_fqdn = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_node-exporter"
  target = "proxmox13.twop.ch"
  port = 9100
}

module "ceph_exporter_proxmox11" {
  source = "./modules/dns/srv"
  zone_fqdn = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_ceph-exporter"
  target = "proxmox11.twop.ch"
  port = 9128
}

module "ceph_exporter_proxmox12" {
  source = "./modules/dns/srv"
  zone_fqdn = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_ceph-exporter"
  target = "proxmox12.twop.ch"
  port = 9128
}

module "ceph_exporter_proxmox13" {
  source = "./modules/dns/srv"
  zone_fqdn = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_ceph-exporter"
  target = "proxmox13.twop.ch"
  port = 9128
}

module "ceph_exporter_swarm01" {
  source = "./modules/dns/srv"
  zone_fqdn = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_ceph-exporter"
  target = "swarm-01.prod.twop.ch"
  port = 9128
}

module "ceph_exporter_swarm02" {
  source = "./modules/dns/srv"
  zone_fqdn = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_ceph-exporter"
  target = "swarm-02.prod.twop.ch"
  port = 9128
}

module "ceph_exporter_swarm03" {
  source = "./modules/dns/srv"
  zone_fqdn = infomaniak_zone._tcp_twop.fqdn
  dns_source = "_ceph-exporter"
  target = "swarm-03.prod.twop.ch"
  port = 9128
}