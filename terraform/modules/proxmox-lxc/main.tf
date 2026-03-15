resource "proxmox_virtual_environment_container" "this" {
  name          = var.container_name
  description   = "Garage S3 container"
  node_name     = var.target_node
  start_on_boot = var.start_on_boot

  cpu {
    cores = var.cores
  }

  memory {
    dedicated = var.memory
  }

  disk {
    datastore_id = var.rootfs_storage
    size         = 16
  }

  network_interface {
    name   = "eth0"
    bridge = var.network_bridge
  }

  dynamic "mount_point" {
    for_each = var.nfs_server != null ? [1] : []
    content {
      volume = var.nfs_storage != null ? var.nfs_storage : "${var.nfs_server}:${var.nfs_path}"
      size   = null
      path   = var.nfs_mount_point
    }
  }

  features {
    mount = ["nfs"]
  }

  initialization {
    hostname = var.container_name
  }

  operating_system {
    template_file_id = var.os_template
  }

  lifecycle {
    ignore_changes = [
      network_interface[0].mac_address,
    ]
  }
}
