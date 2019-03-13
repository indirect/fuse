source "https://rubygems.org"
git_source(:github) { |name|  "https://github.com/#{name}.git" }

gem "rails", "5.1.6.2"

gem "activerecord-import", "~> 0.19.1"
gem "jwt", "~> 1.5"
gem "github_webhook", "~> 1.0", github: "indirect/github_webhook", branch: "app-events"
gem "octokit", "~> 4.7", github: "octokit/octokit.rb", branch: "master"
gem "pg", "~> 0.21"
gem "puma", "~> 3.9"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5.0"
gem "webpacker", "~> 2.0"

group :development, :test do
  gem "dotenv-rails", "~> 2.2"
  gem "pry-byebug", "~> 3.4"
  gem "pry-rails", "~> 0.3.6"
  gem "rspec-rails", "~> 3.6"
end

group :development do
  gem "guard-rspec", require: false
  gem "listen", "~> 3.1.5"
  gem "spring", "~> 2.0"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.5"
end
