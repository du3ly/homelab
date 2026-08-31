resource "proxmox_virtual_environment_vm" "this" {
  name        = var.vm_name
  description = var.vm_desc
  node_name   = var.target_node
  vm_id       = var.vm_id

  # UEFI firmware with q35 chipset per Talos guide
  bios    = "ovmf"
  machine = "q35"

  # Boot order
  boot_order = var.boot_order

  agent {
    enabled = false
  }

  cpu {
    cores = var.cores
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory
    floating  = 0
  }

  # VirtIO SCSI disk (NOT VirtIO SCSI Single)
  disk {
    datastore_id = var.disk_storage
    interface    = "scsi0"
    size         = var.disk_size
    file_format  = var.disk_format
    cache        = var.disk_cache
    discard      = var.disk_discard ? "on" : "ignore"
    ssd          = var.disk_ssd
  }

  # CDROM with Talos ISO
  cdrom {
    file_id   = "${var.iso_storage}:iso/${var.iso_file}"
    interface = "ide2"
  }

  # EFI disk required for OVMF
  efi_disk {
    datastore_id      = var.disk_storage
    file_format       = "raw"
    type              = "4m"
    pre_enrolled_keys = false
  }

  network_device {
    bridge = var.network_bridge
    model  = "virtio"
  }
}
