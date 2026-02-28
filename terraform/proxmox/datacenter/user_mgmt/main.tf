locals {
  config = yamldecode(file("config/users.yaml"))
}

module "roles" {
  source   = "../modules/proxmox_role"
  for_each = local.config.roles

  role_name  = each.value.name
  privileges = each.value.privileges
}

module "users" {
  source   = "../modules/proxmox_user"
  for_each = local.config.users

  username    = each.value.username
  description = try(each.value.description, "")
  token_id    = try(each.value.token_id, "terraform1")
  acl_path    = try(each.value.acl_path, "/")
  role_name   = module.roles[each.value.role].role_name
}
