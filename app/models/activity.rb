# Activity is a record of completed RoomActivity by someone
#
# == Schema Information
#
# Table name: activities
#
#  id               :integer   not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  user_id          :integer
#  room_activity_id :integer
#
class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :room_activity

  delegate :name, to: :room_activity
end
