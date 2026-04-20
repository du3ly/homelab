output "container_id" {
  description = "The ID of the created container"
  value       = proxmox_virtual_environment_container.this.id
}

output "hostname" {
  description = "The hostname of the container"
  value       = proxmox_virtual_environment_container.this.vm_id
}
