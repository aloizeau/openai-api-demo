resource "azurerm_resource_group" "rg" {
  name     = var.project_name
  location = var.location
  tags     = local.common_tags

  lifecycle {
    ignore_changes = [
      tags["creationdate"]
    ]
  }
}