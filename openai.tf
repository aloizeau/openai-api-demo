resource "azurerm_cognitive_account" "openai" {
  name                = format("%s-openai", var.project_name)  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "OpenAI"
  sku_name            = "S0"
  custom_subdomain_name = format("%s-openai", var.project_name)
  identity {
    type = "SystemAssigned"
  }
  tags                = local.common_tags
  lifecycle {
    ignore_changes = [
      tags["creationdate"]
    ]
  }
}

resource "azurerm_cognitive_deployment" "openai-gpt" {
  name                 = var.openai_deployment_model_name
  cognitive_account_id = azurerm_cognitive_account.openai.id
  model {
    # https://learn.microsoft.com/fr-fr/azure/ai-services/openai/concepts/models
    format  = "OpenAI"
    name    = var.openai_deployment_model_name
    version = var.openai_deployment_model_version
  }

  sku {
    name = "Standard"
  }
}