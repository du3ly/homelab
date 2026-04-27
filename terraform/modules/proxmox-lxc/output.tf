output "vm_id" {
  description = "VM/CT ID of the container"
  value       = proxmox_virtual_environment_container.lxc.vm_id
}

output "hostname" {
  description = "Container hostname"
  value       = proxmox_virtual_environment_container.lxc.initialization[0].hostname
}

output "node_name" {
  description = "Proxmox node name"
  value       = proxmox_virtual_environment_container.lxc.node_name
}

output "template_file_id" {
  description = "Template file ID used by the container"
  value       = proxmox_virtual_environment_download_file.template.id
}
