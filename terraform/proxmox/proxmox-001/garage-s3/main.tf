module "garage_s3" {
  source = "../../../modules/proxmox-lxc"

  hostname            = "garage-s3"
  description         = "Garage S3-compatible object storage"
  template            = "debian-12-standard"
  target_node         = "proxmox-001"
  memory              = 512
  swap                = 512
  cores               = 2
  disk_size           = "16G"
  disk_storage        = "local-lvm"
  ip_address          = "192.168.1.100/24"
  onboot              = true
  unprivileged        = false
  cloud_init_script   = file("${path.module}/cloud-init.yaml")
  garage_admin_secret = var.garage_admin_secret
  garage_api_secret   = var.garage_api_secret
}

output "container_id" {
  value = module.garage_s3.container_id
}

output "hostname" {
  value = module.garage_s3.hostname
}

variable "garage_admin_secret" {
  type      = string
  sensitive = true
}

variable "garage_api_secret" {
  type      = string
  sensitive = true
}
