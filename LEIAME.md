# azure-iac

# Execute o comando abaixo para criar a imagem Docker

docker build -t terraform-image:azure-iac .


# Execute o comando abaixo para criar o container Docker

docker run -dit --name azure-iac -v ./IaC:/iac terraform-image:azure-iac /bin/bash

NOTA: No Windows você deve substituir ./IaC pelo caminho completo da pasta, por exemplo: C:\DSA\Cap15\IaC


# Verifique a versão do Terraform   

terraform version


# Execute as instruções abaixo dentro do container Docker!!!


# Instale o Azure CLI
Referência: https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt


# Baixe e instale a ferramenta de linha de comando do Azure CLI (opção de colocar direto no Dockerfile)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash


# Atualize a versão do Azure CLI (se necessário)
az upgrade


# Efetue login no Azure
az login


# Deploy

terraform init

terraform validate

terraform plan -out azure_iac.tfplan

terraform graph

# http://webgraphviz.com/

terraform apply azure_iac.tfplan

terraform destroy








