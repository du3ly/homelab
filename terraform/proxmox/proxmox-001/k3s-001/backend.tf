terraform {
  backend "pg" {
    schema_name = "tf_proxmox_001_k3s_001"
  }
}
