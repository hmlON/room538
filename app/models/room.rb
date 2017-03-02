# A hostel room is a place where users who live in that room do actions like
# 'taking out trash' with their roommates
class Room < ApplicationRecord
  has_many :users
  has_many :room_actions, dependent: :destroy
  has_many :room_requests, dependent: :destroy

  validates :name, presence: true
end
