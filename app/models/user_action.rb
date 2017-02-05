# Class for association users nad actions
class UserAction < ApplicationRecord
  belongs_to :user
  belongs_to :action

  delegate :name, to: :action
end