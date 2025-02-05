
# Terraform Modules
Esse projeto utiliza Terraform modularizado para provisionar e gerenciar recursos de infraestrutura na AWS, com suporte para múltiplas regiões.


## Estrutura do Projeto

- **environments/**: Diretório que contém configurações específicas para cada ambiente.
  - **demo1/**: Configuração personalizada para o ambiente `demo1`.
    - `main.tf`: Invoca o módulo com configurações específicas para o ambiente `demo1`.
    - `terraform.tfvars`: Arquivo com valores de variáveis utilizadas para o ambiente `demo1`.
    - `variables.tf`: Declara as variáveis necessárias para o ambiente `demo1`.
    
- **modules/**: Diretório que contém os módulos reutilizáveis para diferentes ambientes.
  - **vpc/**: Módulo responsável por configurar recursos relacionados à VPC.
    - `vpc.tf`: Define e provisiona os recursos necessários para a  VPC.
    - `variables.tf`: Declara as variáveis utilizadas pelo módulo.
    - `output.tf`: Define as saídas do módulo, permitindo que informações, como o ID da VPC, sejam referenciadas em outros recursos ou módulos.

## Recursos Provisionados
O Terraform provisiona os seguintes serviços na AWS.

- EC2
- VPC | Subnets Multi-AZ
- NAT Gateway
- Internet Gateway


## ⚠️ Atenção

- A variavel `ssh_key_name` deve ser o nome da chave SSH pública importada ou criada no AWS Key Pair.

## Pré-requisitos

- [Terraform](https://www.terraform.io/downloads.html) instalado na sua máquina.
- Credenciais da AWS IAM configuradas.
