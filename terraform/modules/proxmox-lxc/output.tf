output "container_id" {
  description = "The resource ID of the LXC container"
  value       = proxmox_virtual_environment_container.this.id
}

output "container_name" {
  description = "The name of the LXC container"
  value       = proxmox_virtual_environment_container.this.container_name
}

output "container_node" {
  description = "The Proxmox node where the container is running"
  value       = proxmox_virtual_environment_container.this.node_name
}
