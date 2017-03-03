# A hostel room is a place where users who live in that room do actions like
# 'taking out trash' with their roommates
class Room < ApplicationRecord
  has_many :users
  has_many :room_actions, dependent: :destroy
  has_many :actions, through: :room_actions
  has_many :room_requests, dependent: :destroy

  validates :name, presence: true

  include PublicActivity::Common
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy
end
