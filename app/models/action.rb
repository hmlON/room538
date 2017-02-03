# Action is what people do in their rooms.
# e.g.: taking out trash
class Action < ApplicationRecord
  validate :name, presence: true
end
