resource "proxmox_virtual_environment_download_file" "template" {
  content_type = "vztmpl"
  datastore_id = var.template_datastore
  node_name    = var.node_name
  url          = var.template_url
}

resource "proxmox_virtual_environment_container" "lxc" {
  node_name = var.node_name
  vm_id     = var.vm_id

  initialization {
    hostname = var.hostname

    user_account {
      keys = var.ssh_key
    }

    dns {
      servers = var.dns_servers
    }

    ip_config {
      ipv4 {
        address = var.ipv4_address
        gateway = var.ipv4_gateway
      }
    }
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.template.id
    type             = "debian"
  }

  cpu {
    cores = var.cpu_cores
  }

  memory {
    dedicated = var.memory_mb
  }

  disk {
    datastore_id = var.disk_datastore
    size         = var.disk_size
  }

  network_interface {
    name   = "eth0"
    bridge = var.network_bridge
  }

  started = var.started
}
