# resource "proxmox_virtual_environment_hagroup" "main" {
#   group   = "main"
#
#   nodes = {
#     proxmox11 = null
#     proxmox12 = null
#     proxmox12 = null
#   }
#
#   restricted  = false
#   no_failback = false
# }
#

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "import"
  datastore_id = "isos-templates"
  #node_name is not really important as the isos-templates is a shared storage
  node_name    = module.proxmox11.proxmox_data.node_name
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  file_name = "noble-server-cloudimg-amd64.qcow2"
}
resource "proxmox_virtual_environment_download_file" "debian_cloud_image" {
  content_type = "import"
  datastore_id = "isos-templates"
  #node_name is not really important as the isos-templates is a shared storage
  node_name    = module.proxmox11.proxmox_data.node_name
  url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
  file_name = "debian-12-genericcloud-amd64.qcow2"
  overwrite=false
}

resource "proxmox_virtual_environment_download_file" "debian_generic_image" {
  content_type = "import"
  datastore_id = "isos-templates"
  #node_name is not really important as the isos-templates is a shared storage
  node_name    = module.proxmox11.proxmox_data.node_name
  url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
  file_name = "debian-12-generic-amd64.qcow2"
  overwrite=false
}

resource "proxmox_virtual_environment_download_file" "debian_nocloud_image" {
  content_type = "import"
  datastore_id = "isos-templates"
  #node_name is not really important as the isos-templates is a shared storage
  node_name    = module.proxmox11.proxmox_data.node_name
  url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-nocloud-amd64.qcow2"
  file_name = "debian-12-nocloud-amd64.qcow2"
}

