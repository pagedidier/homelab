locals {
  inventory_templated = templatefile("${path.module}/templates/inventory.yaml.tftpl", {
    nodes = [
      module.k3s-server01-prod.vm,
      module.k3s-server02-prod.vm,
      module.k3s-server03-prod.vm,
      module.nlb01_vm.vm,
      module.database-prod.container,
      module.proxmox11.proxmox,
      module.proxmox12.proxmox,
      module.proxmox13.proxmox,
      module.pbs01.server,
      module.vpn.container,
      module.glrunner.vm,
      module.vps01.server,
      module.nas01.server,
      module.truenas.server,
      module.ai-worker.vm
    ]
  })
}
