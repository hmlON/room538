# Class for association users nad actions
class UserAction < ApplicationRecord
  belongs_to :user
  belongs_to :action

  default_scope { includes(:action) }
  delegate :name, to: :action
end
