# Network configuration
ip_address = "192.168.1.100/24"

# Proxmox node
target_node = "proxmox-001"

# Garage S3 secrets - generate your own with: openssl rand -hex 32
garage_admin_secret = "change-me-admin-secret"
garage_api_secret   = "change-me-api-secret"
