# Class for association users nad actions
class UserAction < ApplicationRecord
  belongs_to :user
  belongs_to :action

  delegate :name, to: :action
  default_scope { includes(:action).order(:id) }

  include PublicActivity::Common
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy
end
