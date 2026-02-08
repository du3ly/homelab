variable "cores" {
  type    = number
  default = 1
}

variable "disk_size_gb" {
  type    = number
  default = 32
}

variable "disk_storage" {
  type        = string
  description = "The ID of the storage pool on which to store the disk"
  default     = "vmstore"
}

variable "memory" {
  type    = number
  default = 1024
}

variable "pm_api_url" {
  type    = string
  default = "192.168.1.20"
}

variable "target_node" {
  type        = string
  description = "The name of the Proxmox Node on which to place the VM"
  default     = "proxmox-001"
}

variable "vm_desc" {
  type        = string
  description = "The description of the VM. Shows as the 'Notes' field in the Proxmox GUI"
  default     = ""
}

variable "vm_name" {
  type    = string
  default = ""
}

variable "vm_id" {
  type    = number
}

variable "disk_backup" {
  type    = bool
  default = true
}

variable "vm_clone_template" {
  type        = number
  description = "VM ID of template to clone from. Set to null or 0 to skip cloning."
  default     = null
}

variable "full_clone" {
  type        = bool
  description = "Whether to create a full clone (true) or linked clone (false)"
  default     = true
}
