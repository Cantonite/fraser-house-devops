module "app" {
    source = "../../app"

    emoji = "🤖"
    env_name = "test"
}

output "website_url" {
  value = module.app.website_url
}
