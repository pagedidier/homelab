data "proxmox_virtual_environment_node" "node11" {
  node_name ="proxmox11"
}

data "proxmox_virtual_environment_node" "node12" {
  node_name ="proxmox12"
}

data "proxmox_virtual_environment_node" "node13" {
  node_name ="proxmox13"
}

#module "k3s-node" {
#  count     = 3
#  source = "./modules/vm"
#  name   = "k3s-node-${count.index+1}.${var.domain_name}"
#  node_name = data.proxmox_virtual_environment_node.node.node_name
#  init_ssh_keys = var.init_ssh_keys
#  init_user_password = var.init_user_password
#  init_user_username = var.init_user_username
#}


# module "srv3" {
#   count     = 1
#   source = "./modules/vm"
#   name   = "srv3.${var.domain_name}"
#   node_name = data.proxmox_virtual_environment_node.node1.node_name
#   init_ssh_keys = var.init_ssh_keys
#   init_user_password = var.init_user_password
#   init_user_username = var.init_user_username
# }

# module "database01_staging" {
#   source = "./modules/ct"
#
#   init_ssh_keys = var.init_ssh_keys
#   init_user_password = var.init_user_password
#
#   name = "database01.staging.${var.domain_name}"
#   node_name = data.proxmox_virtual_environment_node.node2.node_name
#
#   cpu_cores = "2"
#   disk_size = "20"
#   memory = "2048"
#   swap = "512"
#
#   file_template_id = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
#   operating_system_type = "ubuntu"
#
#   network_interface_bridge = "vmbr0"
#   network_interface_name = "eth0"
#   #secret_mount             = vault_mount.infrastructure.path
# }

# /*module "prometheus-prod" {
#   source = "./modules/ct"
#
#   init_ssh_keys = var.init_ssh_keys
#   init_user_password = var.init_user_password
#
#   name = "prometheus01.prod.${var.domain_name}"
#   node_name = data.proxmox_virtual_environment_node.node0.node_name
#
#   cpu_cores = "2"
#   disk_size = "20"
#   memory = "2048"
#   swap = "512"
#
#   file_template_id = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
#   operating_system_type = "ubuntu"
#
#   network_interface_bridge = "vmbr0"
#   network_interface_name = "eth0"
#   #secret_mount             = vault_mount.infrastructure.path
# }
#
# module "grafana-prod" {
#   source = "./modules/ct"
#
#   init_ssh_keys = var.init_ssh_keys
#   init_user_password = var.init_user_password
#
#   name = "grafana01.prod.${var.domain_name}"
#   node_name = data.proxmox_virtual_environment_node.node0.node_name
#
#   cpu_cores = "2"
#   disk_size = "20"
#   memory = "2048"
#   swap = "512"
#
#   file_template_id = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
#   operating_system_type = "ubuntu"
#
#   network_interface_bridge = "vmbr0"
#   network_interface_name = "eth0"
#   #secret_mount             = vault_mount.infrastructure.path
# }*/



#module "database01_dev" {
#  source = "./modules/ct"
#
#  init_ssh_keys = var.init_ssh_keys
#  init_user_password = var.init_user_password
#
#  name = "database01.dev.${var.domain_name}"
#  node_name = data.proxmox_virtual_environment_node.node2.node_name
#
#  cpu_cores = "2"
#  disk_size = "20"
#  memory = "2048"
#  swap = "512"
#
#  file_template_id = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
#  operating_system_type = "ubuntu"
#
#  network_interface_bridge = "vmbr0"
#  network_interface_name = "eth0"
#  secret_mount             = vault_mount.infrastructure.path
#}

#module "database01" {
#  source = "./modules/ct"
#  name   = "database01.${var.domain_name}"
#  node_name = data.proxmox_virtual_environment_node.node2.node_name
#  init_ssh_keys = var.init_ssh_keys
#  init_user_password = var.init_user_password
#  init_user_username = var.init_user_username
#}
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

module "k3s-node1" {
  source = "./modules/vm"
  name   = "k3s-01.prod"
  node_name = data.proxmox_virtual_environment_node.node11.node_name
  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 8192
  ip="192.168.1.51/16"
  gateway = "192.168.0.254"
}

module "k3s-node2" {
  source = "./modules/vm"
  name   = "k3s-02.prod"
  node_name = data.proxmox_virtual_environment_node.node12.node_name
  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 8192
  ip="192.168.1.52/16"
  gateway = "192.168.0.254"
}

module "k3s-node3" {
  source = "./modules/vm"
  name   = "k3s-03.prod"
  node_name = data.proxmox_virtual_environment_node.node13.node_name
  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 8192
  ip="192.168.1.53/16"
  gateway = "192.168.0.254"
}

module "swarm-node1" {
  source = "./modules/vm"
  name   = "swarm-01.prod"
  node_name = data.proxmox_virtual_environment_node.node12.node_name
  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.0.111/16"
  gateway = "192.168.0.254"
  agent_enable = true
}

module "swarm-node2" {
  source = "./modules/vm"
  name   = "swarm-02.prod"
  node_name = data.proxmox_virtual_environment_node.node13.node_name
  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.0.112/16"
  gateway = "192.168.0.254"
  agent_enable = true

}

module "swarm-node3" {
  source = "./modules/vm"
  name   = "swarm-03.prod"
  node_name = data.proxmox_virtual_environment_node.node11.node_name
  init_ssh_keys = var.init_ssh_keys
  init_user_password = var.init_user_password
  init_user_username = var.init_user_username
  ram_in_bytes = 4096
  ip="192.168.0.113/16"
  gateway = "192.168.0.254"
  agent_enable = true
}