# Action is what people do in their rooms.
# e.g.: taking out trash
class Action < ApplicationRecord
  has_many :room_actions
  has_many :rooms, through: :room_actions

  validates :name, presence: true

  DEFAULT_ACTIONS = ['taking out trash',
                     'buying toilet paper',
                     'cleaning room',
                     'buying trash bags',
                     'buying detergent'].freeze
end