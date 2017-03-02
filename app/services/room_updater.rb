# Class for updating room
class RoomUpdater
  attr_reader :room
  attr_reader :params

  def initialize(room, params)
    @room = room
    @params = params
  end

  def update
    delete_removed_room_actions
    update_room
  end

  def update_room
    room.update(params)
  end

  def delete_removed_room_actions
    removed_room_actions.destroy_all
  end

  def removed_room_actions
    room.room_actions.where(action_id: removed_action_ids)
  end

  def removed_action_ids
    room.action_ids - params[:action_ids].drop(1).map(&:to_i)
  end
end
