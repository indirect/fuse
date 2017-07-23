class CreateRepositories < ActiveRecord::Migration[5.1]
  def change
    create_table :repositories do |t|
      t.belongs_to :installation, foreign_key: true
      t.bigint :github_id, index: true
      t.string :full_name, index: true
      t.string :name

      t.timestamps
    end
  end
end
