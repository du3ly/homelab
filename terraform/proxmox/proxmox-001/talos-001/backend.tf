terraform {
  backend "s3" {
    endpoints = {
      s3 = "http://192.168.1.21:3900"
    }
    bucket   = "terraform-state"
    key      = "proxmox/proxmox-001/talos-001/terraform.tfstate"
    region   = "us-east-1"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}
