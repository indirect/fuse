require "github"

Github.app_id = ENV.fetch("GITHUB_APP_ID"),
Github.app_private_key = ENV.fetch("GITHUB_APP_PRIVATE_KEY")
