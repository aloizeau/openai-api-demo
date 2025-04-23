### Terraform Provider Configuration

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  # Configure the provider with the necessary credentials
  # The credentials can be set using environment variables or directly in the provider block.
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  use_msi         = false
  
}

terraform {
  required_version = "~> 1.11.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.26.0"
    }
  }
}
