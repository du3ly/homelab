data "proxmox_virtual_environment_vms" "template" {
  count = var.vm_clone_template != "" ? 1 : 0
  filter {
    name   = "name"
    values = [var.vm_clone_template]
  }
}

resource "proxmox_virtual_environment_file" "user_data" {
  count = var.user_data != null ? 1 : 0

  content_type = "snippets"
  datastore_id = var.snippet_storage
  node_name    = var.target_node

  source_raw {
    data      = var.user_data
    file_name = "${var.vm_name}-user-data.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "this" {
  name        = var.vm_name
  description = var.vm_desc
  node_name   = var.target_node

  boot_order = ["scsi0"]

  agent {
    enabled = true
  }

  cpu {
    cores = var.cores
  }

  memory {
    dedicated = var.memory
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = var.disk_storage
    interface    = "scsi0"
    size         = parseint(replace(var.disk_size, "G", ""), 10)
    backup       = var.disk_backup
  }

  initialization {
    datastore_id      = var.disk_storage
    user_data_file_id = var.user_data != null ? proxmox_virtual_environment_file.user_data[0].id : null
  }

  dynamic "clone" {
    for_each = var.vm_clone_template != "" ? [1] : []
    content {
      vm_id = data.proxmox_virtual_environment_vms.template[0].vms[0].vm_id
      full  = var.full_clone
    }
  }
}
