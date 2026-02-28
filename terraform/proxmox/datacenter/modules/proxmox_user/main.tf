locals {
  user_id = "${var.username}@pve"
}

resource "proxmox_virtual_environment_user" "this" {
  user_id = local.user_id
  comment = var.description

  acl {
    path      = var.acl_path
    role_id   = var.role_name
    propagate = true
  }
}

resource "proxmox_user_token" "this" {
  user_id    = proxmox_virtual_environment_user.this.user_id
  token_name = var.token_id
}
