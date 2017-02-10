# Class for updating room
class RoomUpdater
  attr_reader :room
  attr_reader :params

  def initialize(room, params)
    @room = room
    @params = params
  end

  def update
    update_room
  end

  def update_room
    room.update(params)
  end
end
