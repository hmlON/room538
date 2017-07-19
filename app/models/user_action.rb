# User actions are actions that contain count of how many times user has done
# some action
class UserAction < ApplicationRecord
  belongs_to :user
  belongs_to :room_action

  default_scope { includes(:room_action).order(:id) }
  delegate :name, to: :room_action
end
