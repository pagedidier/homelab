data "proxmox_virtual_environment_node" "node" {
  node_name ="proxmox01"
}

#module "k8s-node" {
#  count     = 3
#  source = "./modules/vm"
#  name   = "k3s-node-${count.index+1}.${var.domain_name}"
#  node_name = data.proxmox_virtual_environment_node.node.node_name
#  init_ssh_keys = var.init_ssh_keys
#  init_user_password = var.init_user_password
#  init_user_username = var.init_user_username
#}
