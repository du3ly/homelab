resource "proxmox_vm_qemu" "this" {
  name        = var.vm_name
  target_node = var.target_node
  clone       = var.vm_clone_template
  description = var.vm_desc
  skip_ipv6   = true

  # Resources
  memory = var.memory

  cpu {
    cores = var.cores
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  disks {
    scsi {
      scsi0 {
        disk {
          backup  = false
          size    = var.disk_size
          storage = var.disk_storage
        }
      }
    }
  }

  # Enable QEMU Guest Agent
  agent = 1
}
