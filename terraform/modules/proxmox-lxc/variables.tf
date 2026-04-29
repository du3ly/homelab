variable "node_name" {
  type        = string
  description = "Proxmox node name"
  default     = "proxmox-001"
}

variable "vm_id" {
  type        = number
  description = "VM/CT ID for the container"
}

variable "hostname" {
  type        = string
  description = "Container hostname"
}

variable "template_datastore" {
  type        = string
  description = "Datastore to store the downloaded template"
  default     = "local"
}

variable "template_url" {
  type        = string
  description = "URL to download the container template from"
  default     = "http://download.proxmox.com/images/system/debian-13-standard_13.1-2_amd64.tar.zst"
}

variable "cpu_cores" {
  type        = number
  description = "Number of CPU cores"
  default     = 2
}

variable "memory_mb" {
  type        = number
  description = "Dedicated memory in MB"
  default     = 2048
}

variable "disk_datastore" {
  type        = string
  description = "Datastore for container disk"
  default     = "vmstore"
}

variable "disk_size" {
  type        = number
  description = "Disk size in GB"
  default     = 10
}

variable "network_bridge" {
  type        = string
  description = "Network bridge to use"
  default     = "vmbr0"
}

variable "ipv4_address" {
  type        = string
  description = "IPv4 address (use 'dhcp' for DHCP)"
  default     = "dhcp"
}

variable "started" {
  type        = bool
  description = "Whether the container should be started"
  default     = true
}

variable "ssh_key" {
  type        = list(string)
  description = "The SSH keys for the root account"
  default     = []
}
