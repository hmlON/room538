# Class for updating room
class RoomUpdater
  attr_reader :room
  attr_reader :params

  def initialize(room, params)
    @room = room
    @params = params
  end

  def update
    create_added_user_actions
    delete_removed_user_actions
    update_room
  end

  def update_room
    room.update(params)
  end

  def create_added_user_actions
    room.users.each do |user|
      added_actions.each do |action|
        user.actions << UserAction.create(action: action)
      end
    end
  end

  def delete_removed_user_actions
    room.users.each do |user|
      user.actions.where(action_id: removed_action_ids).destroy_all
    end
  end

  def added_action_ids
    params[:action_ids].drop(1).map(&:to_i) - room.action_ids
  end

  def added_actions
    Action.find(added_action_ids)
  end

  def removed_action_ids
    room.action_ids - params[:action_ids].drop(1).map(&:to_i)
  end
end
