resource "proxmox_lxc" "this" {
  target_node = var.target_node
  hostname    = var.hostname
  description = var.description

  # Template to clone from
  template = var.template

  # Resources
  memory = var.memory
  swap   = var.swap
  cores  = var.cores

  # Network configuration
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = var.ip_address
    ip6    = "auto"
  }

  # Root disk
  rootfs {
    size     = var.disk_size
    storage  = var.disk_storage
  }

  # Features
  features {
    mount = "nfs;cifs"
  }

  # Start on boot
  onboot = var.onboot

  # Enable nesting if needed
  unprivileged = var.unprivileged

  # Cloud-init configuration
  dynamic "cicustom" {
    for_each = var.cloud_init_script != "" ? [1] : []
    content {
      user = var.cloud_init_script
    }
  }

}
