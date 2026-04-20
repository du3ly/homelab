variable "github_token" {
  description = "GitHub runner registration token"
  type        = string
  sensitive   = true
}

variable "runner_url" {
  description = "GitHub repository/organization URL for the runner"
  type        = string
  default     = "https://github.com/duelyyung/homelab"
}

variable "runner_name" {
  description = "Name of the runner"
  type        = string
  default     = "gha-runner-001"
}

variable "runner_group" {
  description = "Runner group name"
  type        = string
  default     = "Default"
}

module "gha_runner" {
  source = "../../../modules/proxmox-lxc"

  hostname        = "gha-runner-001"
  description     = "GitHub Actions Self-Hosted Runner"
  template_vm_id  = 100
  target_node     = "proxmox-001"
  memory          = 2048
  swap            = 1024
  cores           = 2
  disk_size       = 20
  disk_storage    = "local-lvm"
  ip_address      = "192.168.1.100/24"
  onboot          = true
  unprivileged    = false
  nesting         = true
  cloud_init_script = "${path.module}/cloud-init.yaml"
}

output "container_id" {
  value = module.gha_runner.container_id
}

output "hostname" {
  value = module.gha_runner.hostname
}
