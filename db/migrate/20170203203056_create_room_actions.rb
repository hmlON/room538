class CreateRoomActions < ActiveRecord::Migration[5.0]
  def change
    create_table :room_actions, id: false do |t|
      t.belongs_to :room, foreign_key: true
      t.belongs_to :action, foreign_key: true
    end
  end
end
