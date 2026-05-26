module "instance" {
  source = "../../../modules/proxmox-vm"

  vm_name           = "k3s-002"
  vm_clone_template = "debian-12.13.0"
  full_clone        = false

  cores  = 2
  memory = 4096

  user_data = <<EOF
#cloud-config
runcmd:
  - apt-get update && apt-get install -y curl
  - curl -sfL https://get.k3s.io | sh -
EOF
}
