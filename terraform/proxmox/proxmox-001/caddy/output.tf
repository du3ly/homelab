output "vm_id" {
  description = "VM/CT ID of the Caddy container"
  value       = module.instance.vm_id
}

output "hostname" {
  description = "Container hostname"
  value       = module.instance.hostname
}
