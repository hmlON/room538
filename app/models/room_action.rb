# Room actions are actions that specific room uses
class RoomAction < ApplicationRecord
  belongs_to :room
  belongs_to :action
  has_many :user_actions

  default_scope { includes(:action).order(:action_id) }
  delegate :name, to: :action

  # def user_actions
  #   ids = room.users.includes(:user_actions).pluck('user_actions.id')
  #   UserAction.where(id: ids).where(action_id: action_id)
  # end

  def max_value
    user_actions.pluck(:value).max
  end

  def min_value
    user_actions.pluck(:value).min
  end

  def next_on_user
    user_actions.find_by(value: min_value).user
  end
end
