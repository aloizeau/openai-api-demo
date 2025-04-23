### Terraform backend pour le stockage du tfstate dans un storage account Azure ###

##############################################################################################################################
### /!\ ONLY ACTIVATE FOR LOCAL TEST AND COMMENT IT AGAIN AFTER !
##############################################################################################################################
#terraform {
#  backend "azurerm" {
#    resource_group_name  = "<rg_name>"
#    storage_account_name = "<storage_account_name>"
#    container_name       = "<container-name>"
#    key                  = "<terraform-file.tfstate>"
#    subscription_id      = "<sub-id>"
#  }
#}
##############################################################################################################################
terraform {

  backend "local" {
    path = "terraform.tfstate"
  }
  # backend "azurerm" {
  # }
}
