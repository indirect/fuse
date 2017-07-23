require "octokit"

module Github
  class Client < Octokit::Client

    # Octokit ignores `default_media_type` while chastising you for not setting a media type.
    # This forces Octokit to respect the fucking default media type you set on instantiation.
    def ensure_api_media_type(type, options)
      options[:accept] ||= default_media_type
      super
    end

  end
end