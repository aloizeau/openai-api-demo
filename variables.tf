variable "client_id" {
  description = "Client ID of the service principal"
  type        = string
}

variable "client_secret" {
  description = "Client secret of the service principal"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID of the Azure subscription"
  type        = string
}

variable "subscription_id" {
  description = "Subscription ID of the Azure subscription"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "openai-api-demo"
}

variable "location" {
  description = "Azure region to locate resources"
  type        = string
  default     = "Sweden Central"
}

variable "openai_deployment_model_name" {
  description = "Name of OpenAI model"
  type        = string
  default     = "gpt-4.5-preview"
}

variable "openai_deployment_model_version" {
  description = "Version of OpenAI model"
  type        = string
  default     = "2025-02-27"
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