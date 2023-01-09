module "stack" {
    source = "../../stack"

    emoji = "🥶"
    env_name = "test"
}

output "website_url" {
  value = module.stack.website_url
}
