class CreateTestBuilds < ActiveRecord::Migration[5.1]
  def change
    create_table :test_builds do |t|
      t.string :sha, index: true
      t.bigint :issue_number
      t.bigint :comment_id
      t.belongs_to :repository, foreign_key: true

      t.timestamps
    end
  end
end
