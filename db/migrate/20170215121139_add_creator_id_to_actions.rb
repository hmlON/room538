class AddCreatorIdToActions < ActiveRecord::Migration[5.0]
  def change
    add_column :actions, :creator_id, :integer
  end
end
