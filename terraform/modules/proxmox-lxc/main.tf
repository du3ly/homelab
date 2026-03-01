resource "proxmox_lxc" "this" {
  name        = var.vm_name
  target_node = var.target_node
  ostemplate  = var.ostemplate
  description = var.vm_desc

  # Resources
  cores  = var.cores
  memory = var.memory
  swap   = var.swap

  # Root filesystem
  rootfs {
    size = var.rootfs_size
    pool = var.rootfs_storage
  }

  # Data mount for PostgreSQL data
  mount {
    key    = "mp0"
    slot   = 0
    size   = var.data_mount_size
    pool   = var.data_mount_storage
    path   = var.data_mount_path
    backup = false
  }

  # Network configuration
  network {
    id     = 0
    name   = "eth0"
    bridge = var.network_bridge
    ip     = var.network_ip
    gw     = var.network_gateway
  }

  # OS type
  os_type {
    distribution = "debian"
    version      = "12"
  }

  # Features
  features {
    nesting = false
  }
}
