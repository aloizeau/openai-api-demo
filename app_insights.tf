resource "azurerm_application_insights" "ai" {
  name                = format("%s-ai", var.project_name)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
  retention_in_days   = 30
  workspace_id        = azurerm_log_analytics_workspace.law.id
  tags                = local.common_tags
  disable_ip_masking = true
  lifecycle {
    ignore_changes = [
      tags["creationdate"]
    ]
  }
}
