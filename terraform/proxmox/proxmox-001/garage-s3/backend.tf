terraform {
  backend "pg" {
    schema_name = "tf_proxmox_001_garage_s3"
  }
}
