# Class for association users nad actions
class UserAction < ApplicationRecord
  include PublicActivity::Common

  belongs_to :user
  belongs_to :action

  default_scope { includes(:action).order(:id) }
  delegate :name, to: :action
end
