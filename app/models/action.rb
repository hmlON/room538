# Action is what people do in their rooms.
# e.g.: taking out trash
class Action < ApplicationRecord
  has_many :room_actions, dependent: :destroy
  belongs_to :creator, class_name: 'User', optional: true, foreign_key: :creator_id

  validates :name, presence: true

  DEFAULT_ACTIONS = ['taking out trash',
                     'buying toilet paper',
                     'cleaning room',
                     'buying trash bags',
                     'buying detergent'].freeze
end
