# Room activities are activities that room uses
class RoomActivity < ApplicationRecord
  belongs_to :room
  has_many :activities

  delegate :users, to: :room

  def user_activities
    @user_activities ||= users.map { |user| UserActivity.new(user: user, room_activity: self) }
  end

  def min_value
    user_activities.map(&:value).min
  end

  def max_value
    user_activities.map(&:value).max
  end

  def next_on_user
    user_activities.find { |user_activity| user_activity.value == min_value }
                   .user
  end
end
