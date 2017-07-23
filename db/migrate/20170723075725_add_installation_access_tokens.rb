class AddInstallationAccessTokens < ActiveRecord::Migration[5.1]
  def change
    change_table :installations do |t|
      t.string :access_token
      t.timestamp :access_token_expires_at
    end
  end
end
