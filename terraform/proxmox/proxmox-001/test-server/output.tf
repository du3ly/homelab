output "id" {
  description = "The resource ID returned by the provider"
  value       = module.instance.id
}

output "vmid" {
  description = "The VMID assigned to the virtual machine by Proxmox"
  value       = module.instance.vmid
}

output "name" {
  description = "The name of the virtual machine"
  value       = module.instance.name
}

output "node" {
  description = "The Proxmox node on which the VM was created"
  value       = module.instance.node
}
