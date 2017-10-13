class AddLaunchTimeToInstance < ActiveRecord::Migration[5.1]
  def change
    add_column :instances, :launch_time, :datetime
  end
end
