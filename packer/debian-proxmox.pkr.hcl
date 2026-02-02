locals {
  debian_version = "12.13.0"
  debian_iso_checksum = "2b880ffabe36dbe04a662a3125e5ecae4db69d0acce257dd74615bbf165ad76e"
  vm_id = 201
}

source "proxmox-iso" "debian" {
  boot_command = [
    "<wait><wait><wait><esc><wait><wait><wait>",
    "/install.amd/vmlinuz ",
    "initrd=/install.amd/initrd.gz ",
    "auto=true ",
    "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.preseed_file} ",
    "hostname=packer ",
    "domain=hsd1.il.comcast.net. ",
    "interface=auto ",
    "vga=788 noprompt quiet --<enter>"
  ]
  boot_wait    = "10s"
  cloud_init   = true
  cloud_init_storage_pool = "vmstore"
  disks {
    disk_size         = "32G"
    storage_pool      = "vmstore"
    type              = "scsi"
  }
  http_content             = { "/${var.preseed_file}" = templatefile(var.preseed_file, { var = var }) }
  insecure_skip_tls_verify = true
  boot_iso {
    iso_url                  = "https://cdimage.debian.org/cdimage/archive/${local.debian_version}/amd64/iso-cd/debian-${local.debian_version}-amd64-netinst.iso"
    iso_storage_pool         = "local"
    iso_checksum             = "${local.debian_iso_checksum}"
    unmount                  = true
  }
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  memory               = "1024"
  node                 = "proxmox-001"
  proxmox_url          = "https://192.168.1.20:8006/api2/json"
  ssh_password         = "${var.ssh_password}"
  ssh_timeout          = "15m"
  ssh_username         = "${var.ssh_username}"
  template_description = "Debian ${local.debian_version}, generated on ${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  template_name        = "debian-${local.debian_version}"
  token                = "${var.proxmox_token}"
  username             = "${var.proxmox_user}"
  vm_id                = "${local.vm_id}"
}

build {
  sources = ["source.proxmox-iso.debian"]

  provisioner "file" {
      destination = "/tmp/requirements.txt"
      source = "../requirements.txt"
  }

  provisioner "shell" {
    execute_command = "{{.Vars}} sudo -S -E bash '{{.Path}}'"
    scripts = [
      "scripts/ansible.sh"
    ]
  }

  provisioner "ansible-local" {
    command = "source /tmp/ansible-venv/bin/activate && ANSIBLE_FORCE_COLOR=1 PYTHONBUFFERED=1 ansible-playbook"
    extra_arguments = [
      "-e", "ansible_python_interpreter=/usr/bin/python3",
      "-t", "operators"
    ]
    inventory_groups = ["all"]
    playbook_dir  = "../ansible"
    playbook_file = "../ansible/playbooks/base.yml"
  }

  provisioner "shell" {
    execute_command = "{{.Vars}} sudo -S -E bash '{{.Path}}'"
    expect_disconnect = "true"
    scripts = [
      "scripts/cleanup.sh"
    ]
  }
}

packer {
  required_plugins {
    ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}
