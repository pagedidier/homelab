terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.85.1"
    }
  }
}

resource "proxmox_virtual_environment_container" "ct" {
  node_name = var.node_name

  # newer linux distributions require unprivileged user namespaces
  features {
    nesting = true
  }

  initialization {
    hostname = var.name
    user_account {
      password = var.init_user_password
      keys = var.init_ssh_keys
    }

    ip_config {
      ipv4 {
        address = var.use_dhcp ? "dhcp" : var.ip
        gateway = var.use_dhcp ? null : var.gateway
      }
    }
  }

  disk {
    datastore_id = var.volume_name
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

data "external" "container_ip" {
  count = var.use_dhcp ? 1 : 0
  program = [
    "ssh", "root@${var.node_ip}", "pct", "exec", proxmox_virtual_environment_container.ct.id, "--", "hostname", "-I",
    "|", "awk",
    "'{print \"{\\\"ip\\\":\\\"\"$1\"\\\"}\"}'",
  ]
}

output "container" {
  value = {
    "id" : proxmox_virtual_environment_container.ct.id
    "ip": var.use_dhcp ? data.external.container_ip[0].result.ip : split("/",proxmox_virtual_environment_container.ct.initialization[0].ip_config[0].ipv4[0].address)[0],
    "username": "root"
    "name": var.name
    "hostname" = "${var.name}${var.domain_name != "" ? ".${var.domain_name}" : ""}"
  }
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