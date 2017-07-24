require "threaded_memoize"

# Setup:
#   Github.app_config(
#     app_id: 123,
#     app_name: "Fuse",
#     app_private_key: "abc123..."
#  )
module Github
  extend ThreadedMemoize

  def self.app_config(config)
    @app_config = config
  end

  def self.app
    @app ||= App.new(@app_config)
  end

  def self.app_client
    # App bearer tokens are only valid for 10 minutes (minus 10 seconds just in case)
    threaded_memoize(expires_in: 550) do
      Client.new(bearer_token: app.bearer_token)
    end
  end

end
