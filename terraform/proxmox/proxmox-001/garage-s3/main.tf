module "garage_s3_lxc" {
  source = "../../../modules/proxmox-lxc"

  container_name = "garage-s3"
  target_node    = "proxmox-001"
  os_template    = "local:vztmpl/debian-12-standard.tar.gz"

  cores          = 2
  memory         = 2048
  rootfs_size    = "16G"
  rootfs_storage = "vmstore"

  nfs_server      = "192.168.1.21"
  nfs_path        = "/volume1/homelab/garage-data"
  nfs_mount_point = "/mnt/garage-data"
  nfs_storage     = null
}
