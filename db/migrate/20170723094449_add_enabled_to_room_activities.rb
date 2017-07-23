class AddEnabledToRoomActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :room_activities, :enabled, :boolean, default: true
  end
end
