data "proxmox_virtual_environment_vms" "template" {
  count = var.vm_clone_template != "" ? 1 : 0
  filter {
    name   = "name"
    values = [var.vm_clone_template]
  }
}

resource "proxmox_virtual_environment_vm" "this" {
  name        = var.vm_name
  description = var.vm_desc
  node_name   = var.target_node

  boot_order = ["scsi0"]

  agent {
    enabled = true
  }

  cpu {
    cores = var.cores
  }

  memory {
    dedicated = var.memory
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = var.disk_storage
    interface    = "scsi0"
    size         = parseint(replace(var.disk_size, "G", ""), 10)
    backup       = var.disk_backup
  }

  dynamic "clone" {
    for_each = var.vm_clone_template != "" ? [1] : []
    content {
      vm_id = data.proxmox_virtual_environment_vms.template[0].vms[0].vm_id
      full  = var.full_clone
    }
  }
}
