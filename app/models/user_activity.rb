# User activity is counter of how many times user has done
# certain activity
class UserActivity
  attr_reader :user, :room_activity

  def initialize(user:, room_activity:)
    @user = user
    @room_activity = room_activity
  end

  def activities
    Activity.where(user: user, room_activity: room_activity)
  end

  def value
    @value ||= activities.count
  end
end
