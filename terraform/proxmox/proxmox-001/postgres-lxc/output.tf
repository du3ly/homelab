output "postgres_vmid" {
  description = "PostgreSQL container ID"
  value       = module.postgres_lxc.vmid
}

output "postgres_container_name" {
  description = "PostgreSQL container name"
  value       = module.postgres_lxc.container_name
}

output "postgres_container_ip" {
  description = "PostgreSQL container IP address"
  value       = module.postgres_lxc.container_ip
}

output "postgres_node" {
  description = "Proxmox node where PostgreSQL container is running"
  value       = module.postgres_lxc.node
}
