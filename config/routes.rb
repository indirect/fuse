Rails.application.routes.draw do
  post "github", to: "github_webhooks#create", defaults: { formats: :json }
end
