class AddInstallationGithubIdIndex < ActiveRecord::Migration[5.1]
  def change
    change_table :installations do |t|
      t.index :github_id, unique: true
    end
  end
end
