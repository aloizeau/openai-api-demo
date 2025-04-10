resource "azurerm_log_analytics_workspace" "law" {
  name                = format("%s-law", var.project_name)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.common_tags
  lifecycle {
    ignore_changes = [
      tags["creationdate"]
    ]
  }
}
