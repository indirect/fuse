require "github"

Github.app_config(
  id: ENV.fetch("GITHUB_APP_ID"),
  name: ENV.fetch("GITHUB_APP_NAME"),
  private_key: ENV.fetch("GITHUB_APP_PRIVATE_KEY")
)
