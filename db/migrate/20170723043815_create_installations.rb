class CreateInstallations < ActiveRecord::Migration[5.1]
  def change
    create_table :installations do |t|
      t.bigint :github_id
      t.bigint :target_id
      t.string :repository_selection
      t.string :target_type
      t.timestamps
    end
  end
end
