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
  url         = "https://k3s.prod.${var.domain_name}"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "nxtcld" {
  name        = "Nextcloud"
  url         = "https://nxtcld.${var.domain_name}"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "cheap" {
  name        = "Cheap"
  url         = "https://cheap.${var.domain_name}"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "autodel" {
  name        = "Autodel"
  url         = "https://autodel.${var.domain_name}/healthcheck"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "vault" {
  name        = "Vault"
  url         = "https://vault.${var.domain_name}/sys/health"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "vault_infra" {
  name        = "Vault infra"
  url         = "https://vault.infra.${var.domain_name}/sys/health"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "argocd" {
  name        = "Argocd"
  url         = "https://argocd.${var.domain_name}"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "grafana" {
  name        = "Grafana"
  url         = "https://grafana.${var.domain_name}"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "audiobookshelf" {
  name        = "Audiobookshelf"
  url         = "https://audio.${var.domain_name}"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "plex" {
  name        = "Plex"
  url         = "https://plex.${var.domain_name}/web/"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_monitor_http" "prometheus" {
  name        = "Prometheus"
  url         = "https://prometheus.${var.domain_name}"
  interval    = 60
  timeout     = 30
  max_retries = 3
  active      = true
}

resource "uptimekuma_notification_telegram" "example" {
  name       = "Telegram Notifications"
  bot_token  = var.uptimekuma_telegram_bot_token
  chat_id    = var.uptimekuma_telegram_chat_id
  is_active  = true
  is_default = false
}
