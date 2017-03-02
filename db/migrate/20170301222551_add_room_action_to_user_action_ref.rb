class AddRoomActionToUserActionRef < ActiveRecord::Migration[5.0]
  def change
    drop_table :user_actions do |t|
      t.integer  'user_id'
      t.integer  'room_action_id'
      t.integer  'value', default: 0
      t.timestamps
    end

    create_table :user_actions do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :room_action, foreign_key: true
      t.integer :value, default: 0

      t.timestamps
    end
  end
end
