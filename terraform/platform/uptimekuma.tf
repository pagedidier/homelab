resource "uptimekuma_monitor_http" "divertin" {
  name     = "Divert'in website"
  url      = "https://divertin.ch"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "echoduchene" {
  name        = "Echoduchene website"
  url         = "https://echoduchene.ch"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
  ignore_tls                 = true
}

resource "uptimekuma_monitor_http" "k3s_prod" {
  name        = "k3s prod"
  url         = "https://k3s.prod.twop.ch"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "nxtcld" {
  name        = "Nextcloud"
  url         = "https://nxtcld.twop.ch"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "cheap" {
  name        = "Cheap"
  url         = "https://cheap.twop.ch"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "autodel" {
  name        = "Autodel"
  url         = "https://autodel.twop.ch/healthcheck"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "vault" {
  name        = "Vault"
  url         = "https://vault.twop.ch/sys/health"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "vault_infra" {
  name        = "Vault infra"
  url         = "https://vault.infra.twop.ch/sys/health"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "argocd" {
  name        = "Argocd"
  url         = "https://argocd.twop.ch"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "grafana" {
  name        = "Grafana"
  url         = "https://grafana.twop.ch"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "audiobookshelf" {
  name        = "Audiobookshelf"
  url         = "https://audio.twop.ch"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "plex" {
  name        = "Plex"
  url         = "https://plex.twop.ch/web/"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "prometheus" {
  name        = "Prometheus"
  url         = "https://prometheus.twop.ch"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}