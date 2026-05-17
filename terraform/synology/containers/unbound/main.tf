module "unbound" {
  source = "../../../modules/synology-container"

  name = "unbound"
  run  = true

  services = {
    unbound = {
      image   = "alpinelinux/unbound:latest-x86_64@sha256:d6e9d37a2887f8eed630073977334c08d90f177996877078a410106c5335bf90"
      restart = "unless-stopped"

      ports = [
        {
        target    = 53
        protocol  = "tcp"
        published = "53"
        },
        {
        target    = 53
        protocol  = "udp"
        published = "53"
        }
      ]

      configs = [{
        source = "unbound_records"
        target = "/etc/unbound/unbound.conf"
        mode   = "0644"
      }]
    }
  }

  configs = {
    unbound_records = {
      name    = "unbound_records"
      content = file("unbound-records.conf")
    }
  }

  networks = {
    app-network = {
      driver = "bridge"
    }
  }
}
