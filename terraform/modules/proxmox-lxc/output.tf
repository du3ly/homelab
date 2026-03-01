output "vmid" {
  description = "The container ID assigned by Proxmox"
  value       = proxmox_lxc.this.vmid
}

output "container_name" {
  description = "The name of the container"
  value       = proxmox_lxc.this.name
}

output "container_ip" {
  description = "The IP address of the container"
  value       = proxmox_lxc.this.network.0.ip
}

output "node" {
  description = "The Proxmox node on which the container was created"
  value       = var.target_node
}
