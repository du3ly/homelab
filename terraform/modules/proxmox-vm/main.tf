resource "proxmox_virtual_environment_vm" "this" {
  vm_id       = var.vm_id
  name        = var.vm_name
  node_name   = var.target_node
  description = var.vm_desc

  # Optional clone block
  dynamic "clone" {
    for_each = var.vm_clone_template != null && var.vm_clone_template != 0 ? [1] : []
    content {
      vm_id = var.vm_clone_template
      full  = var.full_clone
    }
  }

  # Resources
  memory {
    dedicated = var.memory
  }

  cpu {
    cores = var.cores
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = var.disk_storage
    interface    = "scsi0"
    size         = var.disk_size_gb
    backup       = var.disk_backup
  }

  # Enable QEMU Guest Agent
  agent {
    enabled = true
  }
}
