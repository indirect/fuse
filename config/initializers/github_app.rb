require "current"
require "github/app"

Current.github_app = Github::App.new(
  ENV.fetch("GITHUB_APP_ID"),
  ENV.fetch("GITHUB_APP_PRIVATE_KEY")
)
