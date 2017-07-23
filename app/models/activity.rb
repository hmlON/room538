# Activity is a record of completed RoomActivity by someone
class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :room_activity

  delegate :name, to: :room_activity
end
