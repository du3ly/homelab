output "id" {
  description = "The resource ID returned by the provider"
  value       = proxmox_virtual_environment_vm.this.id
}

output "vmid" {
  description = "The VMID assigned to the virtual machine by Proxmox"
  value       = proxmox_virtual_environment_vm.this.vm_id
}

output "name" {
  description = "The name of the virtual machine"
  value       = proxmox_virtual_environment_vm.this.name
}

output "node" {
  description = "The Proxmox node on which the VM was created"
  value       = var.target_node
}
