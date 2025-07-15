# module "k3s_dev" {
#   source = "./modules/k3s_cluster"
#   environment = "dev"
#   gateway = "192.168.0.254"
#   init_ssh_keys = var.init_ssh_keys
#   init_user_password = var.init_user_password
#   init_user_username = var.init_user_username
#   cidr = "192.168.1.61/24"
#   nb_node = 3
#   node_array = [
#     data.proxmox_virtual_environment_node.node11.node_name,
#     data.proxmox_virtual_environment_node.node12.node_name,
#     data.proxmox_virtual_environment_node.node13.node_name
#   ]
# }

