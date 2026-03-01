variable "cores" {
  type        = number
  description = "Number of CPU cores"
  default     = 1
}

variable "memory" {
  type        = number
  description = "Memory in MB"
  default     = 512
}

variable "swap" {
  type        = number
  description = "Swap in MB"
  default     = 256
}

variable "rootfs_size" {
  type        = string
  description = "Root filesystem size"
  default     = "2G"
}

variable "rootfs_storage" {
  type        = string
  description = "Storage pool for root filesystem"
  default     = "local"
}

variable "data_mount_size" {
  type        = string
  description = "Data mount size"
  default     = "5G"
}

variable "data_mount_storage" {
  type        = string
  description = "Storage pool for data mount"
  default     = "vmstore"
}

variable "data_mount_path" {
  type        = string
  description = "Mount path for data within container"
  default     = "/var/lib/postgresql/data"
}

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

variable "vm_name" {
  type        = string
  description = "Container name"
  default     = ""
}

variable "vm_desc" {
  type        = string
  description = "Container description"
  default     = ""
}

variable "ostemplate" {
  type        = string
  description = "LXC OS template"
  default     = "vzdump:local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
}

variable "storage_pool" {
  type        = string
  description = "Default storage pool"
  default     = "local"
}

variable "network_bridge" {
  type        = string
  description = "Network bridge"
  default     = "vmbr0"
}

variable "network_ip" {
  type        = string
  description = "DHCP or static IP (dhcp for auto)"
  default     = "dhcp"
}

variable "network_gateway" {
  type        = string
  description = "Network gateway (required for static IP)"
  default     = ""
}
