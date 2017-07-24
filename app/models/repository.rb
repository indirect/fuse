class Repository < ApplicationRecord
  belongs_to :installation
  has_many :test_builds

  def self.import_from_github!(repos, installation_id:)
    repos.map do |repo|
      repo[:github_id] = repo.delete(:id)
      repo[:installation_id] = installation_id
    end

    self.import! repos
  end
end
