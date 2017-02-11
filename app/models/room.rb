# A hostel room is a place where users who live in that room do actions like
# 'taking out trash' with their roommates
class Room < ApplicationRecord
  has_many :users
  has_many :room_actions
  has_many :actions, through: :room_actions
  has_many :room_requests, dependent: :destroy

  validates :name, presence: true

  def destroy
    self.actions = []
    super
  end
end
