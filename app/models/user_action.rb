# User actions are actions that contain count of how many times user has done
# some action
class UserAction < ApplicationRecord
  belongs_to :user
  belongs_to :room_action

  default_scope { includes(:room_action) }
  delegate :name, to: :room_action

  include PublicActivity::Common
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy
end
