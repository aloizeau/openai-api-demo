variable "project_name" {
  description = "Nom du projet"
  type        = string
  default     = "openai-api-demo"
}

variable "location" {
  description = "Région Azure pour le déploiement"
  type        = string
  default     = "westeurope"
}

variable "openai_deployment_model_name" {
  description = "Nom du déploiement OpenAI"
  type        = string
  default     = "gpt-4"
}

variable "openai_deployment_model_version" {
  description = "Nom du déploiement OpenAI"
  type        = string
  default     = "turbo-2024-04-09"
