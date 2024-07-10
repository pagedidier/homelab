resource "haproxy_backend" "traefik_http" {
  name = "local_traefik_backend_http"
}

resource "haproxy_backend" "proxmox" {
  name = "proxmox"
}

resource "haproxy_server" "proxmox_server" {
  name        = "proxmox_server"
  port        = 8006
  address     = "192.168.0.201"
  parent_name = haproxy_backend.proxmox.name
  parent_type = "backend"
  depends_on  = [haproxy_backend.proxmox]
}

resource "haproxy_server" "server_test" {
  name        = "local_traefik_server"
  port        = 81
  address     = "192.168.0.26"
  parent_name = haproxy_backend.traefik_http.name
  parent_type = "backend"
  depends_on  = [haproxy_backend.traefik_http]
}


resource "haproxy_backend" "k3s" {
  name = "k3s_backend"
}

resource "haproxy_backend" "k3s_api" {
  mode = "tcp"

  name = "k3s_api_backend"

  balance {
    algorithm = "roundrobin"
  }

}


resource "haproxy_server" "server_k3s" {
  name        = "k3s_server"
  port        = 80
  address     = "192.168.0.33"
  parent_name = haproxy_backend.k3s.name
  parent_type = "backend"
  depends_on  = [haproxy_backend.k3s]
}

resource "haproxy_server" "k3s_api_node_1" {
  name        = "k3s_api_node_1"
  port        = 6443
  address     = "192.168.0.33"
  parent_name = haproxy_backend.k3s_api.name
  parent_type = "backend"
  depends_on  = [haproxy_backend.k3s_api]
}

#resource "haproxy_server" "k3s_api_node_2" {
#  name        = "k3s_api_node_2"
#  port        = 6443
#  address     = "192.168.0.34"
#  parent_name = haproxy_backend.k3s_api.name
#  parent_type = "backend"
#  depends_on  = [haproxy_backend.k3s_api]
#}
#
#resource "haproxy_server" "k3s_api_node_3" {
#  name        = "k3s_api_node_3"
#  port        = 6443
#  address     = "192.168.0.35"
#  parent_name = haproxy_backend.k3s_api.name
#  parent_type = "backend"
#  depends_on  = [haproxy_backend.k3s_api]
#}

resource "haproxy_frontend" "nginx" {
  name       = "nginx"
  mode = "tcp"
  backend    = haproxy_backend.traefik_http.name
  depends_on = [haproxy_backend.traefik_http]
}

resource "haproxy_frontend" "kube_apiserver" {
  name       = "kube_apiserver"
  mode = "tcp"
  tcplog                      = true
  backend    = haproxy_backend.k3s_api.name
  depends_on = [haproxy_backend.k3s_api]
}

resource "haproxy_bind" "kube_apiserver_bind" {
  name        = "kube_apiserver_bind"
  port        = 6443
  address     = "0.0.0.0"
  parent_name = haproxy_frontend.kube_apiserver.name
  parent_type = "frontend"
  depends_on  = [haproxy_frontend.kube_apiserver]
}


resource "haproxy_bind" "bind_nginx" {
  name        = "nginx_bind"
  port        = 80
  address     = "0.0.0.0"
  parent_name = haproxy_frontend.nginx.name
  parent_type = "frontend"
  depends_on  = [haproxy_frontend.nginx]
}
resource "haproxy_backend" "letsencrypt_backend" {
  name = "letsencrypt_backend"
}

resource "haproxy_server" "certbot_server" {
  name        = "local_certbot_server"
  port        = 8899
  address     = "127.0.0.1"
  parent_name = haproxy_backend.letsencrypt_backend.name
  parent_type = "backend"
  depends_on  = [haproxy_backend.letsencrypt_backend]
}

resource "haproxy_acl" "proxmox_acl" {
  name        = "host_proxmox.${var.domain_name}"
  index       = 1
  parent_name = haproxy_frontend.nginx.name
  parent_type = "frontend"
  criterion   = "hdr_dom(host)"
  value       = "proxmox.${var.domain_name}"
  depends_on  = [haproxy_frontend.nginx]
}

resource "haproxy_acl" "k3s_api_acl" {
  name        = "host_k3s-node-1.${var.domain_name}"
  index       = 1
  parent_name = haproxy_frontend.nginx.name
  parent_type = "frontend"
  criterion   = "hdr_dom(host)"
  value       = "k3s.${var.domain_name}"
  depends_on  = [haproxy_frontend.nginx]
}