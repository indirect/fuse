module Current
  thread_mattr_accessor :github_app

  def self.github
    return @github if @github && @github_expires_at < Time.now

    @github_expires_at = Time.now + 10.minutes
    @github = Github::Client.new(
      bearer_token: github_app.bearer_token,
      default_media_type: "application/vnd.github.machine-man-preview+json"
    )
  end

end
