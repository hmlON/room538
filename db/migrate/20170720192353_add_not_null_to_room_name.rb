class AddNotNullToRoomName < ActiveRecord::Migration[5.0]
  def up
    change_column :rooms, :name, :string, null: false
  end

  def down
    change_column :rooms, :name, :string
  end
end
