class CreateInstallations < ActiveRecord::Migration[5.1]
  def change
    create_table :installations do |t|
      t.bigint :github_id, null: false
      t.timestamps
    end
  end
end
