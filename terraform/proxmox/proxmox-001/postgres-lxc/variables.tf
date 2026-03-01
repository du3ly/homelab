variable "pm_api_url" {
  type        = string
  description = "Proxmox API URL"
  default     = "192.168.1.20"
}

variable "target_node" {
  type        = string
  description = "Proxmox node name"
  default     = "proxmox-001"
}
