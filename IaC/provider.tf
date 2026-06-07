# configuração do Terraform
terraform {

  # Especificando o provedor
  required_providers {

    # Provedor AzureRM da HashiCorp
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Configurando do AzureRM
provider "azurerm" {

  # Habilita recursos e funcionalidades padrão
  features {}
}
