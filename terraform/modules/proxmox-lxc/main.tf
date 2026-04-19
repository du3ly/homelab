# Local file for cloud-init config
resource "local_file" "cloud_init" {
  count    = var.cloud_init_script != "" ? 1 : 0
  content  = file(var.cloud_init_script)
  filename = "${path.module}/.cloud-init-${var.hostname}.yaml"
}

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

  # Enable nesting for Docker support
  unprivileged = var.unprivileged
  nesting      = var.nesting

  # Cloud-init configuration - references the local file path
  # The provider will upload this to Proxmox storage
  dynamic "cicustom" {
    for_each = var.cloud_init_script != "" ? [1] : []
    content {
      user = local_file.cloud_init[0].filename
    }
  }

  depends_on = [local_file.cloud_init]
}
