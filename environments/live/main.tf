module "app" {
    source = "../../app"

    emoji = "🤗"
    env_name = "live"
}

output "website_url" {
  value = module.app.website_url
}
