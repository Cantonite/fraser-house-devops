terraform {
  cloud {
    organization = "Cantonite"

    workspaces {
      name = "fraser-house-devops-test"
    }
  }
}

module "stack" {
    source = "../../app"

    emoji = "🏆"
    env_name = "live"
}

output "website_url" {
  value = module.stack.website_url
}
