class RemoveRepositoryName < ActiveRecord::Migration[5.1]
  def change
    change_table :repositories do |t|
      t.remove :name
    end
  end
end
