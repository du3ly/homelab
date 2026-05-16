terraform {
  backend "s3" {
    endpoint                    = "http://192.168.1.21:3900"
    bucket                      = "terraform-state"
    key                         = "synology/containers/unbound/terraform.tfstate"
    region                      = "us-east-1"
  
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    force_path_style            = true
  }
}
