terraform {
  cloud {
    organization = "Cantonite"

    workspaces {
      name = "fraser-house-devops-live"
    }
  }
}
