locals {
  # Tags communes à toutes les ressources
  common_tags = {
    application    = "open-ai"
    creationdate   = formatdate("DD-MM-YYYY hh:mm:ss", timestamp())
    deploymentMode = "terraform"
    env            = "demo"
    repository     = "https://github.dev/aloizeau/openai-api-demo"
  }
}
