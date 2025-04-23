resource "azurerm_key_vault" "kv" {
  name                      = format("%s-kv", var.project_name)
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  sku_name                  = "standard"
  enable_rbac_authorization = true

  tags = local.common_tags
  lifecycle {
    ignore_changes = [
      tags["creationdate"]
    ]
  }
}

resource "azurerm_role_assignment" "secret_officer" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "secret_user" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_function_app.function.identity[0].principal_id
}

resource "azurerm_key_vault_secret" "openai" {
  name         = "openai"
  value        = azurerm_cognitive_account.openai.primary_access_key
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [ azurerm_role_assignment.secret_officer ]
}
