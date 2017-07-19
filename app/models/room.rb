# A hostel room is a place where users who live in that room do actions like
# 'taking out trash' with their roommates
class Room < ApplicationRecord
  has_many :users
  has_many :room_activities, dependent: :destroy
  has_many :room_actions, dependent: :destroy
  has_many :actions, through: :room_actions
  has_many :room_requests, dependent: :destroy

  validates :name, presence: true

  def invite_url
    Rails.application.routes.url_helpers.join_room_url(token: invite_token, host: 'room538.herokuapp.com')
  end

  def invite_token
    Digest::SHA1.hexdigest(id.to_s)[0, 8]
  end
end
