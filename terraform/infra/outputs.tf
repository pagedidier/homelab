output "inventory" {
  value = {
    "k3s_prod" : [
      {
        "init_prod" : [
          module.k3s-server01-prod.vm,
        ]
      },
      {
        "join_prod" : [
          module.k3s-server02-prod.vm,
          module.k3s-server03-prod.vm
        ]
      }
    ],
    "swarm_prod" : [
      {
        "managers" : [
          module.swarm-node1.vm,
        ]
      },
      {
        "workers" : [
          module.swarm-node2.vm,
          module.swarm-node3.vm
        ]
      }
    ]
    "k3s_dev" : [
      {
        "init_dev" : [
          module.k3s-node1-dev.vm,
        ]
      },
      {
        "join_dev" : [
          module.k3s-node2-dev.vm,
          module.k3s-node3-dev.vm
        ]
      }
    ]
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
    ]
    "proxmox_backup_server" : [
      module.pbs01.server
    ]
    "wireguards" : [
      module.vpn.container
    ]
    "glrunners" : [
      module.glrunner.vm
    ]
    "vps" : [
      module.vps01.server,
      module.vps01-ovh.server
    ]
  }
}
