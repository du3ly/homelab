# Local file for cloud-init config
resource "local_file" "cloud_init" {
  count    = var.cloud_init_script != "" ? 1 : 0
  content  = file(var.cloud_init_script)
  filename = "${path.module}/.cloud-init-${var.hostname}.yaml"
}

resource "proxmox_virtual_environment_container" "this" {
  node_name    = var.target_node
  vm_id        = null
  description  = var.description
  unprivileged = var.unprivileged
  tags         = ["gha-runner"]

  clone {
    vm_id = var.template_vm_id
  }

  cpu {
    cores = var.cores
  }

  memory {
    dedicated = var.memory
    swap      = var.swap
  }

  disk {
    datastore_id = var.disk_storage
    size         = var.disk_size
  }

  network_interface {
    name = "eth0"
    bridge = "vmbr0"
  }

  initialization {
    hostname = var.hostname

    ip_config {
      ipv4 {
        address = var.ip_address
      }
    }
  }

  startup {
    order = var.onboot ? 1 : 0
  }

  lifecycle {
    ignore_changes = [initialization[0].user_account]
  }
}
