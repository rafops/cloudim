class AddUniqueIndexToInstances < ActiveRecord::Migration[5.1]
  def change
    add_index :instances, [:name, :created_at], unique: true
  end
end
