class ChangeUserActionsActionIdToRoomActionId < ActiveRecord::Migration[5.0]
  def change
    rename_column :user_actions, :action_id, :room_action_id
  end
end
