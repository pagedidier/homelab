terraform {
  required_providers {
    infomaniak = {
      source  = "Infomaniak/infomaniak"
      version = "1.4.1"
    }
  }
}

resource "infomaniak_record" "srv_record" {
  zone_fqdn = var.zone_fqdn
  source    = var.dns_source
  type      = "SRV"
  ttl       = var.ttl
  data = {
    target   = var.target
    priority = var.priority
    weight   = var.weight
    port     = var.port
  }
}