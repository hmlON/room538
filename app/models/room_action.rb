# Room actions are actions that specific room uses
class RoomAction < ApplicationRecord
  belongs_to :room
  belongs_to :action
  has_many :user_actions, dependent: :destroy
  after_create :create_user_actions

  default_scope { includes(:action).order(:action_id) }
  delegate :name, to: :action

  def max_value
    user_actions.pluck(:value).max
  end

  def min_value
    user_actions.pluck(:value).min
  end

  def next_on_user
    user_actions.find_by(value: min_value).user
  end

  private

  def create_user_actions
    room.users.each do |user|
      user_actions.create(user_id: user.id)
    end
  end
end
