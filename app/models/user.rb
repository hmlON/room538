# User is a preson, who lives in a hostel room
class User < ApplicationRecord
  belongs_to :room, optional: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :password, presence: true
  validates :name, presence: true

  def room?
    room_id != nil
  end
end
