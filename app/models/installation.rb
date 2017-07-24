class Installation < ApplicationRecord
  has_many :repositories, dependent: :delete_all

  def self.from_github!(payload)
    find_or_create_by!(github_id: payload[:id])
  rescue ActiveRecord::RecordNotUnique
    # oh, it got created in a race condition, cool
  end

  def client
    if access_token_expired?
      generate_new_access_token!
      @client = nil
    end

    @client ||= Github::Client.new(access_token: access_token)
  end

  def access_token_expired?
    access_token.nil? || access_token_expires_at.nil? || access_token_expires_at < Time.now
  end

  def generate_new_access_token!
    token = Github.app_client.create_installation_access_token(github_id)
    update!(access_token: token[:token], access_token_expires_at: token[:expires_at])
  end

end
