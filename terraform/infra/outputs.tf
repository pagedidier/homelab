output "inventory" {
  value = {
    "k3s_prod": [
      module.k3s-node1.vm,
      module.k3s-node2.vm,
      module.k3s-node3.vm
    ]
    "swarm": [
      module.swarm-node1.vm,
      module.swarm-node2.vm,
      module.swarm-node3.vm
    ],
    "swarm02": [
      module.swarm-node11.vm
    ]
    "databases" : [
      module.database-prod.container
    ]
    "proxmox": [
      module.proxmox11.proxmox,
      module.proxmox12.proxmox,
      module.proxmox13.proxmox,
      module.proxmox21.proxmox,
    ]
    "proxmox_backup_server": [
      module.pbs01.server
    ]
    "haproxy_servers": [
      module.proxy01.server
    ]
  }
}
