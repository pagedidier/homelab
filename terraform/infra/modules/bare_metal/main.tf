resource "null_resource" "server" {

}

output "server" {
  value = {
    "ip": var.ip,
    "username": var.username
    "hostname": var.hostname
    "port": var.port,
  }
}