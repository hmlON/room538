# User is a preson, who lives in a hostel room
class User < ApplicationRecord
  belongs_to :room, optional: true
  has_many :user_actions
  alias actions user_actions
  has_many :sent_room_requests, class_name: 'RoomRequest', foreign_key: 'sender_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  def join_room(room)
    room.users << self
    room.actions.each do |action|
      actions << UserAction.create(action: action)
    end
    sent_room_requests.destroy_all
  end

  def leave_room
    user_actions.destroy_all
    update(room: nil)
  end

  def room?
    room_id != nil
  end
end
