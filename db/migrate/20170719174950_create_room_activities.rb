class CreateRoomActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :room_activities do |t|
      t.string :name
      t.belongs_to :room, foreign_key: true

      t.timestamps
    end
  end
end
