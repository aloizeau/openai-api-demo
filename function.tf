resource "azurerm_storage_account" "sa" {
  name                     = format("%ssa", replace(var.project_name, "-", ""))
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.common_tags
  lifecycle {
    ignore_changes = [
      tags["creationdate"]
    ]
  }
}

resource "azurerm_role_assignment" "blob" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}


resource "archive_file" "function_package" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/function_code.zip"
}

resource "azurerm_storage_container" "function_releases" {
  name                  = "function-releases"
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
  depends_on            = [azurerm_role_assignment.blob]
}

resource "azurerm_storage_blob" "function_zip" {
  name                   = "function_code.zip"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.function_releases.name
  type                   = "Block"
  source                 = archive_file.function_package.output_path
  content_type           = "application/zip"
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
    application_insights_key = azurerm_application_insights.ai.instrumentation_key
    application_stack {
      python_version = "3.13"
    }
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME       = "python"
    WEBSITE_RUN_FROM_PACKAGE       = "1"
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.ai.instrumentation_key
    AZURE_OPENAI_ENDPOINT          = azurerm_cognitive_account.openai.endpoint
    AZURE_OPENAI_DEPLOYMENT        = var.openai_deployment_model_name
    AZURE_OPENAI_API_VERSION       = var.openai_deployment_model_version
    KEY_VAULT_URI                  = azurerm_key_vault.kv.vault_uri
    OPEN_AI_SECRET_KEY             = azurerm_key_vault_secret.openai.name
    WEBSITE_RUN_FROM_PACKAGE       = azurerm_storage_blob.function_zip.url
  }
  tags = local.common_tags
  lifecycle {
    ignore_changes = [
      tags["creationdate"]
    ]
  }
}
