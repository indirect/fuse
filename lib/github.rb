module Github
  mattr_accessor :app_id, :app_private_key

  def self.app
    @app ||= App.new(app_id, app_private_key)
  end

  def self.client
    # App bearer tokens are only valid for 10 minutes (minus 10 seconds just in case)
    threaded_memoize(expires_in: 550) do
      require "github/client"
      Client.new(
        bearer_token: app.bearer_token,
        default_media_type: "application/vnd.github.machine-man-preview+json"
      )
    end
  end

end
