output "user_tokens" {
  value     = { for k, v in module.users : k => v.token_value }
  sensitive = true
}
