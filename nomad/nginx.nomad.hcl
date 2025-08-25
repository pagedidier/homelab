job "nginx" {
  type = "service"

  group "nginx" {
    count = 1

    network {
      port "http" {
        static = 8080
      }
    }

    task "nginx" {
      driver = "docker"

      config {
        image = "nginx:latest"
        ports = ["http"]
      }

      resources {
        cpu    = 100 # MHz
        memory = 64  # MB
      }
    }

    service {
      name = "nginx"
      port = "http"
      check {
        name     = "nginx-http-check"
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }
  }
}