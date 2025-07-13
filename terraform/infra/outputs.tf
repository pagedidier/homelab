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
    ]
    "prometheus" : [
      module.prometheus-prod.container
    ]
    "databases" : [
      module.database-prod.container
    ]
    "k3s_dev": module.k3s_dev.cluster
    "proxmox": [
      module.proxmox01.server,
      module.proxmox02.server,
      module.proxmox03.server,
    ]
    "proxmox-backup-server": [
      module.pbs01.server
    ]
    "haproxy-servers": [
      module.proxy01.server
    ]
  }
}
