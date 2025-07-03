# provider "dns" {
#   update {
#     server        = "192.168.0.20"
#     port = "53"
#     key_name      = "tsig-key."
#     key_algorithm = "hmac-sha256"
#     key_secret    = "Ou7vaDujRfS/eYu6ltV12gDwkFK/u8zXdPUaA0VPR80="
#   }
# }
#
# resource "dns_a_record_set" "www" {
#   zone = "example.com."
#   name = "test-tf2"
#   addresses = [
#     "192.168.0.1",
#     "192.168.0.2",
#     "192.168.0.4",
#   ]
#   ttl = 300
# }
#
# resource "dns_a_record_set" "www1" {
#   zone = "example.com."
#   name = "test222222"
#   addresses = [
#     "192.168.0.1",
#     "192.168.0.2",
#     "192.168.0.4",
#   ]
#   ttl = 300
# }