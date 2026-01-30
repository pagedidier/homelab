resource "proxmox_virtual_environment_hagroup" "main" {
  group   = "main"
  comment = "This is a comment."

  nodes = {
    (module.proxmox11.proxmox_data.node_name) = null
    (module.proxmox12.proxmox_data.node_name) = null
    (module.proxmox13.proxmox_data.node_name) = null
  }

  restricted  = true
  no_failback = false
}