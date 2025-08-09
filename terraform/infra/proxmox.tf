data "proxmox_virtual_environment_node" "node11" {
  node_name ="proxmox11"
}

data "proxmox_virtual_environment_node" "node12" {
  node_name ="proxmox12"
}

data "proxmox_virtual_environment_node" "node13" {
  node_name = "proxmox13"
}

data "proxmox_virtual_environment_node" "node21" {
  provider = proxmox.pvc02
  node_name = "proxmox21"
}

#data "proxmox_virtual_environment_datastores" "datastores" {
#  node_name = data.proxmox_virtual_environment_node.node2.node_name
#}
#resource "proxmox_virtual_environment_download_file" "noble" {
#  content_type        = "vztmpl"
#  datastore_id        = "storage"
#  node_name           = data.proxmox_virtual_environment_node.node2.node_name
#  url                 = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64-root.tar.xz"
#  upload_timeout      = 4444
#  overwrite_unmanaged = true
#}



