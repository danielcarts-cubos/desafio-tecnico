variable "docker_namespace" {
  type    = string
  default = "desafio-cubos-devops"
  description = "Prefixo para os recursos Docker criados."
}

variable "docker_host" {
  type    = string
  default = "npipe:////./pipe/docker_engine"
  description = "Host/endpoint do Docker usado para criação dos recursos do ambiente."
}

variable "host_port" {
  type = string
  default = "8080"
  description = "Porta do host na qual o proxy/frontend estará disponível."
}