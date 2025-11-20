data "local_file" "ssh_public_key" {
  filename = var.pvc["pvc01"].proxmox_ssh_key_path
}


resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "isos-templates"
  node_name    = module.proxmox12.proxmox_data.node_name

  source_raw {
    data = <<-EOF
    #cloud-config
    timezone: Europe/Zurich
    users:
      - default
      - name: ${var.init_user_username}
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_public_key.content)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    package_update: true
    packages:
      - qemu-guest-agent
    runcmd:
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "user-data-cloud-config.yaml"
  }
}