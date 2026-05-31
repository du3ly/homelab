output "user_id" {
  value = proxmox_virtual_environment_user.this.user_id
}

output "token_value" {
  value     = proxmox_user_token.this.value
  sensitive = true
}
