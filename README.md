# Desafio técnico - Cubos DevOps

Recursos criados conforme especificação do desafio.

## Pré-requisitos

[Terraform](https://developer.hashicorp.com/terraform/install) instalado.  
Acesso a um [endpoint Docker](https://docs.docker.com/engine/context/working-with-contexts/). Caso necessário, [instale Docker](https://docs.docker.com/get-docker/) localmente para ter acesso a um endpoint local.

## Inicialização

### Terraform

Execute o comando `terraform init`.

### Docker

Deve-se configurar o endpoint Docker no qual os comandos serão executados.

#### Como descobrir qual seu endpoint Docker

No Windows, usualmente é `npipe:////./pipe/docker_engine`, e no Linux `unix:///var/run/docker.sock`, mas outras opções são possiveis.

Para ter certeza, basta executar o comando e olhar a coluna "DOCKER ENDPOINT":
```sh
docker context list
```

Se você tem Python instalado, pode usar esse "one-liner":
 ```sh
 docker context list --format json | python3 -c "import sys, json; j=json.load(sys.stdin); [print(x['DockerEndpoint']) if x['Current'] else None for x in j]"
 ```
 [fonte](https://github.com/docker/for-mac/issues/6529#issuecomment-1287442216)

 ## Execução

Existem três variáveis de execução deste projeto Terraform:
 - docker_namespace: Prefixo para os recursos Docker criados. O padrão é `desafio-cubos-devops`.
 - docker_port: Host/endpoint do Docker usado para criação dos recursos do ambiente. O padrão é `npipe:////./pipe/docker_engine`.
 - host_port: Porta do host na qual o proxy/frontend estará disponível. A padrão é `8080`.

Caso necessário trocar algum desses por conflitos no seu ambiente local de testes, basta passar a opção -var para o comando plan do terraform abaixo.

Finalmente, para implantar o ambiente do desafio, execute os seguintes comandos:

 1. `terraform plan --out plan.cache -var="host_port=8081"`  
 Após esse comando, verifique se o plano mostrado pelo Terraform é razoável - neste desafio, ele deve criar 10 recursos.
 2. `terraform apply plan.cache`  
 Feito isso, o ambiente estará no ar em localhost:8081.
