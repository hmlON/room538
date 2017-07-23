class DropAllActionsTables < ActiveRecord::Migration[5.0]
  def up
    drop_table :user_actions
    drop_table :room_actions
    drop_table :actions
  end

  def down
  end
end
