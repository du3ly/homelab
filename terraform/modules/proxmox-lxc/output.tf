output "container_id" {
  description = "The ID of the created container"
  value       = proxmox_lxc.this.id
}

output "hostname" {
  description = "The hostname of the container"
  value       = proxmox_lxc.this.hostname
}
