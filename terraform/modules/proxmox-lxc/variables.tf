variable "container_name" {
  type        = string
  description = "The name of the LXC container"
}

variable "target_node" {
  type        = string
  description = "The Proxmox node on which to create the container"
  default     = "proxmox-001"
}

variable "os_template" {
  type        = string
  description = "The OS template to use for the container"
  default     = "local:vztmpl/debian-12-standard.tar.gz"
}

variable "cores" {
  type        = number
  description = "Number of CPU cores"
  default     = 2
}

variable "memory" {
  type        = number
  description = "Amount of memory in MB"
  default     = 2048
}

variable "rootfs_size" {
  type        = number
  description = "Size of the rootfs disk in GB"
  default     = 16
}

variable "rootfs_storage" {
  type        = string
  description = "Storage pool for rootfs"
  default     = "vmstore"
}

variable "network_bridge" {
  type        = string
  description = "Network bridge to use"
  default     = "vmbr0"
}

variable "nfs_server" {
  type        = string
  description = "NFS server address"
  default     = null
}

variable "nfs_path" {
  type        = string
  description = "NFS export path"
  default     = null
}

variable "nfs_mount_point" {
  type        = string
  description = "Mount point path inside container"
  default     = "/mnt/nfs"
}

variable "nfs_storage" {
  type        = string
  description = "Proxmox storage name for NFS mount"
  default     = null
}

variable "start_on_boot" {
  type        = bool
  description = "Start container on boot"
  default     = true
}
