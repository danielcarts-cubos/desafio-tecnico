data "docker_registry_image" "nginx" {
  name = "nginx:1.25-alpine"
}

resource "docker_image" "nginx" {
  name = "${var.docker_namespace}_frontend"
  build {
    context = "./frontend"
    tag  = ["${var.docker_namespace}_frontend:latest"]
  }
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "frontend/*") : filesha1(f)]))
  }
}

resource "docker_container" "nginx" {
  image   = docker_image.nginx.image_id
  name    = "${var.docker_namespace}_proxy-frontend"
  restart = "always"

  ports {
    internal = "8080"
    external = var.host_port
  }

  networks_advanced {
    name = docker_network.public_network.name
  }

  networks_advanced {
    name = docker_network.private_network.name
  }
}