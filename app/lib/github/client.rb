require "octokit"

module Github
  class Client < Octokit::Client

    # We just want all of our clients to be able to use the Apps API preview
    def initialize(options)
      options[:default_media_type] ||= "application/vnd.github.machine-man-preview+json"
      super
    end

    # Octokit ignores `default_media_type` while chastising you for not setting a media type.
    # This forces Octokit to respect the fucking default media type you set on instantiation.
    def ensure_api_media_type(type, options)
      options[:accept] ||= default_media_type
      super
    end

  end
end