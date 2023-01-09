module "stack" {
    source = "../../stack"

    emoji = "🏆"
    env_name = "live"
}

output "website_url" {
  value = module.stack.website_url
}
