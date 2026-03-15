output "container_id" {
  description = "The LXC container ID"
  value       = module.garage_s3_lxc.container_id
}

output "container_name" {
  description = "The LXC container name"
  value       = module.garage_s3_lxc.container_name
}
