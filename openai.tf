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

## Create Content Filter Policy for Azure OpenAI ##
resource "azurerm_cognitive_account_rai_policy" "content_filter" {
  name                 = "kopicloud-aoi-cf"
  cognitive_account_id = azurerm_cognitive_account.openai.id
  base_policy_name     = "Microsoft.Default"
  
  content_filter {
    name               = "Profanity"
    filter_enabled     = true
    block_enabled      = var.openai_content_filter_block_enabled
    severity_threshold = var.openai_content_filter_severity_threshold
    source             = "Completion"
  }

  content_filter {
    name               = "Profanity"
    filter_enabled     = true
    block_enabled      = var.openai_content_filter_block_enabled
    severity_threshold = var.openai_content_filter_severity_threshold
    source             = "Prompt"
  }

  content_filter {
    name               = "Hate"
    filter_enabled     = true
    block_enabled      = var.openai_content_filter_block_enabled
    severity_threshold = var.openai_content_filter_severity_threshold
    source             = "Completion"
  }

  content_filter {
    name               = "Hate"
    filter_enabled     = true
    block_enabled      = var.openai_content_filter_block_enabled
    severity_threshold = var.openai_content_filter_severity_threshold
    source             = "Prompt"
  }
  
  content_filter {
    name               = "Violence"
    filter_enabled     = true
    block_enabled      = var.openai_content_filter_block_enabled
    severity_threshold = var.openai_content_filter_severity_threshold
    source             = "Completion"
  }  

  content_filter {
    name               = "Violence"
    filter_enabled     = true
    block_enabled      = var.openai_content_filter_block_enabled
    severity_threshold = var.openai_content_filter_severity_threshold
    source             = "Prompt"
  }  

  content_filter {
    name               = "Sexual"
    filter_enabled     = true
    block_enabled      = var.openai_content_filter_block_enabled
    severity_threshold = var.openai_content_filter_severity_threshold
    source             = "Completion"
  }  

  content_filter {
    name               = "Sexual"
    filter_enabled     = true
    block_enabled      = var.openai_content_filter_block_enabled
    severity_threshold = var.openai_content_filter_severity_threshold
    source             = "Prompt"
  }
  
  content_filter {
    name               = "SelfHarm"
    filter_enabled     = true
    block_enabled      = var.openai_content_filter_block_enabled
    severity_threshold = var.openai_content_filter_severity_threshold
    source             = "Completion"
  }
 
  content_filter {
    name               = "SelfHarm"
    filter_enabled     = true
    block_enabled      = var.openai_content_filter_block_enabled
    severity_threshold = var.openai_content_filter_severity_threshold
    source             = "Prompt"
  }

  content_filter {
    name               = "Jailbreak"
    filter_enabled     = true
    block_enabled      = var.openai_content_filter_block_enabled
    severity_threshold = var.openai_content_filter_severity_threshold
    source             = "Prompt"
  }

  content_filter {
    name               = "Indirect Attack"
    filter_enabled     = true
    block_enabled      = var.openai_content_filter_block_enabled
    severity_threshold = var.openai_content_filter_severity_threshold
    source             = "Prompt"
  }

  content_filter {
    name               = "Protected Material Text"
    filter_enabled     = true
    block_enabled      = var.openai_content_filter_block_enabled
    severity_threshold = var.openai_content_filter_severity_threshold
    source             = "Completion"
  }

  content_filter {
    name               = "Protected Material Code"
    filter_enabled     = true
    block_enabled      = var.openai_content_filter_block_enabled
    severity_threshold = var.openai_content_filter_severity_threshold
    source             = "Completion"
  }
}