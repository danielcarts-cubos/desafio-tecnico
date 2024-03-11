data "docker_registry_image" "postgres" {
  name = "postgres:15.4-alpine"
}

resource "docker_image" "postgres" {
  name          = data.docker_registry_image.postgres.name
  pull_triggers = [data.docker_registry_image.postgres.sha256_digest]
}

resource "docker_volume" "postgres-data" {
  name = "${var.docker_namespace}_postgres-data"
}

resource "docker_container" "postgres" {
  image   = docker_image.postgres.image_id
  name    = "${var.docker_namespace}_postgres"
  restart = "always"

  volumes {
    container_path = "/var/lib/postgresql/data"
    volume_name    = docker_volume.postgres-data.name
  }

  volumes {
    container_path = "/docker-entrypoint-initdb.d"
    host_path = "${abspath(path.module)}/sql"
    read_only = true
  }

  env = [
    "POSTGRES_PASSWORD=${random_password.postgres_default_password.result}"
  ]

  networks_advanced {
    name    = docker_network.private_network.name
    aliases = ["database"]
  }
}

resource "random_password" "postgres_default_password" {
  length = 32
  special = false
}