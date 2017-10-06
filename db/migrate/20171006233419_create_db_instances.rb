class CreateDbInstances < ActiveRecord::Migration[5.1]
  def change
    create_table :db_instances do |t|
      t.string :name

      t.timestamps
    end
  end
end
