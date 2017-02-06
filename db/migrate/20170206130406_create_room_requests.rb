class CreateRoomRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :room_requests do |t|
      t.belongs_to :room, foreign_key: true
      t.integer :sender_id, foreign_key: true

      t.timestamps
    end
  end
end
