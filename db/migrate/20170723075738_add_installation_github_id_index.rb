class AddInstallationGithubIdIndex < ActiveRecord::Migration[5.1]
  def change
    change_table :installations do |t|
      t.index :github_id
    end
  end
end
