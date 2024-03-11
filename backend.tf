resource "docker_image" "node" {
  name = "${var.docker_namespace}_backend"
  build {
    context = "./backend"
    tag  = ["${var.docker_namespace}_backend:latest"]
  }
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "backend/*") : filesha1(f)]))
  }
}

resource "docker_container" "node" {
  image   = docker_image.node.image_id
  name    = "${var.docker_namespace}_backend"
  restart = "always"

  env = [
    "DB_USER=postgres",
    "DB_PASS=${random_password.postgres_default_password.result}",
    "DB_HOST=database",
    "DB_PORT=5432",
    "NODE_PORT=3000"
  ]

  networks_advanced {
    name    = docker_network.private_network.name
    aliases = ["backend"]
  }
}