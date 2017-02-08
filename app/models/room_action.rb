# Class for association rooms nad actions
class RoomAction < ApplicationRecord
  belongs_to :room
  belongs_to :action

  delegate :name, to: :action

  def user_actions
    ids = room.users.includes(:user_actions).pluck('user_actions.id')
    UserAction.where(id: ids).where(action_id: action_id)
  end

  def max_value
    user_actions.pluck(:value).max
  end

  def min_value
    user_actions.pluck(:value).min
  end
end
