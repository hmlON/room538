class AddIdToRoomActions < ActiveRecord::Migration[5.0]
  def change
    add_column :room_actions, :id, :primary_key
  end
end
