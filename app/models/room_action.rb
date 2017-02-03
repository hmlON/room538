# Class for association rooms nad actions
class RoomAction < ApplicationRecord
  belongs_to :room
  belongs_to :action
end
