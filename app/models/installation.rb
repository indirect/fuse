class Installation < ApplicationRecord
  has_many :repositories, dependent: :delete_all

  def self.from_github!(payload)
    find_or_create_by!(github_id: payload[:id])
  rescue ActiveRecord::RecordNotUnique
    # oh, it got created in a race condition, cool
  end

end
