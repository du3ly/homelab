module "dozzle" {
  source = "../../../modules/synology-container"

  name = "dozzle"
  run  = true

  services = {
    dozzle = {
      image   = "amir20/dozzle:latest"
      restart = "always"

      ports = [{
        target    = 8080
        protocol  = "tcp"
        published = "9999"
      }]

      volumes = [{
        type   = "bind"
        source = "/var/run/docker.sock"
        target = "/var/run/docker.sock"
      }]
    }
  }

  networks = {
    app-network = {
      driver = "bridge"
    }
  }
}
