variable "vm_id" {
  type        = number
  description = "The VM ID to assign. If null, Proxmox auto-assigns the next available ID."
  default     = null
}

variable "vm_name" {
  type        = string
  description = "Name of the virtual machine"
}

variable "vm_desc" {
  type        = string
  description = "Description / notes for the VM in Proxmox"
  default     = ""
}

variable "target_node" {
  type        = string
  description = "The Proxmox node on which to create the VM"
  default     = "proxmox-001"
}

variable "cores" {
  type        = number
  description = "Number of CPU cores"
  default     = 2
}

variable "cpu_type" {
  type        = string
  description = "CPU type (host recommended for best performance)"
  default     = "host"
}

variable "memory" {
  type        = number
  description = "Dedicated memory in MB"
  default     = 2048
}

variable "disk_size" {
  type        = number
  description = "Disk size in GB"
  default     = 20
}

variable "disk_storage" {
  type        = string
  description = "Storage pool for the VM disk and EFI disk"
  default     = "vmstore"
}

variable "disk_format" {
  type        = string
  description = "Disk format: raw (performance) or qcow2 (snapshots)"
  default     = "raw"
}

variable "disk_cache" {
  type        = string
  description = "Disk cache mode"
  default     = "writethrough"
}

variable "disk_discard" {
  type        = bool
  description = "Enable discard/TRIM support"
  default     = true
}

variable "disk_ssd" {
  type        = bool
  description = "Enable SSD emulation"
  default     = true
}

variable "iso_storage" {
  type        = string
  description = "Storage pool where the ISO is stored"
  default     = "local"
}

variable "iso_file" {
  type        = string
  description = "ISO filename (e.g. metal-amd64.iso)"
  default     = "metal-amd64.iso"
}

variable "network_bridge" {
  type        = string
  description = "Network bridge to attach the VM to"
  default     = "vmbr0"
}

variable "pm_api_url" {
  type        = string
  description = "Proxmox API host"
  default     = "192.168.1.20"
}
