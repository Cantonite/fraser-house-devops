terraform {
  cloud {
    organization = "Cantonite"

    workspaces {
      name = "fraser-house-devops-test"
    }
  }
}

module "app" {
    source = "../../app"

    emoji = "🤖"
    env_name = "test"
}

output "website_url" {
  value = module.app.website_url
}

moved {
  from = module.stack
  to = module.app
}