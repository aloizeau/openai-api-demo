variable "project_name" {
  description = "Project name"
  type        = string
  default     = "openai-api-demo"
}

variable "location" {
  description = "Azure region to locate resources"
  type        = string
  default     = "westeurope"
}

variable "openai_deployment_model_name" {
  description = "Name of OpenAI model"
  type        = string
  default     = "gpt-4"
}

variable "openai_deployment_model_version" {
  description = "Version of OpenAI model"
  type        = string
  default     = "turbo-2024-04-09"
}

## Azure OpenAI Policy Block Enabled Variable ##
variable "openai_content_filter_block_enabled" {
  type        = bool
  description = "Whether the filter should block content. Possible values are true or false"
  default     = true
}

## Azure OpenAI Policy Severity Threshold Variable ##
variable "openai_content_filter_severity_threshold" {
  type        = string
  description = "The severity threshold for the filter. Possible values are Low, Medium or High"
  default     = "Medium"
}