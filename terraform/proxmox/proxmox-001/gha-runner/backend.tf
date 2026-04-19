terraform {
  backend "pg" {
    schema_name = "tf_proxmox_001_gha_runner"
  }
}
