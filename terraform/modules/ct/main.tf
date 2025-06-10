terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.61.1"
    }
  }
}

data "proxmox_virtual_environment_datastores" "datastores" {
  node_name = var.node_name
}

resource "proxmox_virtual_environment_container" "ct" {
  node_name = var.node_name

  initialization {
    hostname = var.name
    user_account {
      password = var.init_user_password
      keys = var.init_ssh_keys
    }

    ip_config {
      ipv4 {
        address = var.ip
        gateway = var.gateway
      }
    }
  }

  disk {
    datastore_id = element(data.proxmox_virtual_environment_datastores.datastores.datastore_ids, index(data.proxmox_virtual_environment_datastores.datastores.datastore_ids, var.volume_name))
    size         = var.disk_size
  }

  cpu {
    cores = var.cpu_cores
  }

  memory {
    dedicated = var.memory
    swap = var.swap
  }

  operating_system {
    template_file_id = var.file_template_id
    type             = var.operating_system_type
  }

  network_interface {
    name = var.network_interface_name
    bridge = var.network_interface_bridge
  }

  unprivileged = true
}


/*resource "vault_kv_secret_v2" "ct_ansible_secrets" {
  mount                      = var.secret_mount
  name                       = var.name
  delete_all_versions        = true
  data_json                  = jsonencode(
    {
      ansible_host       = var.name,
      ansible_user = "root",
    }
  )
  disable_read = true
  custom_metadata {
    max_versions = 5
    data = {
      terraform_managed = true
    }
  }
}*/