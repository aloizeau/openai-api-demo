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

variable "openai_deployment" {
  description = "Nom du déploiement OpenAI" # https://learn.microsoft.com/fr-fr/azure/ai-services/openai/concepts/models
  type        = string
  default     = "gpt-4-turbo" # turbo-2024-04-09
}
