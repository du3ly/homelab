resource "proxmox_virtual_environment_vm" "this" {
  vm_id       = var.vm_id
  name        = var.vm_name
  node_name   = var.target_node
  description = var.vm_desc

  # Clone from template
  clone {
    vm_id = var.clone_vm_id
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
    interface    = "scsi1"
    size         = var.disk_size_gb
    backup       = var.disk_backup
  }

  # Enable QEMU Guest Agent
  agent {
    enabled = true
  }
}
