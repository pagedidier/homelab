output "inventory" {
  value = {
    "k3s_prod" : [
      module.k3s-node1.vm,
      module.k3s-node2.vm,
      module.k3s-node3.vm
    ]
    "swarm_prod" : [
      module.swarm-node1.vm,
      module.swarm-node2.vm,
      module.swarm-node3.vm
    ],
    "swarm_dev" : [
      module.swarm-node1-dev.vm,
      module.swarm-node2-dev.vm,
      module.swarm-node3-dev.vm
    ],
    # "swarm_dev" : [
    #   {
    #     "managers" : [
    #       module.swarm-node1-dev.vm,
    #     ]
    #   },
    #   {
    #     "workers" : [
    #       module.swarm-node2-dev.vm,
    #       module.swarm-node3-dev.vm
    #     ]
    #   }
    # ]
    # "swarm02": [
    #   module.swarm-node11.vm
    #],
    "nlb" : [
      module.nlb01.container,
      module.nlb02.container
    ]
    "databases" : [
      module.database-prod.container
    ]
    "proxmox" : [
      module.proxmox11.proxmox,
      module.proxmox12.proxmox,
      module.proxmox13.proxmox,
      # module.proxmox21.proxmox,
    ]
    "proxmox_backup_server" : [
      module.pbs01.server
    ]
    "haproxy_servers" : [
      module.proxy01.server
    ],
    "wireguards" : [
      #module.proxy01.server
      module.vpn.container
    ]
    "glrunners" : [
      module.glrunner.vm
    ]
    "vps" : [
      module.vps01.server
    ]
  }
}
