# Terraform configuration
terraform {

  # Specifying the provider
  required_providers {

    # AzureRM provider by HashiCorp
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# AzureRM provider configuration
provider "azurerm" {

  # Enable default resources and features
  features {}
}
