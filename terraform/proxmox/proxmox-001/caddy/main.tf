locals {
  caddy_ip = "192.168.1.30"
}

module "instance" {
  source = "../../../modules/proxmox-lxc"

  vm_id    = 300
  hostname = "caddy"

  # Caddy is extremely lean — 1 vCPU and 512 MB is plenty
  cpu_cores = 1
  memory_mb = 512
  disk_size = 4

  ipv4_address   = "${local.caddy_ip}/24"
  network_bridge = "vmbr0"

  template_datastore = "local"
  disk_datastore     = "vmstore"

  ssh_key = [var.ssh_public_key]
}

# Copy the Caddyfile to a staging path first (caddy package not yet installed)
resource "null_resource" "caddy_init" {
  depends_on = [module.instance]

  connection {
    type        = "ssh"
    host        = local.caddy_ip
    user        = "root"
    private_key = file(var.ssh_private_key_path)
  }

  # 1. Install Caddy via the official apt repo
  provisioner "remote-exec" {
    inline = [
      "apt-get install -y debian-keyring debian-archive-keyring apt-transport-https curl gnupg",
      "curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg",
      "curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list",
      "apt-get update",
      "apt-get install -y caddy",
    ]
  }

  # 2. Systemd drop-in: disable namespace-based security directives that are
  #    incompatible with unprivileged LXC containers (exit code 226/NAMESPACE).
  #    Uses a drop-in so the upstream unit file survives Caddy package upgrades.
  provisioner "remote-exec" {
    inline = [
      "mkdir -p /etc/systemd/system/caddy.service.d",
      "printf '[Service]\\nPrivateTmp=no\\nPrivateDevices=no\\nProtectSystem=no\\nProtectHome=no\\nProtectKernelTunables=no\\nProtectKernelModules=no\\nProtectControlGroups=no\\nRestrictNamespaces=no\\nLockPersonality=no\\nMemoryDenyWriteExecute=no\\nRestrictRealtime=no\\n' > /etc/systemd/system/caddy.service.d/override.conf",
      "systemctl daemon-reload",
    ]
  }

  # 3. Drop the Caddyfile — package installation creates /etc/caddy/
  provisioner "file" {
    source      = "${path.module}/Caddyfile"
    destination = "/etc/caddy/Caddyfile"
  }

  # 4. Enable on boot and apply config
  provisioner "remote-exec" {
    inline = [
      "systemctl enable caddy",
      "systemctl restart caddy",
    ]
  }
}
