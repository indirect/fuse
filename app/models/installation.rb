class Installation < ApplicationRecord

  def self.update_from_github!(payload)
    find_or_create_by!(github_id: payload[:id])
  rescue ActiveRecord::RecordNotUnique
    # oh, it got created in a race condition, cool
  end

end
