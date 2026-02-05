terraform {
  backend "pg" {
    schema_name = "tf_proxmox_001_test_server"
  }
}
