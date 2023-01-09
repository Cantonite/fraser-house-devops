module "stack" {
    source = "../../app"

    emoji = "🥶"
    env_name = "test"
}

output "website_url" {
  value = module.stack.website_url
}
