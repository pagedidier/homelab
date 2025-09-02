resource "docker_network" "monitoring_stack" {
  name   = "monitoring_stack"
  driver = "overlay"
}

resource "docker_volume" "grafana_data" {
  name = "grafana-data"
  driver = "local"
  driver_opts = {
    type   = "none"
    device = "/mnt/cephfs/grafana/data"
    o      = "bind"
  }
}

resource "docker_volume" "grafana_config" {
  name   = "grafana-config"
  driver = "local"
  driver_opts = {
    type   = "none"
    device = "/mnt/cephfs/grafana/conf"
    o      = "bind"
  }
}
resource "docker_image" "grafana" {
  name = "grafana/grafana:12.1"
}
resource "docker_service" "grafana" {
  name = "grafana"

  task_spec {
    container_spec {
      image = docker_image.grafana.repo_digest

      env = {
        GF_SERVER_ROOT_URL="https://grafana.twop.ch"
      }


      mounts {
        target = "/var/lib/grafana"
        source = docker_volume.grafana_data.name
        type   = "volume"

      }

      mounts {
        target = "/etc/grafana"
        source = docker_volume.grafana_config.name
        type   = "volume"
      }
    }
    networks_advanced {
      name = docker_network.monitoring_stack.name
    }
  }

  endpoint_spec {
    ports {
      published_port = 3000
      target_port    = 3000
      protocol       = "tcp"
      publish_mode   = "ingress"
    }
  }

  mode {
    replicated {
      replicas = 1
    }
  }
}
