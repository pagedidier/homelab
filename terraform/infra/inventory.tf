resource "local_file" "inventory" {
  filename = "${path.module}/../../ansible/inventory/inventory.yaml"
  content = templatefile("${path.module}/templates/inventory.yaml.tftpl", {
    nodes = [
      module.k3s-server01-prod.vm,
      module.k3s-server02-prod.vm,
      module.k3s-server03-prod.vm,
      module.swarm-node1.vm,
      module.swarm-node2.vm,
      module.swarm-node3.vm,
      module.k3s-node1-dev.vm,
      module.k3s-node2-dev.vm,
      module.k3s-node3-dev.vm,
      module.nlb01_vm.vm,
      module.database-prod.container,
      module.proxmox11.proxmox,
      module.proxmox12.proxmox,
      module.proxmox13.proxmox,
      module.pbs01.server,
      module.vpn.container,
      module.glrunner.vm,
      module.vps01.server
    ]
  })
}
