# A room is a place where users who live in that room do activities like
# 'taking out trash' with their roommates
#
# == Schema Information
#
# Table name: rooms
#
#  id               :integer   not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  name             :integer   not null
#
class Room < ApplicationRecord
  has_many :users
  has_many :room_activities, dependent: :destroy
  has_many :room_requests, dependent: :destroy

  validates :name, presence: true

  def activities
    Activity.where(room_activity_id: room_activity_ids)
  end

  def room_activities_with_disabled
    RoomActivity.where(room_id: id)
  end

  def create_default_room_activities
    RoomActivity::DEFAULT_ROOM_ACTIVITIES.map do |activity_name|
      room_activities.create(name: activity_name)
    end
  end

  def self.with_invite_token(token)
    all.find { |room_s| room_s.invite_token == token }
  end

  def invite_url
    Rails.application.routes.url_helpers.join_room_url(token: invite_token, host: 'room538.herokuapp.com')
  end

  def invite_token
    Digest::SHA1.hexdigest(id.to_s)[0, 8]
  end
end
