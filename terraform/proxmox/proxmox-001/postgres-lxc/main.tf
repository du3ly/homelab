module "postgres_lxc" {
  source = "../../../modules/proxmox-lxc"

  # Container identification
  vm_name = "postgres-001"
  vm_desc = "PostgreSQL container with 5GB vmstore for data"

  # Proxmox connection
  pm_api_url  = var.pm_api_url
  target_node = var.target_node

  # LXC template
  ostemplate = "vzdump:local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"

  # Minimal resources for PostgreSQL
  cores  = 1
  memory = 512
  swap   = 256

  # Root filesystem (small, just for OS)
  rootfs_size     = "2G"
  rootfs_storage  = "local"

  # Data mount for PostgreSQL data (5GB on vmstore)
  data_mount_size    = "5G"
  data_mount_storage = "vmstore"
  data_mount_path    = "/var/lib/postgresql/data"

  # Network
  network_bridge = "vmbr0"
  network_ip     = "dhcp"
}
