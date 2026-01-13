resource "null_resource" "server" {

}

output "server" {
  value = {
    "ip" : var.ip,
    "username" : var.username
    "name" : var.hostname
    "hostname" = "${var.hostname}${var.domain_name != "" ? ".${var.domain_name}" : ""}"
    "port" : var.port,
  }
}