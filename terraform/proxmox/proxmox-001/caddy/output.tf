output "vm_id" {
  description = "VM/CT ID of the Caddy container"
  value       = module.instance.vm_id
}

output "hostname" {
  description = "Container hostname"
  value       = module.instance.hostname
}

output "caddyfile" {
  description = "Current deployed Caddyfile configuration"
  value       = file("${path.module}/Caddyfile")
  depends_on  = [null_resource.caddy_config]
}
