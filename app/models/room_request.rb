# Room requests are requests for joining the room
#
# == Schema Information
#
# Table name: room_requests
#
#  id               :integer   not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  room_id          :integer
#  sender_id        :integer
#
class RoomRequest < ApplicationRecord
  belongs_to :room
  belongs_to :sender, class_name: 'User'
end
