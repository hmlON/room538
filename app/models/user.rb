# User is a preson, who lives in a hostel room
class User < ApplicationRecord
  belongs_to :room, optional: true
  has_many :user_actions
  alias actions user_actions

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  def room?
    room_id != nil
  end
end
