terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.104.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://192.168.1.20:8006/"
  insecure = true
  # api_token = var.proxmox_api_token  (via env var or tfvars)
}
