#
# resource "proxmox_virtual_environment_download_file" "noble-tmpl" {
#  content_type        = "vztmpl"
#  datastore_id        = "isos-templates"
#  node_name           = data.proxmox_virtual_environment_node.node11.node_name
#  url                 = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.tar.gz"
#  upload_timeout      = 4444
#  overwrite_unmanaged = true
# }
#
# resource "proxmox_virtual_environment_download_file" "noble-iso" {
#   content_type        = "iso"
#   datastore_id        = "isos-templates"
#   node_name           = data.proxmox_virtual_environment_node.node11.node_name
#   url                 = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
#   upload_timeout      = 4444
#   overwrite_unmanaged = true
# }
#
# resource "proxmox_virtual_environment_download_file" "debian12-tmpl" {
#   content_type        = "vztmpl"
#   datastore_id        = "isos-templates"
#   node_name           = data.proxmox_virtual_environment_node.node11.node_name
#   url                 = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.tar.xz"
#   upload_timeout      = 4444
#   overwrite_unmanaged = true
# }
#
# resource "proxmox_virtual_environment_download_file" "debian12-iso" {
#   content_type        = "iso"
#   datastore_id        = "isos-templates"
#   node_name           = data.proxmox_virtual_environment_node.node11.node_name
#   url                 = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
#   upload_timeout      = 4444
#   overwrite_unmanaged = true
#   file_name    = "debian-12-generic-amd64.qcow2.img"
# }
#
# resource "proxmox_virtual_environment_download_file" "debian12-iso-netinstall" {
#   content_type        = "iso"
#   datastore_id        = "isos-templates"
#   node_name           = data.proxmox_virtual_environment_node.node11.node_name
#   url                 = "https://cdimage.debian.org/cdimage/archive/12.0.0/amd64/iso-cd/debian-12.0.0-amd64-netinst.iso"
#   upload_timeout      = 4444
#   overwrite_unmanaged = true
# }
