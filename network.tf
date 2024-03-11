resource "docker_network" "public_network" {
  name = "${var.docker_namespace}_public"
}

resource "docker_network" "private_network" {
  name     = "${var.docker_namespace}_private"
  internal = true
}