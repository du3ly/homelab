terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.94.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://${var.pm_api_url}:8006/"
  insecure = true
}
