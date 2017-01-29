class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name

      t.timestamps
    end

    add_reference :users, :room, foreign_key: true
  end
end
