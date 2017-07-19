# User activities are actions that count of how many times user has done
# some activity
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
    activities.count
  end
end
