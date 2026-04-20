variable "hostname" {
  type        = string
  description = "The hostname of the LXC container"
}

variable "description" {
  type        = string
  description = "Description of the container"
  default     = ""
}

variable "template_vm_id" {
  type        = number
  description = "The VM ID of the template to clone"
}

variable "target_node" {
  type        = string
  description = "The Proxmox node to place the container on"
  default     = "proxmox-001"
}

variable "memory" {
  type        = number
  description = "Amount of memory in MB"
  default     = 512
}

variable "swap" {
  type        = number
  description = "Amount of swap in MB"
  default     = 512
}

variable "cores" {
  type        = number
  description = "Number of CPU cores"
  default     = 1
}

variable "disk_size" {
  type        = number
  description = "Size of the root disk in GB"
  default     = 8
}

variable "disk_storage" {
  type        = string
  description = "Storage pool for the root disk"
  default     = "local-lvm"
}

variable "ip_address" {
  type        = string
  description = "IPv4 address in CIDR notation (e.g., '192.168.1.100/24')"
}

variable "onboot" {
  type        = bool
  description = "Start container on boot"
  default     = true
}

variable "unprivileged" {
  type        = bool
  description = "Create an unprivileged container"
  default     = false
}

variable "nesting" {
  type        = bool
  description = "Enable nesting for Docker/container support"
  default     = false
}

variable "pm_api_url" {
  type    = string
  default = "192.168.1.20"
}

variable "cloud_init_script" {
  type        = string
  description = "Cloud-init script to run on first boot"
  default     = ""
}
