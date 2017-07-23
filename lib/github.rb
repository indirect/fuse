require "threaded_memoize"

module Github
  mattr_accessor :app_id, :app_private_key
  extend ThreadedMemoize

  def self.app
    require "github/app"
    @app ||= App.new(app_id, app_private_key)
  end

  def self.app_client
    # App bearer tokens are only valid for 10 minutes (minus 10 seconds just in case)
    threaded_memoize(expires_in: 550) do
      require "github/client"
      Client.new(bearer_token: app.bearer_token)
    end
  end

end
