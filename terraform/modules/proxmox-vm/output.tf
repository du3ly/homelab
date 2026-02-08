output "vm_name" {
  description = "The name of the virtual machine"
  value       = proxmox_virtual_environment_vm.this.name
}

output "vm_id" {
  description = "The VMID assigned to the virtual machine by Proxmox"
  value       = proxmox_virtual_environment_vm.this.vm_id
}

output "memory" {
  description = "The amount of memory allocated to the virtual machine"
  value       = proxmox_virtual_environment_vm.this.memory[0].dedicated
}

output "cpu_cores" {
  description = "The number of CPU cores allocated to the virtual machine"
  value       = proxmox_virtual_environment_vm.this.cpu[0].cores
}
