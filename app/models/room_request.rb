# Room requests are requests for joining the room
class RoomRequest < ApplicationRecord
  belongs_to :room
  belongs_to :sender, class_name: 'User'
end
