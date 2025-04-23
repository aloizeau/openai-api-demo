locals {
  # Tags communes à toutes les ressources
  common_tags = {
    application    = "open-ai"
    creationdate   = formatdate("DD-MM-YYYY hh:mm:ss", timestamp())
    deploymentMode = "terraform"
    env            = "demo"
    repository     = "https://github.dev/aloizeau/openai-api-demo"
  }

  content_filters = [
    { name = "Profanity", sources = ["Completion", "Prompt"] },
    { name = "Hate", sources = ["Completion", "Prompt"] },
    { name = "Violence", sources = ["Completion", "Prompt"] },
    { name = "Sexual", sources = ["Completion", "Prompt"] },
    { name = "SelfHarm", sources = ["Completion", "Prompt"] },
    { name = "Jailbreak", sources = ["Prompt"] },
    { name = "Indirect Attack", sources = ["Prompt"] },
    { name = "Protected Material Text", sources = ["Completion"] },
    { name = "Protected Material Code", sources = ["Completion"] }
  ]
}
