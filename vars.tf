variable "docker_namespace" {
  type    = string
  default = "desafio-cubos-devops"
}

variable "docker_host" {
  type    = string
  default = "npipe:////./pipe/docker_engine"
}