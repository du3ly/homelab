output "vm_id" {
  description = "The ID of the created virtual machine"
  value       = module.instance.vm_id
}

output "vm_name" {
  description = "The name of the created virtual machine"
  value       = module.instance.vm_name
}

output "vm_ipv4_address" {
  description = "The IPv4 address of the virtual machine"
  value       = module.instance.ipv4
}

output "vm_memory" {
  description = "The amount of memory allocated to the virtual machine"
  value       = module.instance.memory
}

output "vm_cpu_cores" {
  description = "The number of CPU cores allocated to the virtual machine"
  value       = module.instance.cpu_cores
}