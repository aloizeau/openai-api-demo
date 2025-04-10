resource "azurerm_storage_account" "sa" {
  name                     = format("%ssa",replace(var.project_name, "-", ""))
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                = local.common_tags
  lifecycle {
    ignore_changes = [
      tags["creationdate"]
    ]
  }
}

resource "azurerm_service_plan" "plan" {
  name                = format("%s-plan", var.project_name)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "Y1" // Consumption plan (serverless)
  tags                = local.common_tags
  lifecycle {
    ignore_changes = [
      tags["creationdate"]
    ]
  }
}

resource "azurerm_linux_function_app" "function" {
  name                       = format("%s-api", var.project_name)
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  service_plan_id            = azurerm_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key
  
  identity {
    type = "SystemAssigned"
  }
  site_config {
    application_stack {
      python_version = "3.10"
    }
    linux_fx_version = "Python|3.10"    
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME      = "python"
    WEBSITE_RUN_FROM_PACKAGE      = "1"
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.ai.instrumentation_key
    AZURE_OPENAI_ENDPOINT         = azurerm_cognitive_account.openai.endpoint
    AZURE_OPENAI_API_KEY          = azurerm_cognitive_account.openai.primary_access_key
    AZURE_OPENAI_DEPLOYMENT       = var.openai_deployment_model_name
  }
  tags                = local.common_tags
  lifecycle {
    ignore_changes = [
      tags["creationdate"]
    ]
  }
}
