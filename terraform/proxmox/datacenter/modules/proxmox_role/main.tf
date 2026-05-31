resource "proxmox_virtual_environment_role" "this" {
  role_id    = var.role_name
  privileges = var.privileges
}
